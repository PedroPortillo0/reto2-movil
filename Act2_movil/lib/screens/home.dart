import 'package:flutter/material.dart';
import 'package:flutter_application/screens/reto1.dart';  // Importa la pantalla de Reto 1
import 'package:flutter_application/screens/reto2.dart';  // Importa la pantalla de Reto 2
import 'package:flutter_application/screens/reto3.dart';  // Importa la pantalla de Reto 3
import 'package:flutter_application/screens/contact.dart';  // Importa la pantalla de Contacto

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Menú de Retos',
    initialRoute: '/home',
    routes: {
      '/home': (context) => const HomeScreen(),
      '/reto1': (context) => const Reto1Screen(),  // Aquí ya debería funcionar sin error
      '/reto2': (context) => const Reto2Screen(),
      '/reto3': (context) => const Reto3Screen(),
      '/contact': (context) => const ContactScreen(),
    },
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Center(child: Text('Reto 1')),
    Center(child: Text('Reto 2')),
    Center(child: Text('Reto 3')),
    Center(child: Text('Contacto')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/reto1');
        break;
      case 1:
        Navigator.pushNamed(context, '/reto2');
        break;
      case 2:
        Navigator.pushNamed(context, '/reto3');
        break;
      case 3:
        Navigator.pushNamed(context, '/contact');
        break;
      default:
        Navigator.pushNamed(context, '/home');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Colors.blue,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.widgets),
            label: 'Reto 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.touch_app),
            label: 'Reto 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.text_fields),
            label: 'Reto 3',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Contacto',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
