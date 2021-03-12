
import 'package:car_rental_rdc/models/data.dart';
import 'package:flutter/material.dart';

import '../globalvariabels.dart';
import 'book_car.dart';
import 'car_widget.dart';

class AvailableLocation extends StatefulWidget {

  static const String id = 'location';
  
  String type;
  AvailableLocation({this.type});
  @override
  _AvailableCarsState createState() => _AvailableCarsState();
}

class _AvailableCarsState extends State<AvailableLocation> {

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

                  searching(context, "location", getCamionList()),
                ],
              ),

              SizedBox(
                height: 16,
              ),

              Text(
                "${widget.type} disponibles (" + getCamionList()
                  .where((car) => car.marque.toLowerCase().contains(widget.type.toLowerCase()))
                  .toList()
                  .length.toString() + ")",style: TextStyle(
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
                  children: getCamionList()
                      .where((car) => car.marque.toLowerCase().contains(widget.type.toLowerCase()))
                      .toList().map((item) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Location(car: item)),
                        );
                      },
                      child: buildLocations(item, null, context)
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