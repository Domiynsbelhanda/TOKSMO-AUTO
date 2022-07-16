import 'package:flutter/foundation.dart';

class Car with ChangeNotifier {
  final String? code;
  final String? id;
  final String? etat;
  final String? prix;
  final String? marque;
  final String? carrosserie;
  final String? modele;
  final String? poignet;
  final String? carburant;
  final String? couleur;
  final String? kilometrage;
  final String? boite_vitesse;
  final String? nombre_siege;
  final String? nombre_porte;
  final String? annee;
  final String? cylindre;
  final List? image;
  final bool? disponible;
  final String? uid;
  final String? email;
  final String? phone;
  final String? user_image;
  final String? fullName;
  final String? type;
  final String? objet;
  final String? nombre_roue;
  final String? lieu;
  final String? description;
  final String? conduite;

  Car({
    this.code,
    this.id,
    this.etat,
    this.prix,
    this.marque,
    this.carrosserie,
    this.modele,
    this.poignet,
    this.carburant,
    this.couleur,
    this.kilometrage,
    this.boite_vitesse,
    this.nombre_siege,
    this.nombre_porte,
    this.annee,
    this.cylindre,
    this.image,
    this.disponible,
    this.uid,
    this.email,
    this.phone,
    this.user_image,
    this.fullName,
    this.type,
    this.objet,
    this.nombre_roue,
    this.description,
    this.lieu,
    this.conduite
  });

  Map<String,dynamic> createMap(){
    return {
      'code': code,
      'id': id,
      'etat': etat,
      'prix': prix,
      'marque': marque,
      'carrosserie': carrosserie,
      'modele': modele,
      'poignet': poignet,
      'carburant': carburant,
      'couleur': couleur,
      'kilometrage': kilometrage,
      'boite_vitesse': boite_vitesse,
      'nombre_siege': nombre_siege,
      'nombre_porte': nombre_porte,
      'annee': annee,
      'cylindre': cylindre,
      'image': image,
      'disponible': disponible,
      'uid': uid,
      'email': email,
      'phone': phone,
      'user_image': user_image,
      'fullName': fullName,
      'type': type,
      'objet': objet,
      'nombre_roue': nombre_roue,
      'description': description,
      'lieu': lieu,
      'conduite':conduite
    };
  }

  Car.fromFirestore(Map<String,dynamic> firestoreMap):
        code = firestoreMap['code'],
        id = firestoreMap['id'],
        etat = firestoreMap['etat'],
        prix = firestoreMap['prix'],
        marque = firestoreMap['marque'],
        carrosserie = firestoreMap['carrosserie'],
        modele = firestoreMap['modele'],
        poignet = firestoreMap['poignet'],
        carburant = firestoreMap['carburant'],
        couleur = firestoreMap['couleur'],
        kilometrage = firestoreMap['kilometrage'],
        boite_vitesse = firestoreMap['boite_vitesse'],
        nombre_siege = firestoreMap['nombre_siege'],
        nombre_porte = firestoreMap['nombre_porte'],
        annee = firestoreMap['annee'],
        cylindre = firestoreMap['cylindre'],
        image = firestoreMap['image'],
        disponible = firestoreMap['disponible'],
        uid = firestoreMap['uid'],
        email = firestoreMap['email'],
        phone = firestoreMap['phone'],
        user_image = firestoreMap['user_image'],
        fullName = firestoreMap['fullName'],
        type = firestoreMap['type'],
        objet = firestoreMap['objet'],
        nombre_roue = firestoreMap['nombre_roue'],
        description = firestoreMap['description'],
        lieu = firestoreMap['lieu'],
        conduite = firestoreMap['conduite'];
}

class CarsProvider with ChangeNotifier {

  String? _code;
  String? _id;
  String? _etat;
  String? _prix;
  String? _marque;
  String? _carrosserie;
  String? _modele;
  String? _poignet;
  String? _carburant;
  String? _couleur;
  String? _kilometrage;
  String? _boite_vitesse;
  String? _nombre_siege;
  String? _nombre_porte;
  String? _annee;
  String? _cylindre;
  List? _image;
  bool? _disponible;
  String? _uid;
  String? _email;
  String? _phone;
  String? _user_image;
  String? _fullName;
  String? _type;
  String? _objet;
  String? _nombre_roue;
  String? _lieu;
  String? _description;
  String? _conduite;

//getters:
  String get getCode => _code!;
  String get getId => _id!;
  String get getEtat => _etat!;
  String get getPrix => _prix!;
  String get getMarque => _marque!;
  String get getCarrosserie => _carrosserie!;
  String get getModele => _modele!;
  String get getPoignet => _poignet!;
  String get getCarburant => _carburant!;
  String get getCouleur => _couleur!;
  String get getKilometrage => _kilometrage!;
  String get get => _boite_vitesse!;
  String get getNombreSiege => _nombre_siege!;
  String get getNombrePorte => _nombre_porte!;
  String get getAnnee => _annee!;
  String get getCylindre => _cylindre!;
  List get getImage => _image!;
  bool get getDisponible => _disponible!;
  String get getUid => _uid!;
  String get getEmail => _email!;
  String get getPhone => _phone!;
  String get getUserImage => _user_image!;
  String get getFullName => _fullName!;
  String get getType => _type!;
  String get getObjet => _objet!;
  String get getNombreRoue => _nombre_roue!;
  String get getLieu => _lieu!;
  String get getDescription => _description!;
  String get getConduite => _conduite!;


// //Setters:
//
//   void changeProductName(String val) {
//     _name = val;
//     notifyListeners();
//   }
//
//   void changeProductPrice(String val) {
//     _price = double.parse(val);
//     notifyListeners();
//   }
}
