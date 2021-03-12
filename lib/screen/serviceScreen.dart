import 'package:flutter/material.dart';

class ServiceScreen extends StatefulWidget{

  static const String id = 'serviceScreen';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _serviceScreen();
  }
}

class _serviceScreen extends State<ServiceScreen>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width / 8,
                      height: MediaQuery.of(context).size.width / 8,
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
                      ),
                  ),
                ),
              ),

              Divider(),

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  service("ENTRETIEN"),

                  service("DEPANNAGE"),

                  service("REPARATION"),

                  service("LAVAGE"),

                  service("REMORQUAGE"),

                  service("TAXI"),
                
              ],)
            ],
          ),
        ),
      )
    );
  }

  Widget service(String title){
    return Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20, top: 20.0),
                  child: Container(
                    width: double.infinity,
                    child: Card(
                      elevation: 5.0,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 25.0
                              ),
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
  }
}