import 'package:flutter/material.dart';
import 'package:flutter_application/screens/reto1.dart';
import 'package:flutter_application/screens/reto2.dart';
import 'package:flutter_application/screens/reto3.dart';  // Importa la pantalla de Reto 3
import 'screens/home.dart';
import 'screens/contact.dart';
import 'screens/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UP Chiapas',
      theme: ThemeData(
        primarySwatch: Colors.teal, // Cambié a colores más suaves
        brightness: Brightness.light, // Tema claro
        scaffoldBackgroundColor: Colors.teal[50], // Fondo suave
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/contact': (context) => const ContactScreen(),
        '/reto1': (context) => Reto1Screen(),  // Reto 1
        '/reto2': (context) => const Reto2Screen(),  // Reto 2
        '/reto3': (context) => const Reto3Screen(),  // Reto 3
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Center(child: Text('¡Bienvenido a la Página de Inicio!')),
    const ContactScreen(),
    Reto1Screen(),
    const Reto2Screen(),
    const Reto3Screen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UP Chiapas'),
        backgroundColor: Colors.teal[700], // AppBar en color teal oscuro
      ),
      body: Row(
        children: <Widget>[
          // Navbar vertical usando NavigationRail con nuevos colores
          NavigationRail(
            backgroundColor: Colors.teal[100], // Fondo del NavigationRail
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
                switch (index) {
                  case 0:
                    Navigator.pushNamed(context, '/home');
                    break;
                  case 1:
                    Navigator.pushNamed(context, '/contact');
                    break;
                  case 2:
                    Navigator.pushNamed(context, '/reto1');
                    break;
                  case 3:
                    Navigator.pushNamed(context, '/reto2');
                    break;
                  case 4:
                    Navigator.pushNamed(context, '/reto3');
                    break;
                }
              });
            },
            labelType: NavigationRailLabelType.all,
            selectedIconTheme: IconThemeData(color: Colors.teal[700], size: 30), // Icono seleccionado
            unselectedIconTheme: IconThemeData(color: Colors.teal[400]), // Icono no seleccionado
            selectedLabelTextStyle: TextStyle(
              color: Colors.teal[900], // Texto del ítem seleccionado
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelTextStyle: TextStyle(
              color: Colors.teal[600], // Texto del ítem no seleccionado
            ),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                selectedIcon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.contact_page),
                selectedIcon: Icon(Icons.contact_page),
                label: Text('Contact'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.assignment),
                selectedIcon: Icon(Icons.assignment),
                label: Text('Reto 1'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.assignment_turned_in),
                selectedIcon: Icon(Icons.assignment_turned_in),
                label: Text('Reto 2'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.assignment_rounded),
                selectedIcon: Icon(Icons.assignment_rounded),
                label: Text('Reto 3'),
              ),
            ],
          ),
          // Contenido principal de la pantalla
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              color: Colors.teal[50], // Fondo del contenido principal
              child: _pages[_selectedIndex],
            ),
          ),
        ],
      ),
    );
  }
}
