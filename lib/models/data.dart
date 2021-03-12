class Vehicule {
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
  int nombre_siege;
  int nombre_porte;
  int annee;
  String cylindre;
  List<String> image;
  bool disponible;
  String uid;
  String email;
  String phone;
  String user_image;
  String fullName;

  Vehicule({
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
    this.fullName
  });
}

List<Vehicule> getVehiculeList(){
  return <Vehicule>[
    Vehicule(
      id : "No id for a moment",
      etat : "Bon",
      prix : "1200\$",
      marque: "Land Rover",
      carrosserie: "Mambo",
      modele: "Discovery",
      poignet: "Bon",
      carburant: "Dispo",
      couleur: "Rouge",
      kilometrage: "120",
      boite_vitesse: "Dispo",
      nombre_siege: 4,
      nombre_porte: 4,
      annee: 2008,
      cylindre: "A Piston",
      image: [
        "assets/images/land_rover_0.png",
        "assets/images/land_rover_1.png",
        "assets/images/land_rover_2.png",
      ],
      disponible: true,
      uid: "Id user no dispo",
      email: "domiyns@gmail.com",
      phone: '+243996852377',
      user_image: "https://www.materialui.co/materialIcons/action/account_circle_white_48x48.png",
      fullName: "Dominique Youness"
    ),

    Vehicule(
      id : "No id for a moment",
      etat : "Bon",
      prix : "600\$",
      marque: "AMG",
      carrosserie: "Mambo",
      modele: "C4",
      poignet: "Bon",
      carburant: "Dispo",
      couleur: "Rouge",
      kilometrage: "120",
      boite_vitesse: "Dispo",
      nombre_siege: 4,
      nombre_porte: 4,
      annee: 2008,
      cylindre: "A Piston",
      image: [
        "assets/images/alfa_romeo_c4_0.png",
      ],
      disponible: true,
      uid: "Id user no dispo",
      email: "domiyns@gmail.com",
      phone: '+243996852377',
      user_image: "https://www.materialui.co/materialIcons/action/account_circle_white_48x48.png",
      fullName: "Dominique Youness"
    ),

    Vehicule(
      id : "No id for a moment",
      etat : "Bon",
      prix : "900\$",
      marque: "Nissan",
      carrosserie: "Mambo",
      modele: "GTR",
      poignet: "Bon",
      carburant: "Dispo",
      couleur: "Rouge",
      kilometrage: "120",
      boite_vitesse: "Dispo",
      nombre_siege: 4,
      nombre_porte: 4,
      annee: 2008,
      cylindre: "A Piston",
      image: [
        "assets/images/nissan_gtr_0.png",
        "assets/images/nissan_gtr_1.png",
        "assets/images/nissan_gtr_2.png",
        "assets/images/nissan_gtr_3.png",
      ],
      disponible: true,
      uid: "Id user no dispo",
      email: "domiyns@gmail.com",
      phone: '+243996852377',
      user_image: "https://www.materialui.co/materialIcons/action/account_circle_white_48x48.png",
      fullName: "Dominique Youness"
    ),

    Vehicule(
      id : "No id for a moment",
      etat : "Bon",
      prix : "800\$",
      marque: "Land Rover",
      carrosserie: "Mambo",
      modele: "MDX 2020",
      poignet: "Bon",
      carburant: "Dispo",
      couleur: "Rouge",
      kilometrage: "120",
      boite_vitesse: "Dispo",
      nombre_siege: 4,
      nombre_porte: 4,
      annee: 2008,
      cylindre: "A Piston",
      image: [
        "assets/images/acura_0.png",
        "assets/images/acura_1.png",
        "assets/images/acura_2.png",
      ],
      disponible: true,
      uid: "Id user no dispo",
      email: "domiyns@gmail.com",
      phone: '+243996852377',
      user_image: "https://www.materialui.co/materialIcons/action/account_circle_white_48x48.png",
      fullName: "Dominique Youness"
    ),

    Vehicule(
      id : "No id for a moment",
      etat : "Bon",
      prix : "2300\$",
      marque: "Chevrolet",
      carrosserie: "Mambo",
      modele: "Camaro",
      poignet: "Bon",
      carburant: "Dispo",
      couleur: "Rouge",
      kilometrage: "120",
      boite_vitesse: "Dispo",
      nombre_siege: 4,
      nombre_porte: 4,
      annee: 2008,
      cylindre: "A Piston",
      image: [
        "assets/images/camaro_0.png",
        "assets/images/camaro_1.png",
        "assets/images/camaro_2.png",
      ],
      disponible: true,
      uid: "Id user no dispo",
      email: "domiyns@gmail.com",
      phone: '+243996852377',
      user_image: "https://www.materialui.co/materialIcons/action/account_circle_white_48x48.png",
      fullName: "Dominique Youness"
    )
  ];
}

