import 'package:car_rental_rdc/models/data.dart';
import 'package:car_rental_rdc/screen/ImageScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../globalvariabels.dart';

class Location extends StatefulWidget {

  final Camion car;

  Location({@required this.car});

  @override
  _BookCarState createState() => _BookCarState();
}

class _BookCarState extends State<Location> {

  int _currentImage = 0;

  List<Widget> buildPageIndicator(){
    List<Widget> list = [];
    for (var i = 0; i < widget.car.image.length; i++) {
      list.add(buildIndicator(i == _currentImage));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 10,
                                  height: MediaQuery.of(context).size.width / 10,
                                  decoration: BoxDecoration(
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
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            widget.car.modele,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: MediaQuery.of(context).size.width / 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 3,
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            widget.car.marque,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: MediaQuery.of(context).size.width / 18,
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 4,
                        ),

                        Container(
                          height: MediaQuery.of(context).size.width / 2,
                          child: PageView(
                            physics: BouncingScrollPhysics(),
                            onPageChanged: (int page){
                              setState(() {
                                _currentImage = page;
                              });
                            },
                            children: widget.car.image.map((path) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 16,),
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ImageScreen(widget.car.image)),
                                    );
                                  },
                                  child: Image.asset(
                                    path,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),

                        widget.car.image.length > 1
                            ? Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: buildPageIndicator(),
                          ),
                        )
                            : Container(),

                        SizedBox(height: 10.0),

                        Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Container(
                              height: MediaQuery.of(context).size.width / 4,
                              padding: EdgeInsets.only(top: 8, left: 16,),
                              margin: EdgeInsets.only(bottom: 16),
                              child: ListView(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                children: [
                                  buildSpecificationCar("Prix", '${widget.car.prix} / Jour', context),
                                  buildSpecificationCar("Etat", widget.car.etat, context),
                                  buildSpecificationCar("Carrosserie", widget.car.carrosserie, context),
                                  buildSpecificationCar("Poignet", widget.car.poignet, context),
                                  buildSpecificationCar("Carburant", widget.car.carburant, context),
                                ],
                              ),
                            ),

                            Container(
                              height: MediaQuery.of(context).size.width / 4,
                              padding: EdgeInsets.only(top: 8, left: 16,),
                              margin: EdgeInsets.only(bottom: 16),
                              child: ListView(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                children: [
                                  buildSpecificationCar("Couleur", widget.car.couleur, context),
                                  buildSpecificationCar("Kilometrage", widget.car.kilometrage, context),
                                  buildSpecificationCar("Bte Vitesse", widget.car.boite_vitesse, context),
                                  buildSpecificationCar("Nbre Porte", widget.car.nombre_porte.toString(), context),
                                  buildSpecificationCar("Nbre Siège", widget.car.nombre_siege.toString(), context),
                                  buildSpecificationCar("Année", widget.car.annee.toString(), context),
                                  buildSpecificationCar("Cylindre", widget.car.cylindre, context),
                                ],
                              ),
                            ),

                            SizedBox(height: 10),

                          ],
                        ),
                      ),

                      SizedBox(height: 10.0),

                        contact(widget.car, context)


                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}
