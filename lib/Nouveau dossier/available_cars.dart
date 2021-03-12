
import 'package:car_rental_rdc/Nouveau%20dossier/book_car.dart';
import 'package:car_rental_rdc/Nouveau%20dossier/car_widget.dart';
import 'package:car_rental_rdc/models/data.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_rdc/globalvariabels.dart';

class AvailableCars extends StatefulWidget {

  static const String id = 'vehicule';

  String type;
  AvailableCars({this.type});

  @override
  _AvailableCarsState createState() => _AvailableCarsState();
}

class _AvailableCarsState extends State<AvailableCars> {

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

                  searching(context, "car", getVehiculeList()),
                ],
              ),

              SizedBox(
                height: 16,
              ),

              Text(
                widget.type + " disponibles (" + getVehiculeList()
                  .where((car) => car.marque.toLowerCase().contains(widget.type.toLowerCase()))
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
                  children: getVehiculeList()
                      .where((car) => car.marque.toLowerCase().contains(widget.type.toLowerCase()))
                      .toList().map((item) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BookCar(car: item)),
                        );
                      },
                      child: buildCar(item, null, context)
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
}