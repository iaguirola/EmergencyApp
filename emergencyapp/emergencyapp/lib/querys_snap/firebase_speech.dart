import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<void> consultarFirebase(String palabra) async {
  FirebaseFirestore db = FirebaseFirestore.instance;

  // Consulta en la colección 'Directorio'
  await buscarEnColeccion(db.collection('Directorio'), palabra);

  // Consulta en la colección 'Emergencia'
  await buscarEnColeccion(db.collection('Emergencias'), palabra);
}

Future<void> buscarEnColeccion(CollectionReference coleccion, String palabra) async {
  QuerySnapshot query = await coleccion.where('tipo', isEqualTo: palabra).get();

  query.docs.forEach((QueryDocumentSnapshot documento) {
    Map<String, dynamic>? data = documento.data() as Map<String, dynamic>?;

    if (data != null) {
      // Realiza acciones con la información obtenida, por ejemplo, muestra en la consola
      print("Información encontrada para la palabra '$palabra' en ${coleccion.id}:");
      print(data);
    }
  });
}

