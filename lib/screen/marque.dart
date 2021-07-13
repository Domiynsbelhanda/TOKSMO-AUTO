import 'package:car_rental_rdc/models/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_rdc/Nouveau dossier/available_cars.dart';
import 'package:car_rental_rdc/track/available_cars.dart';
import 'package:car_rental_rdc/engin/available_cars.dart';
import 'package:car_rental_rdc/globalvariabels.dart';

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
    FirebaseFirestore.instance.collection('Marques').get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        liste.add(
          Marque(marque: '${doc["marque"]}', image: '${doc["image"]}', type: '${doc["type"]}'),
        );
      });
    });
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
                "Marques dispo : " + liste.length.toString() + "",
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
                        if(widget.type == 'car'){
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => AvailableCars(type: item.marque,)),
                          );
                        } else if(widget.type == 'engin'){
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => AvailableEngin(type: item.marque,)),
                          );
                        } else if(widget.type == 'track'){
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => AvailableTrack(type: item.marque,)),
                          );
                        }
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
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

        ],
      ),
    );
  }
}