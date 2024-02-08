import 'package:flutter/material.dart';
import 'package:acmebank/Widgets/Transactions/transactions.dart';
import 'package:acmebank/Widgets/Transactions/transactionsdetails.dart';
import 'package:acmebank/Models/accounts_model.dart';

class TransactionsScreen extends StatefulWidget {

  final Account account;
  
  const TransactionsScreen({super.key, required this.account});

  @override
  TransactionsState createState() => TransactionsState();
  
}

class TransactionsState extends State<TransactionsScreen> { 

  late List<Widget> _pages ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  
    _pages = <Widget>[
      Transactions(account: widget.account),
      TransactionsDetails(account: widget.account)
    ];
  }
  
    int _selectedIndex = 0;

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
          widget.account.accountHolder,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 116, 158, 230),
        unselectedItemColor: Colors.black,
        //selectedIconTheme: const IconThemeData(color: Colors.yellow),
        //unselectedIconTheme:  const IconThemeData(color: Colors.white),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/transactions.png', height: 30, width: 30),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/transactiondetails.png', height: 30, width: 30),
            label: 'Details',
          ),
        ],
      ),
    );
  }
}
