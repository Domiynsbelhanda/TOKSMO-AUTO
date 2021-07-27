import 'package:car_rental_rdc/models/data.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants.dart';
import '../search.dart';
import '../widget/car_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {

  List<Vehicule> cars = donnees;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                ),
                child: Column(
                  children: [

                    Text(
                      'VEHICULES',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    topVehicule(context, 'vehicule'),

                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Text(
                            "PIECES",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),

                          GestureDetector(
                            onTap:(){
                              //Navigator.pushNamed(context, AvailablePiece.id);
                            },
                            child: Row(
                              children: [

                                Text(
                                  "Voir tout",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor,
                                  ),
                                ),

                                SizedBox(
                                  width: 8,
                                ),

                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 12,
                                  color: kPrimaryColor,
                                ),

                              ],
                            ),
                          ),

                        ],
                      ),
                    ),

                    Container(
                      height: MediaQuery.of(context).size.width / 2.3,
                      margin: EdgeInsets.only(bottom: 5),
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: buildDealers(context),
                      ),
                    ),

                    SizedBox(height: 5.0,),


                    SizedBox(height: 5.0,),

                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget topVehicule(BuildContext context, type){
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width / 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text(
                '${type.toString().toUpperCase()} : ',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              GestureDetector(
                onTap: (){
                  /*Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => Marques(type: 'car',)),
                  );*/
                },
                child: Row(
                  children: [
                    Text(
                      "Voir tout",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),

                    SizedBox(
                      width: 8,
                    ),

                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: kPrimaryColor,
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),

        Container(
          height: MediaQuery.of(context).size.width / 1.7,
          child: ListView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: buildDeals(type),
          ),
        )
      ],
    );
  }

  List<Widget> buildDeals(String type){
    List<Widget> list = [];
    List<Vehicule> datas = donnees
        .where((car) => car.type.toLowerCase().contains(type.toLowerCase()))
        .toList();
    for (var i = 0; i < cars.length; i++) {
      list.add(
          GestureDetector(
              onTap: () {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AvailableCars(type: cars[i].marque,)),
                );*/
              },
              child: buildCar(cars[i], i, context)
          )
      );
    }
    return list;
  }

  List<Widget> buildDealers(BuildContext context){
    List<Widget> list = [];
    List<Vehicule> datas = donnees
        .where((car) => car.objet.toLowerCase().contains('piece'))
        .toList();
    for (var i = 0; i < datas.length; i++) {
      list.add(
          GestureDetector(
              onTap: (){
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookPiece(car: datas[i])),
                );*/
              },
              child: buildDealer(datas[i], i, context)
          )
      );
    }
    return list;
  }

  Widget buildDealer(Vehicule dealer, int index, context){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(right: 10, left: index == 0 ? 10 : 0),
      width: MediaQuery.of(context).size.width / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(dealer.image[0]),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            height: MediaQuery.of(context).size.width / 5,
            width: MediaQuery.of(context).size.width / 5,
          ),

          SizedBox(
            height: 16,
          ),

          Text(
            dealer.modele,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              height: 1,
            ),
          ),

          Text(
            dealer.prix.toString(),
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),

        ],
      ),
    );
  }
}