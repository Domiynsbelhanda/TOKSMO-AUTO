import 'package:car_rental_rdc/widget/ProgressDialog.dart';
import 'package:car_rental_rdc/widget/TaxiButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_select/smart_select.dart';
import 'package:uuid/uuid.dart';

import 'MainScreen.dart';

class Modeles extends StatefulWidget{

  static const String id = 'modeleAd';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Modeles();
  }
}

class _Modeles extends State<Modeles>{

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  var modeleController = TextEditingController();

  String marque = "Toyota";

  List<S2Choice<String>> marques = [];

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
                SizedBox(
                    height: MediaQuery.of(context).size.width / 15
                ),

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

                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: SmartSelect<String>.single(
                      title: 'MARQUE : ',
                      value: marque,
                      choiceItems: marques,
                      onChange: (state) => setState(() => marque = state.value)
                  ),
                ),

                SizedBox(height: 10.0),

                Center(
                  child: Center(
                    child: Text(
                        'Ajoute un modele',
                        style: TextStyle(
                            fontSize: 20.0
                        )
                    ),
                  ),
                ),

                TextField(
                  controller: modeleController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'Nom du modèle',
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

                TaxiButton(
                  title: 'AJOUTER',
                  color: Colors.black,
                  onPressed: () async {
                    if(modeleController.text.length < 1 || modeleController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Entrez le modele");
                      return;
                    }

                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) => ProgressDialog(status: 'Enregistrement en cours...',),
                    );

                    var uid = Uuid().v4();

                    var data = {
                      'modele': modeleController.text,
                      'marque': marque
                    };

                    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
                    await _firestore.collection('Modeles').doc(uid.toString()).set(data);

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
}