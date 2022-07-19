import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class MarqueScreen extends StatefulWidget{
  String type;
  MarqueScreen({required this.type});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MarqueScreen();
  }
}

class _MarqueScreen extends State<MarqueScreen>{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var _dataStream =
    FirebaseFirestore.instance.collection('donnees')
        .doc('${widget.type}').collection('marque')
        .orderBy('name', descending: false).snapshots();
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
                            Text('Liste des marques de ${widget.type}'
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

                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width / 22),
                                  margin: EdgeInsets.only(right: MediaQuery.of(context).size.width / 25,
                                      left: MediaQuery.of(context).size.width / 25),
                                  height: MediaQuery.of(context).size.width / 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        height: MediaQuery.of(context).size.width / 3,
                                        child: Center(
                                          child: Hero(
                                            tag: '${data['key']}',
                                            child: Image.network(
                                              '${data['image']}',
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                        ),
                                      ),

                                      Text('${data['name']}')

                                    ],
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