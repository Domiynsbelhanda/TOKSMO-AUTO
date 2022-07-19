import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toksmo_auto/screens/itemScreen.dart';

import '../constant.dart';

class ModeleScreen extends StatefulWidget{
  String type;
  String marque;
  ModeleScreen({required this.type, required this.marque});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ModeleScreen();
  }
}

class _ModeleScreen extends State<ModeleScreen>{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var _dataStream =
    FirebaseFirestore.instance.collection('donnees')
        .doc('${widget.type}').collection('modele')
        .where('marque', isEqualTo: '${widget.marque}').snapshots();
    // TODO: implement build
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: _dataStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Something went wrong ${snapshot.error}',
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
                            Text('Liste des modeles de ${widget.marque}'
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

                      SizedBox(
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
                                              ItemScreen(
                                                type: widget.type,
                                                modele: '${data['name']}',
                                                marque: widget.marque,
                                              )
                                      )
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.all(16.0),
                                  padding: EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                        '${data['name']}',
                                      style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                )
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