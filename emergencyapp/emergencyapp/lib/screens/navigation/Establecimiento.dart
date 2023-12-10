import 'package:flutter/material.dart';
import 'package:emergencyapp/querys_snap/firebase_informacion.dart';
import 'package:emergencyapp/screens/navigation/DetallesEstablecimiento.dart';

class Establecimiento extends StatelessWidget {
  final String tipo;

  Establecimiento({required this.tipo});

  @override
  Widget build(BuildContext context) {
    Future<List<Map<String, dynamic>>> detalles = getInformacion(tipo);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Información de $tipo',
          style: TextStyle(fontFamily: 'Rowdies'),
        ),
        backgroundColor: Color(0xFFB8D2E4),
      ),
      body: FutureBuilder(
        future: detalles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final establecimientos = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  for (int index = 0; index < (establecimientos.length); index++)
                    _buildEstablecimientoCard(context, establecimientos[index]),
                ],
              ),
            );
          } else {
            return Center(child: Text('No se encontraron datos.'));
          }
        },
      ),
    );
  }

  Widget _buildEstablecimientoCard(BuildContext context, Map<String, dynamic> establecimiento) {
    final nombre = establecimiento['nombre'] ?? 'Sin nombre';
    final direccion = establecimiento['direccion'] ?? 'Sin dirección';

    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          navigateToDetailsPage(context, establecimiento);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow('Nombre', nombre),
              _buildInfoRow('Dirección', direccion),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToDetailsPage(BuildContext context, Map<String, dynamic> establecimiento) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetallesEstablecimiento(establecimiento: establecimiento),
      ),
    );
  }

  Widget _buildInfoRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontFamily: 'Rowdies',
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: _buildValue(value),
          ),
        ],
      ),
    );
  }

  Widget _buildValue(dynamic value) {
    if (value is String) {
      return Text(
        value,
        style: TextStyle(
          fontFamily: 'Rowdies',
        ),
      );
    } else if (value is List) {
      return Text(
        value.join(', '), 
        style: TextStyle(
          fontFamily: 'Rowdies',
        ),
      );
    } else {
      return Text(
        'Valor no válido',
        style: TextStyle(
          fontFamily: 'Rowdies',
        ),
      );
    }
  }
}
