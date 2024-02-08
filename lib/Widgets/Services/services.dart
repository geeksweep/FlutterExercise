import 'package:acmebank/Navigation/Routes/app_route_constants.dart';
import 'package:acmebank/Widgets/Contacts/contacts.dart';
import 'package:flutter/material.dart';
import 'package:acmebank/Utils/acmetheme.dart';
import 'package:acmebank/Widgets/Statements/statements.dart';
import 'package:go_router/go_router.dart';

class Services extends StatelessWidget {
  const Services({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body:  Center(
          child:  Column(mainAxisAlignment: MainAxisAlignment.center, 
          children: [
             ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AcmeTheme.blueberry),
                ),
                onPressed: () {
                  const snackBarMessage = SnackBar(content: Text('Loans are not available at this time'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBarMessage);
                },
                child: Text(
                  'Loans',
                  style: AcmeTheme.lightTextTheme.displayLarge,
                )),
             const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AcmeTheme.blueberry),
                ),
                onPressed: () {
                  //context.go(AppRouteConstants.statementsRouteName);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => 
                                      const StatementsScreen()));
                },
              child: Text(
                'Statements',
                style: AcmeTheme.lightTextTheme.displayLarge
              ),
            ),
             const SizedBox(
              height: 40,
            ),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AcmeTheme.blueberry),
                ),
                onPressed: () {
                  //context.go(AppRouteConstants.contactsRouteName);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => 
                                    const Contacts()));
                },
                child: Text(
                  'Contacts',
                  style: AcmeTheme.lightTextTheme.displayLarge
                )),
          ]),
        ));
  }
}
