import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List<Map<String, dynamic>>> getEstablecimiento() async {
  List<Map<String, dynamic>> establecimientos = [];
  Set<String> tiposSet = Set(); // Usar un conjunto para evitar duplicados

  CollectionReference collectionReferenceEstablecimiento = db.collection('Directorio');

  QuerySnapshot queryEstablecimiento = await collectionReferenceEstablecimiento.get();

  queryEstablecimiento.docs.forEach((QueryDocumentSnapshot documento) {
    Map<String, dynamic>? data = documento.data() as Map<String, dynamic>?;

    if (data != null && data['tipo'] != null) {
      String tipo = data['tipo'].toString().toLowerCase(); // Convertir a minúsculas para comparaciones insensibles a mayúsculas y minúsculas

      if (!tiposSet.contains(tipo)) {
        establecimientos.add(data);
        tiposSet.add(tipo);
      }
    }
  });

  return establecimientos;
}
