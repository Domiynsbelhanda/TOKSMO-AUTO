class Vehicule {
  String code;
  String id;
  String etat;
  String prix;
  String marque;
  String carrosserie;
  String modele;
  String poignet;
  String carburant;
  String couleur;
  String kilometrage;
  String boite_vitesse;
  String nombre_siege;
  String nombre_porte;
  String annee;
  String cylindre;
  List image;
  bool disponible;
  String uid;
  String email;
  String phone;
  String user_image;
  String fullName;
  String type;
  String objet;
  String nombre_roue;
  String description;

  Vehicule({
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
    this.description
  });
}

List<Vehicule> donnees = [];

class Marque {
  String marque;
  String image;
  String type;

  Marque({this.marque, this.image, this.type});
}