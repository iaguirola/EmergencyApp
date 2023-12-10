import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetallesEstablecimiento extends StatelessWidget {
  final Map<String, dynamic> establecimiento;

  DetallesEstablecimiento({required this.establecimiento});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalles de ${establecimiento['nombre']}',
          style: TextStyle(fontFamily: 'Rowdies'),
        ),
        backgroundColor: Color(0xFFB8D2E4),
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Nombre', establecimiento['nombre']),
                _buildInfoRow('Dirección', establecimiento['direccion']),
                _buildInfoRow('Teléfono', establecimiento['telefono']),
                _buildInfoRow('Horario de Atención', establecimiento['horaAtencion']),
                
                SizedBox(height: 20),
                _buildCallButton(establecimiento['telefono']),
                SizedBox(height: 20),
                _buildNavigationButtons(establecimiento['direccion']),
              ],
            ),
          ),
        ),
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

  Widget _buildCallButton(String phoneNumber) {
    return ElevatedButton(
      onPressed: () {
        _makePhoneCall(phoneNumber);
      },
      style: ElevatedButton.styleFrom(
        primary: Color(0xFF34797B),
        padding: EdgeInsets.all(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.phone),
          SizedBox(width: 8.0),
          Text(
            'Llamar',
            style: TextStyle(
              fontFamily: 'Rowdies',
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons(String address) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildNavigationButton('Abrir en Waze', () {
          _openInWaze(address);
        }),
        _buildNavigationButton('Abrir en Google Maps', () {
          _openInGoogleMaps(address);
        }),
      ],
    );
  }

  Widget _buildNavigationButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Color(0xFF34797B),
        padding: EdgeInsets.all(8.0),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Rowdies',
          fontSize: 16.0,
        ),
      ),
    );
  }

  void _makePhoneCall(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo realizar la llamada a $phoneNumber';
    }
  }

  void _openInWaze(String address) async {
    // Formatear la dirección para la consulta en Waze
    String formattedAddress = Uri.encodeFull(address);
    String url = 'https://waze.com/ul?q=$formattedAddress';
    
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir la ubicación en Waze';
    }
  }

  void _openInGoogleMaps(String address) async {
    // Formatear la dirección para la consulta en Google Maps
    String formattedAddress = Uri.encodeFull(address);
    String url = 'https://www.google.com/maps/search/?api=1&query=$formattedAddress';
    
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir la ubicación en Google Maps';
    }
  }
}