class Engin {
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
  int annee;
  String cylindre;
  List<String> image;
  bool disponible;
  String uid;
  String email;
  String phone;
  String user_image;
  String fullName;

  Engin({
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
    this.annee,
    this.cylindre,
    this.image,
    this.disponible,
    this.uid,
    this.email,
    this.phone,
    this.user_image,
    this.fullName
  });
}

List<Engin> getEnginList(){
  return <Engin>[
    Engin(
      id : "No id for a moment",
      etat : "Bon",
      prix : "800\$",
      marque: "Ferrari",
      carrosserie: "Mambo",
      modele: "Spider",
      poignet: "Bon",
      carburant: "Dispo",
      couleur: "Rouge",
      kilometrage: "120",
      boite_vitesse: "Dispo",
      annee: 2008,
      cylindre: "A Piston",
      image: [
        "assets/images/ferrari_spider_488_0.png"
      ],
      disponible: true,
      uid: "Id user no dispo",
      email: "domiyns@gmail.com",
      phone: '+243996852377',
      user_image: "https://www.materialui.co/materialIcons/action/account_circle_white_48x48.png",
      fullName: "Dominique Youness"
    ),

    Engin(
      id : "No id for a moment",
      etat : "Bon",
      prix : "600\$",
      marque: "Ford",
      carrosserie: "Mambo",
      modele: "Focus",
      poignet: "Bon",
      carburant: "Dispo",
      couleur: "Rouge",
      kilometrage: "120",
      boite_vitesse: "Dispo",
      annee: 2008,
      cylindre: "A Piston",
      image: ["assets/images/ford_0.png"],
      disponible: true,
      uid: "Id user no dispo",
      email: "domiyns@gmail.com",
      phone: '+243996852377',
      user_image: "https://www.materialui.co/materialIcons/action/account_circle_white_48x48.png",
      fullName: "Dominique Youness"
    ),

    Engin(
      id : "No id for a moment",
      etat : "Bon",
      prix : "900\$",
      marque: "Fiat",
      carrosserie: "Mambo",
      modele: "500x",
      poignet: "Bon",
      carburant: "Dispo",
      couleur: "Rouge",
      kilometrage: "120",
      boite_vitesse: "Dispo",
      annee: 2008,
      cylindre: "A Piston",
      image: ["assets/images/fiat_0.png"],
      disponible: true,
      uid: "Id user no dispo",
      email: "domiyns@gmail.com",
      phone: '+243996852377',
      user_image: "https://www.materialui.co/materialIcons/action/account_circle_white_48x48.png",
      fullName: "Dominique Youness"
    ),

    Engin(
      id : "No id for a moment",
      etat : "Bon",
      prix : "800\$",
      marque: "Honda",
      carrosserie: "Mambo",
      modele: "Civic",
      poignet: "Bon",
      carburant: "Dispo",
      couleur: "Rouge",
      kilometrage: "120",
      boite_vitesse: "Dispo",
      annee: 2008,
      cylindre: "A Piston",
      image: ["assets/images/honda_0.png"],
      disponible: true,
      uid: "Id user no dispo",
      email: "domiyns@gmail.com",
      phone: '+243996852377',
      user_image: "https://www.materialui.co/materialIcons/action/account_circle_white_48x48.png",
      fullName: "Dominique Youness"
    ),

    Engin(
      id : "No id for a moment",
      etat : "Bon",
      prix : "2300\$",
      marque: "Citroen",
      carrosserie: "Mambo",
      modele: "Picasso",
      poignet: "Bon",
      carburant: "Dispo",
      couleur: "Rouge",
      kilometrage: "120",
      boite_vitesse: "Dispo",
      annee: 2008,
      cylindre: "A Piston",
      image: ["assets/images/citroen_0.png"],
      disponible: true,
      uid: "Id user no dispo",
      email: "domiyns@gmail.com",
      phone: '+243996852377',
      user_image: "https://www.materialui.co/materialIcons/action/account_circle_white_48x48.png",
      fullName: "Dominique Youness"
    )
  ];
}

