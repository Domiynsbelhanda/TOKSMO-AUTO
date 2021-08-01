import 'package:car_rental_rdc/models/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../globalvariabels.dart';

class Model extends StatefulWidget{

  String modele;
  Model({this.modele});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Model();
  }
}

class _Model extends State<Model>{

  List liste = [];

  @override
  void initState() {

    Query collectionReference1 = FirebaseFirestore.instance
        .collection("Modeles")
        .where('marque', isEqualTo: '${widget.modele}');


    collectionReference1
        .snapshots()
        .listen((data) => data.docs.forEach((doc){
      setState(() {
        liste.add(
          Mod(
              marque: '${doc.data()["marque"]}',
              modele: '${doc.data()["modele"]}'
          )
        );
      });
    })
    );

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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

                  searching(context, widget.modele, donnees),
                ],
              ),

              SizedBox(height: 16),

              Text(
                '${widget.modele} dispo : ${liste.length}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width / 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(
                height: 16,
              ),

              Expanded(
                child: GridView.count(
                  physics: BouncingScrollPhysics(),
                  childAspectRatio: 1/1,
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children: liste.map((item){
                    return GestureDetector(
                      onTap: (){},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15)
                          )
                        ),
                        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 22),
                        margin: EdgeInsets.only(right: MediaQuery.of(context).size.width / 25, left: MediaQuery.of(context).size.width / 25),
                        height: MediaQuery.of(context).size.width / 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.width / 3,
                              child: Center(
                                child: Text(
                                  '${item.modele}'
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Mod {
  String modele;
  String marque;

  Mod({this.modele, this.marque});
}