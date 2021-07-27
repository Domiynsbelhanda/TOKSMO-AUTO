import 'dart:io';
import 'package:car_rental_rdc/screen/register.dart';
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
import 'MainScreen.dart';

class LoginPage extends StatefulWidget{
  static const String id = 'login';

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage>{
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
    
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool reset = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.width / 15),
                  
                  circleImage(context),

                  SizedBox(height: MediaQuery.of(context).size.width / 15,),

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
                                style: TextStyle(fontSize: MediaQuery.of(context).size.width / 22,
                                    color: Colors.black),
                              ),

                              SizedBox(height: 5.0),

                              reset ? Container() :
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
                                style: TextStyle(fontSize: MediaQuery.of(context).size.width / 22,
                                    color: Colors.black),
                              ),


                              SizedBox(height: 15.0),

                  TaxiButton(
                            title: reset ? 'ENVOYEZ' : 'CONNEXION',
                            color: Colors.blue,
                            onPressed: () async{

                              if (reset){
                                if(!emailController.text.contains('@')){
                                  Fluttertoast.showToast(msg:'Entrez un adresse mail valide.');
                                  return;
                                }

                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) => ProgressDialog(status: 'Logging you in',),
                                );

                                await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);

                                Navigator.pop(context);

                                Fluttertoast.showToast(msg: 'Message de réinitialisation envoyé');

                                setState((){
                                  reset = false;
                                });
                                
                              } else {
                                if(!emailController.text.contains('@')){
                                  Fluttertoast.showToast(msg:'Entrez un adresse mail valide.');
                                  return;
                                }

                                if(passwordController.text.length < 6){
                                  Fluttertoast.showToast(msg:'Le mot de passe doit contenir au moins 8 caractère.');
                                  return;
                                }

                                login();
                              }

                            },
                          ),

                  FlatButton(
                      onPressed: (){
                        setState((){
                          if(!reset){
                            reset = true;
                          } else {
                            reset = false;
                          }
                        });
                      },
                      child: Text(reset ? 'Connexion' : 'Mot de passe oublié',
                          style: TextStyle(color: Colors.blue))
                  ),

                  SizedBox(height: 10.0),

                  FlatButton(
                      onPressed: (){
                        Navigator.pushNamedAndRemoveUntil(context, RegisterPage.id, (route) => false);
                      },
                      child: Text('Vous n\'avez pas de compte, inscrivez-vous',
                          style: TextStyle(color: Colors.blueAccent))
                  ),



                ],
              ),
            ),
          ),
        ),
      ),
    ); 
  }

    void login() async {

    //show please wait dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(status: 'Logging you in',),
    );

    final User user = (await _auth.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    ).catchError((ex){

      //check error and display message
      Navigator.pop(context);
      PlatformException thisEx = ex;
      Fluttertoast.showToast(msg:thisEx.message);

    })).user;

    if(user != null){
      // verify login
      FirebaseFirestore.instance.collection('Users').doc('${user.uid}').snapshots()
      .forEach((element) {
        element.data()['key'];
        Navigator.pushNamedAndRemoveUntil(context, MainScreen.id, (route) => false);
        currentFirebaseUser = user;
      });

    }
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
      image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage(
            "assets/logo.png"
        )
        )
      )
    );
  }

}