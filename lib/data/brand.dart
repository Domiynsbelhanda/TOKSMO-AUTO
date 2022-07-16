import 'package:flutter/foundation.dart';

class Brand with ChangeNotifier {
  final String marque;
  final String image;
  final String type;

  Brand({
    required this.marque,
    required this.image,
    required this.type
  });

  Map<String,dynamic> createMap(){
    return {
      'marque': marque,
      'image': image,
      'type': type
    };
  }

  Brand.fromFirestore(Map<String,dynamic> firestoreMap):
        marque = firestoreMap['marque'],
        image = firestoreMap['image'],
        type = firestoreMap['type'];
}

class BrandsProvider with ChangeNotifier {
  late String _marque;
  late String _image;
  late String _type;

//getters:
  String get getMarque => _marque;
  String get getImage => _image;
  String get getType => _type;
}
