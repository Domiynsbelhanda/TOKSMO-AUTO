import 'package:car_rental_rdc/globalvariabels.dart';
import 'package:car_rental_rdc/models/data.dart';
import 'package:flutter/material.dart';

import 'book_car.dart';

class AvailablePiece extends StatefulWidget {

  static const String id = 'piece';

  String type;
  AvailablePiece({this.type});

  @override
  _AvailableCarsState createState() => _AvailableCarsState();
}

class _AvailableCarsState extends State<AvailablePiece> {

  @override
  void initState() {
    super.initState();
    setState(() {

    });
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

                  searching(context, "piece"),
                ],
              ),

              SizedBox(
                height: 16,
              ),

              Text(
                widget.type.toUpperCase() + " disponibles (" + donnees
                    .where(
                        (car) => car.objet.toLowerCase()
                        .contains(widget.type.toLowerCase()))
                    .toList()
                    .length.toString() + ")",
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
                  childAspectRatio: 1 / 1.55,
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children: donnees
                      .where(
                          (car) => car.objet.toLowerCase()
                          .contains(widget.type.toLowerCase()))
                      .toList().map((item) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BookCar(car: item)),
                        );
                      },
                      child: buildDealer(item, null, context)
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