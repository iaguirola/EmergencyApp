import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List<Map<String, dynamic>>> getInformacion(String tipo) async {
  List<Map<String, dynamic>> informacion = [];

  try {
    CollectionReference collectionReferenceEstablecimiento = db.collection('Directorio');

    QuerySnapshot queryEstablecimiento = await collectionReferenceEstablecimiento.get();

    queryEstablecimiento.docs.forEach((QueryDocumentSnapshot documento) {
      Map<String, dynamic>? data = documento.data() as Map<String, dynamic>?;

      if (data != null && data['tipo'] != null && data['tipo'] == tipo) {
        // Verifica y guarda solo los campos que no son nulos
        Map<String, dynamic> detalles = data['detalles'] ?? {};

        // Agrega otros campos según sea necesario
        Map<String, dynamic> infoToAdd = {
          'nombre': detalles['nombre'] ?? 'Sin nombre',
          'direccion': detalles['direccion'] ?? 'Sin dirección',
          'telefono': detalles['telefono'] ?? 'Sin teléfono',
          'horaAtencion': detalles['horaAtencion'] ?? 'Sin información',
          'doctores': detalles['doctores'] ?? 'Sin información',
        };

        informacion.add(infoToAdd);
      }
    });

    print(informacion);
  } catch (e) {
    print('Error en getInformacion: $e');
  }

  return informacion;
}
