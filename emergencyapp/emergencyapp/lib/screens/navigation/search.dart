import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergencyapp/screens/navigation/Establecimiento.dart';
import 'package:emergencyapp/screens/navigation/Navigation.dart';
import 'package:flutter/material.dart';

class Search extends SearchDelegate<String> {
  final CollectionReference directorioCollection =
      FirebaseFirestore.instance.collection('Directorio');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Navigation(),
          ),
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: directorioCollection
          .where('tipo', isEqualTo: query)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('Buscando');
        } else {
          // Map your Firestore data to a list of Strings
          List<String> establishments = snapshot.data!.docs
              .map((doc) => doc['tipo'] as String) // 'nombre' es el campo que deseas mostrar
              .toList();

          return ListView.builder(
            itemCount: establishments.length,
            itemBuilder: (context, index) {
              var result = establishments[index];
              return ListTile(
                title: Text(result),
                onTap: () {
                  // Abre la nueva ventana al hacer clic en el elemento
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Establecimiento(tipo: result),
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
