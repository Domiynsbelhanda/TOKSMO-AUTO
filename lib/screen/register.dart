import 'dart:io';
import 'package:car_rental_rdc/screen/MainScreen.dart';
import 'package:car_rental_rdc/widget/ProgressDialog.dart';
import 'package:car_rental_rdc/widget/TaxiButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_select/smart_select.dart';
import 'package:connectivity/connectivity.dart';

import '../globalvariabels.dart';
import 'LoginPage.dart';
import 'MyProfileCard.dart';

class RegisterPage extends StatefulWidget{
  static const String id = 'register';

  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage>{
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
    
  var fullNameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  String user_type = 'UTILISATEUR';
  List<S2Choice<String>> options = [
    S2Choice<String>(value: 'UTILISATEUR', title: 'Utilisateur'),
    S2Choice<String>(value: 'PARTICULIER', title: 'Particulier'),
    S2Choice<String>(value: 'ENTREPRISE', title: 'Entreprise'),
    S2Choice<String>(value: 'SOCIETE', title: 'Société'),
    S2Choice<String>(value: 'ETABLISSEMENT', title: 'Etablissement'),
  ];

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
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.width / 15),
                
                GestureDetector(
                  child : circleImage(context),
                  onTap: getImage
                ),
                Text("Photo de profil"),

                SizedBox(height: MediaQuery.of(context).size.width / 15,),

                Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width / 22),
                  child: Card(
                    elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: fullNameController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  labelText: 'Nom complet',
                                  labelStyle: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width / 23,
                                    color: Colors.grey,
                                  ),
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: MediaQuery.of(context).size.width / 25
                                  )
                              ),
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width / 22,
                                  color: Colors.black),
                            ),

                            SizedBox(height: 5.0),

                            TextField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  labelText: 'N° Téléphone',
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: MediaQuery.of(context).size.width / 23,
                                  ),
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: MediaQuery.of(context).size.width / 25
                                  )
                              ),
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width / 22,
                                  color: Colors.black),
                            ),

                            SizedBox(height: 5.0),

                            TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  labelText: 'Adresse mail',
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: MediaQuery.of(context).size.width / 23,
                                  ),
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: MediaQuery.of(context).size.width / 25
                                  )
                              ),
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width / 22,
                                  color: Colors.black),
                            ),

                            SizedBox(height: 5.0),

                                SmartSelect<String>.single(
                                  title: 'Type de compte : ',
                                  value: user_type,
                                  choiceItems: options,
                                  onChange: (state) => setState(() => user_type = state.value)
                                ),

                            SizedBox(height: 5.0),

                            TextField(
                              obscureText: true,
                              controller: passwordController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  labelText: 'Mot de passe',
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: MediaQuery.of(context).size.width / 23,
                                  ),
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: MediaQuery.of(context).size.width / 25
                                  )
                              ),
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width / 22,
                                  color: Colors.black),
                            ),

                            SizedBox(height: 5.0),

                            TextField(
                              obscureText: true,
                              controller: confirmPasswordController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  labelText: 'Confirmation Mot de passe',
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: MediaQuery.of(context).size.width / 23,
                                  ),
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: MediaQuery.of(context).size.width / 25
                                  )
                              ),
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width / 22,
                                  color: Colors.black),
                            ),

                            SizedBox(height: 5.0),
                          ],
                        )
                      )
                  ),
                ),

                TaxiButton(
                          title: 'INSCRIPTION',
                          color: Colors.black,
                          onPressed: () async{


                            if(fullNameController.text.length < 3){
                              Fluttertoast.showToast(msg:'Entrez un nom valide.');
                              return;
                            }

                            if(phoneController.text.length < 10){
                              Fluttertoast.showToast(msg:'Entrez un numéro de contact valide.');
                              return;
                            }

                            if(!emailController.text.contains('@')){
                              Fluttertoast.showToast(msg:'Entrez un adresse mail valide.');
                              return;
                            }

                            if(passwordController.text.length < 6){
                              Fluttertoast.showToast(msg:'Le mot de passe doit contenir au moins 8 caractère.');
                              return;
                            }

                            if(confirmPasswordController.text != passwordController.text){
                              Fluttertoast.showToast(msg:'Mot de passe de confirmation différent.');
                              return;
                            }

                            if(_image.path.isEmpty){
                              Fluttertoast.showToast(msg:'Selectionner un image.');
                              return;
                            }

                            registerUser();

                          },
                        ),

                FlatButton(
                    onPressed: (){
                      Navigator.pushNamedAndRemoveUntil(context, LoginPage.id, (route) => false);
                    },
                    child: Text('Vous avez un compte? Log in',  style: TextStyle(color: Colors.black))
                ),


              ],
            ),
          ),
        ),
      ),
    ); 
  }

  void registerUser() async {

    //show please wait dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(status: 'Enregistrement en cours...',),
    );

    final User user = (await _auth.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    ).catchError((ex){

      //check error and display message
      Navigator.pop(context);
      PlatformException thisEx = ex;
      Fluttertoast.showToast(msg: thisEx.message);

    })).user;

    Navigator.pop(context);
    // check if user registration is successful
    if(user != null){

      var url = await uploadFile(_image, user.uid);

      //Prepare data to be saved on users table
      var data = {
        'name': fullNameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'type': user_type,
        'image': url.toString()
      };

      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      await _firestore.collection('Users').doc(user.uid.toString()).set(data);

      currentFirebaseUser = user;

      Navigator.pushNamed(context, MainScreen.id);

    }
  }

  Future<String> uploadFile(file, uid) async{

      // Create a Reference to the file
      firebase_storage.Reference postImageRef = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('profile')
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