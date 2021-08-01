import 'package:car_rental_rdc/models/data.dart';
import 'package:car_rental_rdc/screen/VoitureModele.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_rdc/globalvariabels.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Marques extends StatefulWidget{

  static const String id = 'marques';

  String type;
  Marques({this.type});

  @override
  _Marques createState() => _Marques(type);

}

class _Marques extends State<Marques>{

  String type;
  _Marques(this.type);

  List liste = [];

  @override
  void initState() {
    // TODO: implement initState

    Query collectionReference1 = FirebaseFirestore.instance
        .collection("Marques")
        .where('type', isEqualTo: '${type.toLowerCase()}');


    collectionReference1
        .snapshots()
        .listen((data) => data.docs.forEach((doc){
      setState(() {
        liste.add(
          Marque(
              marque: '${doc.data()["marque"]}',
              image: '${doc.data()["image"]}',
              type: '${doc.data()["type"]}'),
        );
      });
    })
  );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
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

                  searching(context, widget.type, donnees),
                ],
              ),

              SizedBox(height: 16),

              Text(
                '${type} dispo : ' + liste.length.toString() + "",
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
                  childAspectRatio: 1 / 1,
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children: liste.map((item) {
                    return GestureDetector(
                      onTap: () {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => Model(modele: item.marque)),
                          );
                      },
                      child: buildMarque(item, null, context)
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }

  Widget buildMarque(Marque car, int index, context){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.all(MediaQuery.of(context).size.width / 22),
      margin: EdgeInsets.only(right: index != null ? MediaQuery.of(context).size.width / 25 : 0, left: index == 0 ? MediaQuery.of(context).size.width / 25   : 0),
      height: MediaQuery.of(context).size.width / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.width / 3,
            child: Center(
              child: Hero(
                tag: car.marque,
                child: Image.network(
                  car.image,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),

          Text('${car.marque}')

        ],
      ),
    );
  }
}