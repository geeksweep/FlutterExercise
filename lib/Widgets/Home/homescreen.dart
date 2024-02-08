import 'package:acmebank/Widgets/Home/home.dart';
import 'package:acmebank/Widgets/Accounts/accounts.dart';
import 'package:acmebank/Widgets/Services/services.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key, required this.username});

  final String? username;

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Homescreen> { 
  // TODO: Add state variables and functions
    
    int _selectedIndex = 0;

    static List<Widget> pages = <Widget>[
      const Home(),
      const Accounts(),
      const Services()
    ];

   void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 116, 158, 230),
        title: Text(
          widget.username ?? "",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 116, 158, 230),
        unselectedItemColor: Colors.black,
        //selectedIconTheme: const IconThemeData(color: Colors.yellow),
        //unselectedIconTheme:  const IconThemeData(color: Colors.white),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/home.png', height: 30, width: 30),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/accounts.png', height: 30, width: 30),
            label: 'Accounts',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/services.png', height: 30, width: 30),
            label: 'Services',
          ),
        ],
      ),
    );
  }
}
