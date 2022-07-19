import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant.dart';
import 'package:flutter/material.dart';

import 'ImageScreen.dart';

class DetailScreen extends StatefulWidget {
  final String keys;
  final String type;

  const DetailScreen({
    Key? key,
    required this.keys,
    required this.type
  }) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var _dataStream =
        FirebaseFirestore.instance.collection('donnees')
            .doc('${widget.type}').collection('item')
            .where('key', isEqualTo: '${widget.keys}').snapshots();
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
      stream: _dataStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Something went wrong',
              style: TextStyle(
                  color: Colors.white
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Loading",
              style: TextStyle(
                  color: Colors.white
              ),
            ),
          );
        }
        var datas = snapshot.data!.docs;
        Map<String, dynamic> data = datas[0].data()! as Map<String, dynamic>;

        List<Widget> imageSliders = data['image']
            .map<Widget>((item){
              return GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ImageScreen(
                              data['image']
                            )
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(5.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: Stack(
                        children: <Widget>[
                          Image.network(item, fit: BoxFit.cover, width: 1000.0),
                          Positioned(
                            bottom: 0.0,
                            left: 0.0,
                            right: 0.0,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(200, 0, 0, 0),
                                    Color.fromARGB(0, 0, 0, 0)
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                            ),
                          ),
                        ],
                      )),
                ),
              );
        })
            .toList();

        return SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 16.0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: size.width * 0.1,
                          width: size.width * 0.1,
                          decoration: BoxDecoration(
                            color: kShadeColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Image.asset('assets/images/back-arrow.png'),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: size.width * 0.1,
                            width: size.width * 0.1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Container(
                      child: CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                        ),
                        items: imageSliders,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 0, 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('${data['marque']} ${data['name'].toString().toUpperCase()} / ${data['code']}', style: kCarTitle),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${data['prix']}', style: kSectionTitle),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Spécifications', style: kSectionTitle),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            card(context, size, data, widget.type, 'code', 'Code'),
                            card(context, size, data, widget.type, 'name', 'Modele'),
                            card(context, size, data, widget.type, 'etat', 'Etat'),
                          ],
                        ),

                        const SizedBox(height: 10),
                        (data['annee'].toString() == null)
                            || (data['couleur'].toString() == null)
                            || ((data['boite_vitesse']) == null) ?
                            SizedBox() :
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            card(context, size, data, widget.type, 'annee', 'Année'),
                            card(context, size, data, widget.type, 'couleur', 'Couleur'),
                            card(context, size, data, widget.type, 'boite_vitesse', 'Bte Vitesse'),
                          ],
                        ),

                        const SizedBox(height: 10),
                        data['cylindre'] == null || data['carburant'] == null || data['carrosserie'] == null ?
                        SizedBox() :
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            card(context, size, data, widget.type, 'cylindre', 'Cylindre'),
                            card(context, size, data, widget.type, 'carburant', 'Carburant'),
                            card(context, size, data, widget.type, 'carrosserie', 'Carrosserie'),
                          ],
                        ),

                        const SizedBox(height: 10),
                        data['kilometrage'] == null || data['poignet'] == null || data['nombre_roue'] == null ?
                        SizedBox() :
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            card(context, size, data, widget.type, 'kilometrage', 'Kilometrage'),
                            card(context, size, data, widget.type, 'poignet', 'Poignet'),
                            card(context, size, data, widget.type, 'nombre_roue', 'Nbre Roue'),
                          ],
                        ),

                        const SizedBox(height: 10),
                        data['nombre_porte'] == null || data['nombre_siege'] == null || data['poignet'] == null ?
                        SizedBox() :
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            card(context, size, data, widget.type, 'nombre_porte', 'Nb Porte'),
                            card(context, size, data, widget.type, 'nombre_siege', 'Nb Siege'),
                            card(context, size, data, widget.type, 'poignet', 'Poignet'),
                          ],
                        ),

                        const SizedBox(height: 10),
                        data['nombre_porte'] == null || data['nombre_siege'] == null || data['kilometrage'] == null ?
                        SizedBox() :
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            card(context, size, data, widget.type, 'kilometrage', 'Kilometrage'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 53,
                  width: MediaQuery.of(context).size.width - 32,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: kBackgroundColor
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () async{

                          String response = 'tel:+243893890266';

                          if (await canLaunch(response)) {
                            await launch(response);
                          } else {
                            throw 'Could not launch $response';
                          }
                        },
                        child: const Text('APPEL'),
                        style: TextButton.styleFrom(
                          primary: kTextColor,
                          backgroundColor: kPrimaryColor,
                          textStyle: kPrice,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                      ),

                      TextButton(
                        onPressed: () async{

                          String response = url(
                              '+243893890266',
                              'Bonjour, je suis intéressé par votre véhicule ${data['marque'].toString()}, ${data['modele'].toString()} ${data['name'].toString()} 《code ${data['code'].toString()}》 que vous vendez dans l\'application TOKSMO -AUTO');

                          if (await canLaunch(response)) {
                            await launch(response);
                          } else {
                            throw 'Could not launch $response';
                          }
                        },
                        child: const Text('WHATSAPP'),
                        style: TextButton.styleFrom(
                          primary: Colors.green,
                          backgroundColor: Colors.white,
                          textStyle: kPrice,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
      ),
    );
  }

  Widget card(BuildContext context, size, data, type, obj, dts){
    return Container(
      height: size.height * 0.1,
      width: size.width * 0.28,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: kShadeColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$dts',
            style: kRate.copyWith(
              fontWeight: FontWeight.w500,
              color: kTextColor.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 2),
          Flexible(
            child: RichText(
              overflow: TextOverflow.ellipsis,
              strutStyle: StrutStyle(fontSize: 12.0),
              text: TextSpan(
                style: kSectionTitle,
                text: '${data['$obj']}',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
