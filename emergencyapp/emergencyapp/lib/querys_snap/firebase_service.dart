import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db =FirebaseFirestore.instance;


Future<List> getEstablecimientos() async{
  List establecimientos = [];

  CollectionReference collectionreferenceEstablecimiento = db.collection('Directorio');

  QuerySnapshot queryEstablecimiento = await collectionreferenceEstablecimiento.get();


  queryEstablecimiento.docs.forEach((documento) { 
    establecimientos.add(documento.data());

  });

  Future.delayed(const Duration(seconds: 5));

  return establecimientos;
}