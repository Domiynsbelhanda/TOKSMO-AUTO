import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toksmo_auto/data/brand.dart';
import 'package:toksmo_auto/data/car.dart';

class FireStoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  // Future<void> saveProduct(Product product) {
  //   return _db
  //       .collection('Products')
  //       .doc(product.productId)
  //       .setData(product.createMap());
  // }

  Stream<List<Car>> getCars() {
    return _db.collection('Datas').snapshots().map((snapshot) => snapshot
        .docs
        .map((document) => Car.fromFirestore(document.data()))
        .toList());
  }

  Stream<List<Brand>> getMarques() {
    return _db.collection('Marques').snapshots().map((snapshot) => snapshot
        .docs
        .map((document) => Brand.fromFirestore(document.data()))
        .toList());
  }

  // Future<void> removeItem(String productId) {
  //   return _db.collection('Products').document(productId).delete();
  // }
}