class Track {
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
  int nombre_roue;
  int annee;
  String cylindre;
  List<String> image;
  bool disponible;
  String uid;
  String email;
  String phone;
  String user_image;
  String fullName;

  Track({
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
    this.nombre_roue,
    this.annee,
    this.cylindre,
    this.image,
    this.disponible,
    this.uid,
    this.email,
    this.phone,
    this.user_image,
    this.fullName
  });
}

List<Track> getTrackList(){
  return <Track>[
    Track(
      id : "No id for a moment",
      etat : "Bon",
      prix : "800\$",
      marque: "Citroene",
      carrosserie: "Mambo",
      modele: "Picassos",
      poignet: "Bon",
      carburant: "Dispo",
      couleur: "Rouge",
      kilometrage: "120",
      boite_vitesse: "Dispo",
      nombre_roue: 14,
      annee: 2008,
      cylindre: "A Piston",
      image: ["assets/images/citroen_1.png"],
      disponible: true,
      uid: "Id user no dispo",
      email: "domiyns@gmail.com",
      phone: '+243996852377',
      user_image: "https://www.materialui.co/materialIcons/action/account_circle_white_48x48.png",
      fullName: "Dominique Youness"
    ),

    Track(
      id : "No id for a moment",
      etat : "Bon",
      prix : "600\$",
      marque: "Hondas",
      carrosserie: "Mambo",
      modele: "Civics",
      poignet: "Bon",
      carburant: "Dispo",
      couleur: "Rouge",
      kilometrage: "120",
      boite_vitesse: "Dispo",
      nombre_roue: 20,
      annee: 2008,
      cylindre: "A Piston",
      image: ["assets/images/honda_0.png"],
      disponible: true,
      uid: "Id user no dispo",
      email: "domiyns@gmail.com",
      phone: '+243996852377',
      user_image: "https://www.materialui.co/materialIcons/action/account_circle_white_48x48.png",
      fullName: "Dominique Youness"
    ),

    Track(
      id : "No id for a moment",
      etat : "Bon",
      prix : "900\$",
      marque: "Fiats",
      carrosserie: "Mambo",
      modele: "500xx",
      poignet: "Bon",
      carburant: "Dispo",
      couleur: "Rouge",
      kilometrage: "120",
      boite_vitesse: "Dispo",
      nombre_roue: 16,
      annee: 2008,
      cylindre: "A Piston",
      image: ["assets/images/fiat_1.png"],
      disponible: true,
      uid: "Id user no dispo",
      email: "domiyns@gmail.com",
      phone: '+243996852377',
      user_image: "https://www.materialui.co/materialIcons/action/account_circle_white_48x48.png",
      fullName: "Dominique Youness"
    ),

    Track(
      id : "No id for a moment",
      etat : "Bon",
      prix : "800\$",
      marque: "Fords",
      carrosserie: "Mambo",
      modele: "Focuses",
      poignet: "Bon",
      carburant: "Dispo",
      couleur: "Rouge",
      kilometrage: "120",
      boite_vitesse: "Dispo",
      nombre_roue: 8,
      annee: 2008,
      cylindre: "A Piston",
      image: ["assets/images/ford_1.png"],
      disponible: true,
      uid: "Id user no dispo",
      email: "domiyns@gmail.com",
      phone: '+243996852377',
      user_image: "https://www.materialui.co/materialIcons/action/account_circle_white_48x48.png",
      fullName: "Dominique Youness"
    ),

    Track(
      id : "No id for a moment",
      etat : "Bon",
      prix : "2300\$",
      marque: "Ferraris",
      carrosserie: "Mambo",
      modele: "Spideres 488",
      poignet: "Bon",
      carburant: "Dispo",
      couleur: "Rouge",
      kilometrage: "120",
      boite_vitesse: "Dispo",
      nombre_roue: 4,
      annee: 2008,
      cylindre: "A Piston",
      image: ["assets/images/ferrari_spider_488_1.png"],
      disponible: true,
      uid: "Id user no dispo",
      email: "domiyns@gmail.com",
      phone: '+243996852377',
      user_image: "https://www.materialui.co/materialIcons/action/account_circle_white_48x48.png",
      fullName: "Dominique Youness"
    )
  ];
}

