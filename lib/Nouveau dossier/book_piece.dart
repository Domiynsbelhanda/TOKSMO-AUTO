import 'package:car_rental_rdc/models/data.dart';
import 'package:car_rental_rdc/screen/ImageScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../globalvariabels.dart';

class BookPiece extends StatefulWidget {

  final Piece car;

  BookPiece({@required this.car});

  @override
  _BookCarState createState() => _BookCarState();
}

class _BookCarState extends State<BookPiece> {

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
      backgroundColor: Colors.grey[100],
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

                            Padding(
                              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                              child: Text(
                                "SPECIFICATIONS",
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width / 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ),

                            Container(
                              height: MediaQuery.of(context).size.width / 3,
                              padding: EdgeInsets.only(top: 8, left: 16,),
                              margin: EdgeInsets.only(bottom: 16),
                              child: Row(
                                children: [
                                  buildSpecificationCar("Prix", widget.car.prix),
                                  buildSpecificationCars("Description : ", widget.car.description),
                                ],
                              )
                            ),

                          ],
                        ),
                      ),

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

  Widget buildSpecificationCar(String title, String data,){
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10,),
      margin: EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text(
            title,
            style: TextStyle(
              color: Colors.grey,
              fontSize: MediaQuery.of(context).size.width / 25,
            ),
          ),

          SizedBox(
            height: 4,
          ),

          Text(
            data,
            style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width / 23,
              fontWeight: FontWeight.bold,
            ),
          ),

        ],
      ),
    );
  }

  Widget buildSpecificationCars(String title, String data,){
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10,),
      margin: EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text(
            title,
            style: TextStyle(
              color: Colors.grey,
              fontSize: MediaQuery.of(context).size.width / 25,
            ),
          ),

          SizedBox(
            height: 4,
          ),

          Text(
            data,
            style: TextStyle(
              color: Colors.black,
            ),
          ),

        ],
      ),
    );
  }

}