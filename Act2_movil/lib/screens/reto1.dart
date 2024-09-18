import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Biblioteca para manejar URLs

class Reto1Screen extends StatefulWidget {
  const Reto1Screen({Key? key}) : super(key: key);

  @override
  _Reto1ScreenState createState() => _Reto1ScreenState();
}

class _Reto1ScreenState extends State<Reto1Screen> {  // Corrige aquí, debe extender de State<Reto1Screen>
  // Método para enviar un mensaje de texto a un número específico.
  void _sendMessage(String number) async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: number,
    );
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      throw 'No se pudo enviar el mensaje a $number';
    }
  }

  void _makeCall(String number) async {
    final Uri telUri = Uri(
      scheme: 'tel',
      path: number,
    );
    if (await canLaunchUrl(telUri)) {
      await launchUrl(telUri);
    } else {
      throw 'No se pudo realizar la llamada a $number';
    }
  }

  void _openRepository(String url) async {
    final Uri repoUri = Uri.parse(url);
    if (await canLaunchUrl(repoUri)) {
      await launchUrl(repoUri);
    } else {
      throw 'No se pudo abrir el repositorio en $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildContactItem(
            context,
            'Pedro Portillo Rodriguez', // Nombre del alumno
            '221217',                  // Matrícula del alumno
            '9686705919',               // Teléfono del alumno
            'https://github.com/VeroVelas/Act2_movil.git',  // URL del repositorio de GitHub
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(
      BuildContext context, String name, String id, String phone, String repoUrl) {
    return Card(
      child: Column(
        children: [
          // Nombre y matrícula del alumno
          ListTile(
            title: Text(name),
            subtitle: Text('Matrícula: $id'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.message),
                  onPressed: () => _sendMessage(phone),
                  tooltip: 'Enviar mensaje',
                ),
                IconButton(
                  icon: const Icon(Icons.call),
                  onPressed: () => _makeCall(phone),
                  tooltip: 'Llamar',
                ),
              ],
            ),
          ),
          // Botón para abrir el repositorio
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ElevatedButton.icon(
              onPressed: () => _openRepository(repoUrl),
              icon: const Icon(Icons.link),
              label: const Text('Ver repositorio'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,  // Color del botón
                foregroundColor: Colors.white,  // Color del texto y los iconos
              ),
            ),
          ),
        ],
      ),
    );
  }
}