class Piece {
  String id;
  String prix;
  String marque;
  String modele;
  String description;
  List<String> image;
  bool disponible;
  String uid;
  String email;
  String phone;
  String user_image;
  String fullName;

  Piece({
    this.id,
    this.prix,
    this.marque,
    this.modele,
    this.description,
    this.image,
    this.disponible,
    this.uid,
    this.email,
    this.phone,
    this.user_image,
    this.fullName
  });
}

List<Piece> getPieceList(){
  return <Piece>[
    Piece(
      id: "No id for this",
      marque: "Teslax",
      modele: "Nissanx",
      image: ["assets/images/tesla.jpg"],
      disponible: true,
      uid: "No uid",
      email: "Domiyns@gmail.com",
      phone: "+243996852377",
      user_image: "https://www.materialui.co/materialIcons/action/account_circle_white_48x48.png",
      fullName: "Champion",
      prix: "21.000FC",
      description: "Etat: bon, Description"
    ),
    Piece(
      id: "No id for this",
      marque: "Hertx",
      modele: "Toyots",
      image: ["assets/images/hertz.png"],
      disponible: true,
      uid: "No uid",
      email: "Domiyns@gmail.com",
      phone: "+243996852377",
      user_image: "https://www.materialui.co/materialIcons/action/account_circle_white_48x48.png",
      fullName: "Champion",
      prix: "22.000 FC",
      description: "Couleur: Bleu, Rayon : 20 Cm, etc."
    ),
    Piece(
      id: "No id for this",
      marque: "Aviss",
      modele: "Harriers",
      image: ["assets/images/avis.png"],
      disponible: true,
      uid: "No uid",
      email: "Domiyns@gmail.com",
      phone: "+243996852377",
      user_image: "https://www.materialui.co/materialIcons/action/account_circle_white_48x48.png",
      fullName: "Champion",
      prix: "18.000 FC",
      description: "Pas de description"
    ),
  ];
}

class Accessoire {
  String id;
  String prix;
  String marque;
  String modele;
  String description;
  List<String> image;
  bool disponible;
  String uid;
  String email;
  String phone;
  String user_image;
  String fullName;

  Accessoire({
    this.id,
    this.prix,
    this.marque,
    this.modele,
    this.description,
    this.image,
    this.disponible,
    this.uid,
    this.email,
    this.phone,
    this.user_image,
    this.fullName
  });
}

List<Accessoire> getAccessoireList(){
  return <Accessoire>[
    Accessoire(
      id: "No id for this",
      marque: "Teslax",
      modele: "Nissanx",
      image: ["assets/images/tesla.jpg"],
      disponible: true,
      uid: "No uid",
      email: "Domiyns@gmail.com",
      phone: "+243996852377",
      user_image: "https://www.materialui.co/materialIcons/action/account_circle_white_48x48.png",
      fullName: "Champion",
      prix: "21.000FC",
      description: "Etat: bon, Description"
    ),
    Accessoire(
      id: "No id for this",
      marque: "Hertx",
      modele: "Toyots",
      image: ["assets/images/hertz.png"],
      disponible: true,
      uid: "No uid",
      email: "Domiyns@gmail.com",
      phone: "+243996852377",
      user_image: "https://www.materialui.co/materialIcons/action/account_circle_white_48x48.png",
      fullName: "Champion",
      prix: "22.000 FC",
      description: "Couleur: Bleu, Rayon : 20 Cm, etc."
    ),
    Accessoire(
      id: "No id for this",
      marque: "Aviss",
      modele: "Harriers",
      image: ["assets/images/avis.png"],
      disponible: true,
      uid: "No uid",
      email: "Domiyns@gmail.com",
      phone: "+243996852377",
      user_image: "https://www.materialui.co/materialIcons/action/account_circle_white_48x48.png",
      fullName: "Champion",
      prix: "18.000 FC",
      description: "Pas de description"
    ),
  ];
}

