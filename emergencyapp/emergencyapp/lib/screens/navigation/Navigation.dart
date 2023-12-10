import 'package:emergencyapp/screens/navigation/Establecimiento.dart';
import 'package:emergencyapp/screens/navigation/search.dart';
import 'package:flutter/material.dart';
import 'package:emergencyapp/screens/inicio.dart';
import 'package:emergencyapp/querys_snap/firebase_directorio.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  void navigateToDetailPage(String tipo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Establecimiento(tipo: tipo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Inicio()),
                      );
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                  Icon(
                    Icons.location_on,
                    size: 36.0,
                    color: Colors.black,
                  ),
                  SizedBox(width: 16.0),
                  Text(
                    'Directorio',
                    style: TextStyle(
                      fontFamily: 'Rowdies',
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () async {
                      // Utiliza la clase Search directamente aquí
                      String? result = await showSearch(
                        context: context,
                        delegate: Search(),
                      );

                      if (result != null) {
                        navigateToDetailPage(result);
                      }
                    },
                    icon: Icon(Icons.search),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            FutureBuilder(
              future: getEstablecimiento(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (snapshot.hasData) {
                  return Column(
                    children: [
                      for (int index = 0; index < (snapshot.data?.length ?? 0); index++)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                String tipo = snapshot.data![index]['tipo'];
                                navigateToDetailPage(tipo);
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(20.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                primary: Color(0xFF34797B),
                              ),
                              child: Text(
                                snapshot.data![index]['tipo'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Rowdies',
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                } else {
                  return Center(
                    child: Text('No se encontraron datos.'),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
