import 'dart:io';

import 'package:car_rental_rdc/widget/ProgressDialog.dart';
import 'package:car_rental_rdc/widget/TaxiButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_select/smart_select.dart';
import 'package:uuid/uuid.dart';

import '../globalvariabels.dart';
import 'MainScreen.dart';

class AddingElement extends StatefulWidget{

  static const String id = 'adding';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddingElement();
  }
}

class _AddingElement extends State<AddingElement>{

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();


  String type = 'vehicule';

  var marqueController = TextEditingController();

  File _image;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        Fluttertoast.showToast(msg: "No image selected");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.width / 15),

                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        border: Border.all(
                          color: Colors.grey[300],
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        color: Colors.black,
                        size: 28,
                      )
                  ),
                ),

                SizedBox(height: 10.0),

                Center(
                  child: GestureDetector(
                      child : circleImage(context),
                      onTap: getImage
                  ),
                ),

                Center(child: Text("Logo de la marque")),

                SizedBox(height: 10.0,),

                Center(
                  child: Text(
                    'Ajoute une marque',
                    style: TextStyle(
                      fontSize: 20.0
                    )
                  ),
                ),

                SizedBox(height: 10.0),

                TextField(
                  controller: marqueController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'Nom de la marque',
                      labelStyle: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 23,
                        color: Colors.grey,
                      ),
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: MediaQuery.of(context).size.width / 25
                      )
                  ),
                  style: TextStyle(fontSize: MediaQuery.of(context).size.width / 22),
                ),

                SizedBox(height: 10.0),

                SmartSelect<String>.single(
                    title: 'TYPE : ',
                    value: type,
                    choiceItems: optionss,
                    onChange: (state) => setState(() => type = state.value)
                ),

                SizedBox(height: 20.0),

                TaxiButton(
                  title: 'AJOUTER',
                  color: Colors.black,
                  onPressed: () async {
                    if(marqueController.text.length < 1 || marqueController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Entrez la marque");
                      return;
                    }

                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) => ProgressDialog(status: 'Enregistrement en cours...',),
                    );

                    var uid = Uuid().v4();
                    var url = await uploadFile(_image, uid);

                    var data = {
                      'marque': marqueController.text,
                      'image': url.toString(),
                      'type': type
                    };

                    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
                    await _firestore.collection('Marques').doc(uid.toString()).set(data);

                    Navigator.pop(context);

                    Navigator.pushNamed(context, MainScreen.id);

                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> uploadFile(file, uid) async{

    // Create a Reference to the file
    Reference postImageRef = FirebaseStorage.instance
        .ref()
        .child('marques')
        .child('/$uid.jpg');

    //final firebase_storage.UploadTask uploadTask = postImageRef.putFile(file);

    TaskSnapshot storageTaskSnapshot = await postImageRef.putFile(file);
    // TaskSnapshot storageTaskSnapshot =  uploadTask.snapshot;

    print("printing : " + storageTaskSnapshot.ref.getDownloadURL().toString());

    var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
    return downloadUrl.toString();
  }

  Widget circleImage(context){
    return Container(
        height: MediaQuery.of(context).size.width / 4,
        width: MediaQuery.of(context).size.width / 4,
        margin: EdgeInsets.only(
            left: 5.0,
            right: 5.0
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            border: Border.all(
                width: 2.0,
                style:BorderStyle.solid ,
                color: Color.fromARGB(255, 0 , 0, 0)
            ),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: _image == null ?
                NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/car-rental-rdc.appspot.com/o/account_circle_icon_137996.png?alt=media&token=bb0f8b55-fe7a-42eb-9c3a-b195f98235e8"
                )
                    : FileImage(_image)
            )
        )
    );
  }
}