class Camion {
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
  int nombre_siege;
  int nombre_porte;
  int annee;
  String cylindre;
  List<String> image;
  bool disponible;
  String uid;
  String email;
  String phone;
  String user_image;
  String fullName;

  Camion({
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
    this.fullName
  });
}

List<Camion> getCamionList(){
  return <Camion>[
    Camion(
      id : "No id for a moment",
      etat : "Bon",
      prix : "1200\$",
      marque: "Land Rover",
      carrosserie: "Mambo",
      modele: "Discovery",
      poignet: "Bon",
      carburant: "Dispo",
      couleur: "Rouge",
      kilometrage: "120",
      boite_vitesse: "Dispo",
      nombre_siege: 4,
      nombre_porte: 4,
      annee: 2008,
      cylindre: "A Piston",
      image: ["assets/images/land_rover_0.png"],
      disponible: true,
      uid: "Id user no dispo",
      email: "domiyns@gmail.com",
      phone: '+243996852377',
      user_image: "https://www.materialui.co/materialIcons/action/account_circle_white_48x48.png",
      fullName: "Dominique Youness"
    ),

    Camion(
      id : "No id for a moment",
      etat : "Bon",
      prix : "600\$",
      marque: "Alpha Romeo",
      carrosserie: "Mambo",
      modele: "C4",
      poignet: "Bon",
      carburant: "Dispo",
      couleur: "Rouge",
      kilometrage: "120",
      boite_vitesse: "Dispo",
      nombre_siege: 4,
      nombre_porte: 4,
      annee: 2008,
      cylindre: "A Piston",
      image: ["assets/images/alfa_romeo_c4_0.png"],
      disponible: true,
      uid: "Id user no dispo",
      email: "domiyns@gmail.com",
      phone: '+243996852377',
      user_image: "https://www.materialui.co/materialIcons/action/account_circle_white_48x48.png",
      fullName: "Dominique Youness"
    ),

    Camion(
      id : "No id for a moment",
      etat : "Bon",
      prix : "900\$",
      marque: "Nissan",
      carrosserie: "Mambo",
      modele: "GTR",
      poignet: "Bon",
      carburant: "Dispo",
      couleur: "Rouge",
      kilometrage: "120",
      boite_vitesse: "Dispo",
      nombre_siege: 4,
      nombre_porte: 4,
      annee: 2008,
      cylindre: "A Piston",
      image: ["assets/images/nissan_gtr_0.png"],
      disponible: true,
      uid: "Id user no dispo",
      email: "domiyns@gmail.com",
      phone: '+243996852377',
      user_image: "https://www.materialui.co/materialIcons/action/account_circle_white_48x48.png",
      fullName: "Dominique Youness"
    ),

    Camion(
      id : "No id for a moment",
      etat : "Bon",
      prix : "800\$",
      marque: "Acura",
      carrosserie: "Mambo",
      modele: "MDX 2020",
      poignet: "Bon",
      carburant: "Dispo",
      couleur: "Rouge",
      kilometrage: "120",
      boite_vitesse: "Dispo",
      nombre_siege: 4,
      nombre_porte: 4,
      annee: 2008,
      cylindre: "A Piston",
      image: ["assets/images/acura_0.png"],
      disponible: true,
      uid: "Id user no dispo",
      email: "domiyns@gmail.com",
      phone: '+243996852377',
      user_image: "https://www.materialui.co/materialIcons/action/account_circle_white_48x48.png",
      fullName: "Dominique Youness"
    ),

    Camion(
      id : "No id for a moment",
      etat : "Bon",
      prix : "2300\$",
      marque: "Chevrolet",
      carrosserie: "Mambo",
      modele: "Camaro",
      poignet: "Bon",
      carburant: "Dispo",
      couleur: "Rouge",
      kilometrage: "120",
      boite_vitesse: "Dispo",
      nombre_siege: 4,
      nombre_porte: 4,
      annee: 2008,
      cylindre: "A Piston",
      image: ["assets/images/camaro_0.png"],
      disponible: true,
      uid: "Id user no dispo",
      email: "domiyns@gmail.com",
      phone: '+243996852377',
      user_image: "https://www.materialui.co/materialIcons/action/account_circle_white_48x48.png",
      fullName: "Dominique Youness"
    )
  ];
}

