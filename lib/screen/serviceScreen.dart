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
          child: SingleChildScrollView(
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

                    service("ENTRETIEN", 'https://www.legalplace.fr/wp-content/uploads/2018/02/carnet-entretien-voiture.jpg'),

                    service("DEPANNAGE", 'https://city-depannage.fr/wp-content/uploads/2018/08/slide-depannage-voiture.jpg'),

                    service("REPARATION", 'https://www.goodmecano.com/Articles/guide%20du%20conducteur/Le%20Top%20des%20Reparations%20selon%20la%20Saison/xLe,P20Top,P20des,P20Reparations,P20selon,P20la,P20Saison_1.png.pagespeed.ic.mlq5OgoziJ.webp'),

                    service("LAVAGE", 'https://www.dr-detailing.com/wp-content/uploads/2020/09/lavage-auto-quelle-methode-choisir-696x464.jpg'),

                    service("REMORQUAGE", 'https://www.bubibuzz.com/wp-content/uploads/2019/08/Comment-faire-pour-b%C3%A9n%C3%A9ficier-d%E2%80%99un-remorquage-express.jpg'),

                    service("TAXI", 'https://media.istockphoto.com/photos/taxi-picture-id519870714?s=612x612'),

                ],)
              ],
            ),
        ),
          ),
      )
    );
  }

  Widget service(String title, String img){
    return Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20, top: 20.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            img,
                        ),
                        fit: BoxFit.fitWidth
                      )
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 35.0,
                              backgroundColor: Colors.white
                            ),
                            )
                        ],
                      ),
                    ),
                  ),
                );
  }
}