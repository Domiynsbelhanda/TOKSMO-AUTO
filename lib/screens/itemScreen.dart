import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toksmo_auto/screens/modeleScreen.dart';

import '../constant.dart';
import 'detail.dart';

class ItemScreen extends StatefulWidget{
  String type;
  String marque;
  String modele;
  ItemScreen({required this.type, required this.marque, required this.modele});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ItemScreen();
  }
}

class _ItemScreen extends State<ItemScreen>{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var _dataStream =
    FirebaseFirestore.instance.collection('donnees')
        .doc('${widget.type}').collection('item')
        .where('marque', isEqualTo: '${widget.marque}')
        .where('modele', isEqualTo: '${widget.modele}').snapshots();
    // TODO: implement build
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

                      SizedBox(
                        height: 24.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 0, 0, 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Liste des items de ${widget.modele}'
                                ,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      Container(
                        width: size.width - 35,
                        height: size.height / 1.5,
                        child: GridView.count(
                          physics: BouncingScrollPhysics(),
                          childAspectRatio: 1 / 1,
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          children: datas.asMap().entries.map<Widget>((entry) {
                            int idx = entry.key;
                            Map<String, dynamic> data = datas[idx].data()! as Map<String, dynamic>;
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailScreen(
                                              keys: '${data['key']}',
                                              type: widget.type,
                                            )
                                    ),
                                  );
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                      padding: const EdgeInsets.fromLTRB(12, 16, 0, 11),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              '${data['image'][0]}'
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 17.0, bottom: 8.0),
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                          width: size.width * 0.34,
                                          padding: EdgeInsets.all(4.0),
                                          decoration: BoxDecoration(
                                            color: kBackgroundColor,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Flexible(
                                            child: RichText(
                                              overflow: TextOverflow.ellipsis,
                                              strutStyle: StrutStyle(fontSize: 12.0),
                                              text: TextSpan(
                                                style: TextStyle(color: Colors.white),
                                                text: '${data['marque']} ${data['name']}',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(left: 16.0, top: 1.0),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          padding: EdgeInsets.all(4.0),
                                          decoration: BoxDecoration(
                                            color: kBackgroundColor,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Flexible(
                                            child: RichText(
                                              overflow: TextOverflow.ellipsis,
                                              strutStyle: StrutStyle(fontSize: 12.0),
                                              text: TextSpan(
                                                style: TextStyle(color: Colors.white),
                                                text: '${data['prix']}',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          }
      ),
    );
  }
}