class Marque {
  String marque;
  String image;

  Marque({this.marque, this.image});
}

List<Marque> getMarqueList(){
  return <Marque> [
    Marque(marque: "AMG", image: "assets/voiture/amc.png"),
    Marque(marque: "Audi", image: "assets/voiture/audi-750x410.jpg"),
    Marque(marque: "Bmw", image: "assets/voiture/bmw-750x410.jpg"),
    Marque(marque: "Citroen", image: "assets/voiture/citroen-750x410.jpg"),
    Marque(marque: "Dacia", image: "assets/voiture/dacia-750x410.jpg"),
    Marque(marque: "Fiat", image: "assets/voiture/fiat-750x410.jpg"),
    Marque(marque: "Ford", image: "assets/voiture/ford-750x410.jpg"),
    Marque(marque: "Fuso", image: "assets/voiture/Mitsubishi_Fuso_logo.png"),
    Marque(marque: "GMC", image: "assets/voiture/gmc-logo-0.png"),
    Marque(marque: "Honda", image: "assets/voiture/honda-750x410.jpg"),
    Marque(marque: "Hummer", image: "assets/voiture/hummer_logo.jpg"),
    Marque(marque: "Hyundai", image: "assets/voiture/hyundai-750x410.jpg"),
    Marque(marque: "Isuzu", image: "assets/voiture/isuzu_logo.jpg"),
    Marque(marque: "Iveco", image: "assets/voiture/Iveco_logo_logotype.png"),
    Marque(marque: "Jaguar", image: "assets/voiture/jaguar-750x410.jpg"),
    Marque(marque: "Jeep", image: "assets/voiture/Jeep-Logo-1024x576.png"),
    Marque(marque: "Kia", image: "assets/voiture/kia-750x410.jpg"),
    Marque(marque: "Land Rover", image: "assets/voiture/land_rover.png"),
    Marque(marque: "Lexus", image: "assets/voiture/lexus.png"),
    Marque(marque: "Mazda", image: "assets/voiture/mazda-750x410.jpg"),
    Marque(marque: "Mercedes Benz", image: "assets/voiture/mercedes-750x410.jpg"),
    Marque(marque: "MG", image: "assets/voiture/MG-logo-450x350.png"),
    Marque(marque: "Mini", image: "assets/voiture/mini.png"),
    Marque(marque: "Mitsubishi", image: "assets/voiture/mitsu-750x410.jpg"),
    Marque(marque: "Nissan", image: "assets/voiture/nissan-750x410.jpg"),
    Marque(marque: "Opel", image: "assets/voiture/opel-750x410.jpg"),
    Marque(marque: "Peugeot", image: "assets/voiture/peugeot-750x410.jpg"),
    Marque(marque: "Porsche", image: "assets/voiture/porsche-750x410.jpg"),
    Marque(marque: "Renault", image: "assets/voiture/renault-750x410.jpg"),
    Marque(marque: "Rolls Royce", image: "assets/voiture/rolls-royce-750x410.jpg"),
    Marque(marque: "Seat", image: "assets/voiture/seat-750x410.jpg"),
    Marque(marque: "Skoda", image: "assets/voiture/skoda-750x410.jpg"),
    Marque(marque: "Suzuki", image: "assets/voiture/suzuki.png"),
    Marque(marque: "Toyota", image: "assets/voiture/toyota-750x410.jpg"),
    Marque(marque: "Volkswagen", image: "assets/voiture/volkswagen-750x410.jpg"),
    Marque(marque: "Volvo", image: "assets/voiture/volvo-750x410.jpg"),
  ];
}