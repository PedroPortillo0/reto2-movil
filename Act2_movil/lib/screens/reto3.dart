import 'package:flutter/material.dart';
import 'dart:convert'; // Para convertir la respuesta en JSON.
import 'package:http/http.dart' as http; // Importar el paquete http.
import 'dart:async'; // Para usar Timer.

class Reto3Screen extends StatefulWidget {
  const Reto3Screen({Key? key}) : super(key: key);

  @override
  _Reto3ScreenState createState() => _Reto3ScreenState();
}

class _Reto3ScreenState extends State<Reto3Screen> {
  // URL base para obtener la información de un personaje de Rick and Morty
  final String apiUrl = 'https://rickandmortyapi.com/api/character';

  // Lista de nombres de personajes de Rick and Morty que cambiarán cada 5 segundos
  final List<int> characterIds = [1, 2, 3, 4]; // ID de personajes (Rick, Morty, Summer, etc.)

  // Variable para controlar el índice actual del personaje
  int currentCharacterIndex = 0;

  // Future para almacenar los datos del personaje
  Future<Map<String, dynamic>>? _characterData;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Obtener la información del primer personaje al iniciar la pantalla
    _loadCharacter();

    // Configurar el temporizador para cambiar de personaje cada 5 segundos
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      setState(() {
        currentCharacterIndex = (currentCharacterIndex + 1) % characterIds.length;
        _loadCharacter();
      });
    });
  }

  // Método para obtener los datos de un personaje
  void _loadCharacter() {
    setState(() {
      _characterData = fetchCharacter(characterIds[currentCharacterIndex]);
    });
  }

  // Future para manejar la respuesta de la API
  Future<Map<String, dynamic>> fetchCharacter(int id) async {
    final response = await http.get(Uri.parse('$apiUrl/$id'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener información del personaje con ID $id');
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancelar el Timer cuando la pantalla se elimina
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reto 3 - API Rick and Morty'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: _characterData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Mostrar spinner mientras se obtiene la información
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}'); // Mostrar el error si ocurre
            } else if (snapshot.hasData) {
              // Si la API devuelve datos
              final data = snapshot.data!;
              final name = data['name'];
              final species = data['species'];
              final status = data['status'];
              final image = data['image']; // Imagen del personaje

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    image,
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const CircularProgressIndicator(); // Mostrar spinner mientras la imagen carga
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Nombre: $name',
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Especie: $species',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Estado: $status',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              );
            }
            return const Text('Sin datos'); // Si no hay datos
          },
        ),
      ),
    );
  }
}
