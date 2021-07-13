import 'dart:io';

import 'package:car_rental_rdc/globalvariabels.dart';
import 'package:car_rental_rdc/widget/ProgressDialog.dart';
import 'package:car_rental_rdc/widget/TaxiButton.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:smart_select/smart_select.dart';
import 'package:uuid/uuid.dart';

import 'MainScreen.dart';

class PublicationPage extends StatefulWidget{
  static const String id = 'publication';

  _PublicationPage createState() => _PublicationPage();
}

class _PublicationPage extends State<PublicationPage>{

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();


  var etatController = TextEditingController();
  var prixController = TextEditingController();
  var type_carrosserieController = TextEditingController();
  var modeleController = TextEditingController();
  var poignetController = TextEditingController();
  var carburantController = TextEditingController();
  var couleurController = TextEditingController();
  var kilometrageController = TextEditingController();
  var boite_vitesseController = TextEditingController();
  var nombre_siegeController = TextEditingController();
  var nombre_porteController = TextEditingController();
  var anneeController = TextEditingController();
  var cylindreController = TextEditingController();
  String type = 'vehicule';
  String object = 'VOITURE';
  String marque = "Toyota";

  List<S2Choice<String>> optionss = [
    S2Choice<String>(value: 'vehicule', title: 'VEHICULE'),
    S2Choice<String>(value: 'engin', title: 'ENGIN'),
    S2Choice<String>(value: 'camion', title: 'CAMION'),
  ];

  List<S2Choice<String>> options = [
    S2Choice<String>(value: 'voiture', title: 'VOITURE'),
    S2Choice<String>(value: 'piece', title: 'PIECE'),
    S2Choice<String>(value: 'accessoire', title: 'ACCESSOIRE'),
    S2Choice<String>(value: 'location', title: 'MISE EN LOCATION'),
  ];

  List<S2Choice<String>> marques = [];

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

  List<Media> _listImagePaths;
  List<String> images = [];

  @override
  void initState() {
    FirebaseFirestore.instance.collection('Marques').get()
    .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        marques.add(
          S2Choice<String>(value: '${doc["marque"]}', title: '${doc["marque"].toString().toUpperCase()}'),
        );
      });
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
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                SmartSelect<String>.single(
                  title: 'OBJET : ',
                  value: object,
                  choiceItems: options,
                  onChange: (state) => setState(() => object = state.value)
                ),

                SizedBox(height: MediaQuery.of(context).size.width / 15),

                _listImagePaths == null ?
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      selectImages(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      color: Colors.pink,
                      child: Text(
                        '+ Choisir 3 images'.toUpperCase(),
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 15,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ) : SizedBox(),

                SizedBox(height: 10),

                _listImagePaths == null ?
                Center(
                  child: Text(
                    'Veuillez choisir 3 images',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                )
                    :
                _listImagePaths != null && _listImagePaths.length < 3 ?
                Center(
                  child: Text(
                    '3 images',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                )
                    :
                CarouselSlider(
                  options: CarouselOptions(
                      height: MediaQuery.of(context).size.width / 2.2,
                      autoPlay: false,
                      enlargeCenterPage: false,
                      pageSnapping: true
                  ),
                  items: _listImagePaths.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Card(
                          elevation: 5.0,
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Image(
                                image: FileImage(File(i.path)),
                                fit: BoxFit.fitWidth,
                              )
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),

                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: SmartSelect<String>.single(
                      title: 'MARQUE : ',
                      value: marque,
                      choiceItems: marques,
                      onChange: (state) => setState(() => marque = state.value)
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      object == "piece" ? Container() :
                      object == "accessoire" ? Container() :
                      SmartSelect<String>.single(
                        title: 'TYPE : ',
                        value: type,
                        choiceItems: optionss,
                        onChange: (state) => setState(() => type = state.value)
                      ),

                      SizedBox(height: 5.0),

                      TextField(
                        controller: etatController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: object == "piece" ? 'Etat' : 'Etat ($type)',
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

                      SizedBox(height: 5.0),

                      TextField(
                        controller: prixController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Prix',
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

                      SizedBox(height: 5.0),

                      object == "piece" ? Container() :
                      object == "accessoire" ? Container() :
                      SizedBox(height: 5.0),

                      object == "piece" ? Container() :
                      object == "accessoire" ? Container() :
                      TextField(
                        controller: type_carrosserieController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Type Carrosserie',
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

                      SizedBox(height: 5.0),

                      TextField(
                        controller: modeleController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Modele',
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

                      object == "piece" ? Container() :
                      object == "accessoire" ? Container() :
                      SizedBox(height: 5.0),

                      object == "piece" ? Container() :
                      object == "accessoire" ? Container() :
                      TextField(
                        controller: poignetController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Poignet',
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

                      object == "piece" ? Container() :
                      object == "accessoire" ? Container() :
                      SizedBox(height: 5.0),

                      object == "piece" ? Container() :
                      object == "accessoire" ? Container() :
                      TextField(
                        controller: carburantController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Carburant',
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

                      object == "piece" ? Container() :
                      SizedBox(height: 5.0),

                      object == "piece" ? Container() :
                      TextField(
                        controller: couleurController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Couleur',
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

                      object == "piece" ? Container() :
                      object == "accessoire" ? Container() :
                      SizedBox(height: 5.0),

                      object == "piece" ? Container() :
                      object == "accessoire" ? Container() :
                      TextField(
                        controller: kilometrageController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Kilometrage',
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

                      object == "piece" ? Container() :
                      object == "accessoire" ? Container() :
                      SizedBox(height: 5.0),

                      object == "piece" ? Container() :
                      object == "accessoire" ? Container() :
                      TextField(
                        controller: boite_vitesseController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Boite de vitesse',
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

                      object == "piece" ? Container() :
                      object == "accessoire" ? Container() :
                      SizedBox(height: 5.0),

                      object == "piece" ? Container() :
                      object == "accessoire" ? Container() :
                      type =="engin" ? Container() :
                      TextField(
                        controller: nombre_siegeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: type =="track" ? 'Nombre de roues' : type =="camion" ? 'Nombre de roues' : 'Nombre de siège',
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

                      object == "piece" ? Container() :
                      object == "accessoire" ? Container() :
                      type =="engin" ? Container() :
                      type =="track" ? Container() :
                      type =="camion" ? Container() :
                      SizedBox(height: 5.0),

                      object == "piece" ? Container() :
                      object == "accessoire" ? Container() :
                      type =="engin" ? Container() :
                      type =="track" ? Container() :
                      type =="camion" ? Container() :
                      TextField(
                        controller: nombre_porteController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Nombre des portes',
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

                      object == "piece" ? Container() :
                      object == "accessoire" ? Container() :
                      SizedBox(height: 5.0),

                      object == "piece" ? Container() :
                      object == "accessoire" ? Container() :
                      TextField(
                        controller: anneeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Année',
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

                      object == "piece" ? Container() :
                      object == "accessoire" ? Container() :
                      SizedBox(height: 5.0),

                      object == "piece" ? Container() :
                      object == "accessoire" ? Container() :
                      TextField(
                        controller: cylindreController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Cylindre',
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

                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TaxiButton(
                      title: 'PUBLIER',
                      color: Colors.red,
                      onPressed: () async
                      {
                          /*if(
                            etatController.text.isEmpty ||
                            prixController.text.isEmpty ||
                            marqueController.text.isEmpty ||
                            type_carrosserieController.text.isEmpty ||
                            modeleController.text.isEmpty ||
                            poignetController.text.isEmpty ||
                            carburantController.text.isEmpty ||
                            couleurController.text.isEmpty ||
                            kilometrageController.text.isEmpty ||
                            boite_vitesseController.text.isEmpty ||
                            nombre_siegeController.text.isEmpty ||
                            nombre_porteController.text.isEmpty ||
                            anneeController.text.isEmpty ||
                            cylindreController.text.isEmpty
                            ){
                            Fluttertoast.showToast(msg: "Completez tous les champs");
                            return;
                          }*/

                          if(_listImagePaths == null){
                            Fluttertoast.showToast(msg: "Selectionnez 3 images");
                            return;
                          }

                          if(object == 'voiture'){
                            if(type == 'vehicule'){
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) => ProgressDialog(status: 'Enregistrement en cours...',),
                              );

                              int indice = 0;

                              for(var i in _listImagePaths){
                                var uuid = Uuid();
                                String uid = uuid.v1();
                                indice += 1;
                                String url;
                                final Reference postImageRef = FirebaseStorage.instance.ref().child("Datas");
                                final TaskSnapshot uploadTask = await postImageRef
                                    .child('${uid}_${indice}jpg').putFile(File(i.path));
                                var ImageUrl = await uploadTask.ref.getDownloadURL();
                                url = ImageUrl.toString();
                                images.add(url);
                                if (images.length == 3){
                                  var data = {
                                    'etat': etatController.text,
                                    'prix': prixController.text,
                                    'marque': marque,
                                    'carrosserie': type_carrosserieController.text,
                                    'modele': modeleController.text,
                                    'poignet': poignetController.text,
                                    'carburant': carburantController.text,
                                    'couleur': couleurController.text,
                                    'kilometrage': kilometrageController.text,
                                    'boite_vitesse': boite_vitesseController.text,
                                    'nombre_siege': nombre_siegeController.text,
                                    'nombre_porte': nombre_porteController.text,
                                    'annee': anneeController.text,
                                    'cylindre': cylindreController.text,
                                    'image': images,
                                    'disponible': true,
                                    'uid': currentUser.id,
                                    'email': currentUser.email,
                                    'phone': currentUser.phone,
                                    'user_image': currentUser.image,
                                    'fullName': currentUser.fullName,
                                    'objet': object,
                                    'type': type,
                                    "timestamp": FieldValue.serverTimestamp(),
                                  };

                                  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
                                  await _firestore.collection('Datas').add(data);

                                  Navigator.pop(context);

                                  Navigator.pushNamed(context, MainScreen.id);
                                  Fluttertoast.showToast(msg: 'Publication effectuée');
                                }
                              }

                              //Prepare data to be saved on users table

                            }
                            else if(type == 'engin'){
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) => ProgressDialog(status: 'Enregistrement en cours...',),
                              );

                              int indice = 0;


                              for(var i in _listImagePaths){
                                var uuid = Uuid();
                                String uid = uuid.v1();
                                indice += 1;
                                String url;
                                final Reference postImageRef = FirebaseStorage.instance.ref().child("Datas");
                                final TaskSnapshot uploadTask = await postImageRef
                                    .child('${uid}_${indice}jpg').putFile(File(i.path));
                                var ImageUrl = await uploadTask.ref.getDownloadURL();
                                url = ImageUrl.toString();
                                images.add(url);
                                if (images.length == 3){
                                  var data = {
                                    'etat': etatController.text,
                                    'prix': prixController.text,
                                    'marque': marque,
                                    'carrosserie': type_carrosserieController.text,
                                    'modele': modeleController.text,
                                    'poignet': poignetController.text,
                                    'carburant': carburantController.text,
                                    'couleur': couleurController.text,
                                    'kilometrage': kilometrageController.text,
                                    'boite_vitesse': boite_vitesseController.text,
                                    'annee': anneeController.text,
                                    'cylindre': cylindreController.text,
                                    'image': images,
                                    'disponible': true,
                                    'uid': currentUser.id,
                                    'email': currentUser.email,
                                    'phone': currentUser.phone,
                                    'user_image': currentUser.image,
                                    'fullName': currentUser.fullName,
                                    'objet': object,
                                    'type': type,
                                    "timestamp": FieldValue.serverTimestamp(),
                                  };

                                  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
                                  await _firestore.collection('Datas').add(data);

                                  Navigator.pop(context);

                                  Navigator.pushNamed(context, MainScreen.id);
                                  Fluttertoast.showToast(msg: 'Publication effectuée');
                                }
                              }
                            }
                            else if(type == 'camion'){
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) => ProgressDialog(status: 'Enregistrement en cours...',),
                              );

                              int indice = 0;

                              for(var i in _listImagePaths){
                                var uuid = Uuid();
                                String uid = uuid.v1();
                                indice += 1;
                                String url;
                                final Reference postImageRef = FirebaseStorage.instance.ref().child("Datas");
                                final TaskSnapshot uploadTask = await postImageRef
                                    .child('${uid}_${indice}jpg').putFile(File(i.path));
                                var ImageUrl = await uploadTask.ref.getDownloadURL();
                                url = ImageUrl.toString();
                                images.add(url);
                                if (images.length == 3){
                                  var data = {
                                    'etat': etatController.text,
                                    'prix': prixController.text,
                                    'marque': marque,
                                    'carrosserie': type_carrosserieController.text,
                                    'modele': modeleController.text,
                                    'poignet': poignetController.text,
                                    'carburant': carburantController.text,
                                    'couleur': couleurController.text,
                                    'kilometrage': kilometrageController.text,
                                    'boite_vitesse': boite_vitesseController.text,
                                    'nombre_roue': nombre_siegeController.text,
                                    'annee': anneeController.text,
                                    'cylindre': cylindreController.text,
                                    'image': url.toString(),
                                    'disponible': true,
                                    'uid': currentUser.id,
                                    'email': currentUser.email,
                                    'phone': currentUser.phone,
                                    'user_image': currentUser.image,
                                    'fullName': currentUser.fullName,
                                    'objet': object,
                                    'type': type,
                                    "timestamp": FieldValue.serverTimestamp(),
                                  };

                                  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
                                  await _firestore.collection('Datas').add(data);

                                  Navigator.pop(context);

                                  Navigator.pushNamed(context, MainScreen.id);
                                  Fluttertoast.showToast(msg: 'Publication effectuée');
                                }
                              }
                            }
                          }
                          else if (object == 'piece'){
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) => ProgressDialog(status: 'Enregistrement en cours...',),
                              );

                              int indice = 0;

                              for(var i in _listImagePaths){
                                var uuid = Uuid();
                                String uid = uuid.v1();
                                indice += 1;
                                String url;
                                final Reference postImageRef = FirebaseStorage.instance.ref().child("Datas");
                                final TaskSnapshot uploadTask = await postImageRef
                                    .child('${uid}_${indice}jpg').putFile(File(i.path));
                                var ImageUrl = await uploadTask.ref.getDownloadURL();
                                url = ImageUrl.toString();
                                images.add(url);
                                if (images.length == 3){
                                  var data = {
                                    'etat': etatController.text,
                                    'prix': prixController.text,
                                    'marque': marque,
                                    'modele': modeleController.text,
                                    'image': url.toString(),
                                    'disponible': true,
                                    'uid': currentUser.id,
                                    'email': currentUser.email,
                                    'phone': currentUser.phone,
                                    'user_image': currentUser.image,
                                    'fullName': currentUser.fullName,
                                    'objet': object,
                                    'type': type,
                                    "timestamp": FieldValue.serverTimestamp(),
                                  };

                                  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
                                  await _firestore.collection('Datas').add(data);

                                  Navigator.pop(context);

                                  Navigator.pushNamed(context, MainScreen.id);
                                  Fluttertoast.showToast(msg: 'Publication effectuée');
                                }
                              }
                          }
                          else if (object == 'accessoire')
                          {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) => ProgressDialog(status: 'Enregistrement en cours...',),
                              );

                            int indice = 0;

                            for(var i in _listImagePaths){
                              var uuid = Uuid();
                              String uid = uuid.v1();
                              indice += 1;
                              String url;
                              final Reference postImageRef = FirebaseStorage.instance.ref().child("Datas");
                              final TaskSnapshot uploadTask = await postImageRef
                                  .child('${uid}_${indice}jpg').putFile(File(i.path));
                              var ImageUrl = await uploadTask.ref.getDownloadURL();
                              url = ImageUrl.toString();
                              images.add(url);
                              if (images.length == 3){
                                var data = {
                                  'etat': etatController.text,
                                  'prix': prixController.text,
                                  'marque': marque,
                                  'modele': modeleController.text,
                                  'couleur': couleurController.text,
                                  'image': url.toString(),
                                  'disponible': true,
                                  'uid': currentUser.id,
                                  'email': currentUser.email,
                                  'phone': currentUser.phone,
                                  'user_image': currentUser.image,
                                  'fullName': currentUser.fullName,
                                  'objet': object,
                                  'type': type,
                                  "timestamp": FieldValue.serverTimestamp(),
                                };

                                final FirebaseFirestore _firestore = FirebaseFirestore.instance;
                                await _firestore.collection('Datas').add(data);

                                Navigator.pop(context);

                                Navigator.pushNamed(context, MainScreen.id);
                                Fluttertoast.showToast(msg: 'Publication effectuée');
                              }
                            }
                          }
                          else if (object == 'location')
                          {

                            if(type == 'vehicule'){

                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) => ProgressDialog(status: 'Enregistrement en cours...',),
                              );

                              int indice = 0;

                              for(var i in _listImagePaths){
                                var uuid = Uuid();
                                String uid = uuid.v1();
                                indice += 1;
                                String url;
                                final Reference postImageRef = FirebaseStorage.instance.ref().child("Datas");
                                final TaskSnapshot uploadTask = await postImageRef
                                    .child('${uid}_${indice}jpg').putFile(File(i.path));
                                var ImageUrl = await uploadTask.ref.getDownloadURL();
                                url = ImageUrl.toString();
                                images.add(url);
                                if (images.length == 3){
                                  var data = {
                                    'etat': etatController.text,
                                    'prix': prixController.text,
                                    'marque': marque,
                                    'carrosserie': type_carrosserieController.text,
                                    'modele': modeleController.text,
                                    'poignet': poignetController.text,
                                    'carburant': carburantController.text,
                                    'couleur': couleurController.text,
                                    'kilometrage': kilometrageController.text,
                                    'boite_vitesse': boite_vitesseController.text,
                                    'nombre_siege': nombre_siegeController.text,
                                    'nombre_porte': nombre_porteController.text,
                                    'annee': anneeController.text,
                                    'cylindre': cylindreController.text,
                                    'image': images,
                                    'disponible': true,
                                    'uid': currentUser.id,
                                    'email': currentUser.email,
                                    'phone': currentUser.phone,
                                    'user_image': currentUser.image,
                                    'fullName': currentUser.fullName,
                                    'objet': object,
                                    'type': type,
                                    "timestamp": FieldValue.serverTimestamp(),
                                  };

                                  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
                                  await _firestore.collection('Datas').add(data);

                                  Navigator.pop(context);

                                  Navigator.pushNamed(context, MainScreen.id);
                                  Fluttertoast.showToast(msg: 'Publication effectuée');
                                }
                              }
                            } else if(type == 'engin'){

                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) => ProgressDialog(status: 'Enregistrement en cours...',),
                              );

                              int indice = 0;


                              for(var i in _listImagePaths){
                                var uuid = Uuid();
                                String uid = uuid.v1();
                                indice += 1;
                                String url;
                                final Reference postImageRef = FirebaseStorage.instance.ref().child("Datas");
                                final TaskSnapshot uploadTask = await postImageRef
                                    .child('${uid}_${indice}jpg').putFile(File(i.path));
                                var ImageUrl = await uploadTask.ref.getDownloadURL();
                                url = ImageUrl.toString();
                                images.add(url);
                                if (images.length == 3){
                                  var data = {
                                    'etat': etatController.text,
                                    'prix': prixController.text,
                                    'marque': marque,
                                    'carrosserie': type_carrosserieController.text,
                                    'modele': modeleController.text,
                                    'poignet': poignetController.text,
                                    'carburant': carburantController.text,
                                    'couleur': couleurController.text,
                                    'kilometrage': kilometrageController.text,
                                    'boite_vitesse': boite_vitesseController.text,
                                    'annee': anneeController.text,
                                    'cylindre': cylindreController.text,
                                    'image': images,
                                    'disponible': true,
                                    'uid': currentUser.id,
                                    'email': currentUser.email,
                                    'phone': currentUser.phone,
                                    'user_image': currentUser.image,
                                    'fullName': currentUser.fullName,
                                    'objet': object,
                                    'type': type,
                                    "timestamp": FieldValue.serverTimestamp(),
                                  };

                                  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
                                  await _firestore.collection('Datas').add(data);

                                  Navigator.pop(context);

                                  Navigator.pushNamed(context, MainScreen.id);
                                  Fluttertoast.showToast(msg: 'Publication effectuée');
                                }
                              }
                            } else if(type == 'camion'){

                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) => ProgressDialog(status: 'Enregistrement en cours...',),
                              );

                              int indice = 0;

                              for(var i in _listImagePaths){
                                var uuid = Uuid();
                                String uid = uuid.v1();
                                indice += 1;
                                String url;
                                final Reference postImageRef = FirebaseStorage.instance.ref().child("Datas");
                                final TaskSnapshot uploadTask = await postImageRef
                                    .child('${uid}_${indice}jpg').putFile(File(i.path));
                                var ImageUrl = await uploadTask.ref.getDownloadURL();
                                url = ImageUrl.toString();
                                images.add(url);
                                if (images.length == 3){
                                  var data = {
                                    'etat': etatController.text,
                                    'prix': prixController.text,
                                    'marque': marque,
                                    'carrosserie': type_carrosserieController.text,
                                    'modele': modeleController.text,
                                    'poignet': poignetController.text,
                                    'carburant': carburantController.text,
                                    'couleur': couleurController.text,
                                    'kilometrage': kilometrageController.text,
                                    'boite_vitesse': boite_vitesseController.text,
                                    'nombre_roue': nombre_siegeController.text,
                                    'annee': anneeController.text,
                                    'cylindre': cylindreController.text,
                                    'image': url.toString(),
                                    'disponible': true,
                                    'uid': currentUser.id,
                                    'email': currentUser.email,
                                    'phone': currentUser.phone,
                                    'user_image': currentUser.image,
                                    'fullName': currentUser.fullName,
                                    'objet': object,
                                    'type': type,
                                    "timestamp": FieldValue.serverTimestamp(),
                                  };

                                  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
                                  await _firestore.collection('Datas').add(data);

                                  Navigator.pop(context);

                                  Navigator.pushNamed(context, MainScreen.id);
                                  Fluttertoast.showToast(msg: 'Publication effectuée');
                                }
                              }
                            }
                          }
                      }
                    ),

                    SizedBox(width: 25.0,),

                    TaxiButton(
                      color: Colors.red,
                      title: "ANNULER",
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    )
                  ],
                )
              ],
            )
          )
        )
      )
    );
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
          NetworkImage("https://www.materialui.co/materialIcons/action/account_circle_white_48x48.png")
          : FileImage(_image)
        )
      )
    );
  }

  Future<void> selectImages(context) async {
    await ImagePickers.pickerPaths(
        galleryMode: GalleryMode.image,
        selectCount: 3,
        showGif: false,
        showCamera: true,
        compressSize: 500,
        uiConfig: UIConfig(uiThemeColor: Color(0xffff0f50)),
        cropConfig: CropConfig(enableCrop: false, width: 2, height: 1)
    ).then((value) {
      if(value.length < 3){
        setState(() {
          _listImagePaths = null;
        });
      }
      else {
        setState(() {
          _listImagePaths = value;
        });
      }
    });
  }

}