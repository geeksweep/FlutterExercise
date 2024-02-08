import "package:acmebank/Models/accounts_model.dart";
import "package:acmebank/Navigation/Routes/app_route_constants.dart";
import "package:acmebank/Widgets/Contacts/contacts.dart";
import "package:acmebank/Widgets/Home/homescreen.dart";
import "package:acmebank/Widgets/Transactions/transactions.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:acmebank/Widgets/Login/login.dart";
import "package:acmebank/Widgets/Statements/statements.dart";
import "package:acmebank/Widgets/Errors/errorpage.dart";
import "package:acmebank/Widgets/Statements/statementspdfviewer.dart";

class AppRouter{

  GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: AppRouteConstants.loginRouteName,
        path: '/',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: Login(title: 'Blueberry Hill Credit Union'));
        },
      ),

       GoRoute(
        name: AppRouteConstants.homeRouteName,
        path: '/homescreen',
        builder: (context, state) {
           final username = state.extra! as String;
           return Homescreen(username: username);
        }
        //}
      ),

      GoRoute(
        name: AppRouteConstants.transactionsRouteName,
        path: '/transactions/:account',
        builder: (context, state) {
            final account = state.extra! as Account;
            return Transactions(account: account);
        },
      ),
      
      GoRoute(
        name: AppRouteConstants.statementsRouteName,
        path: '/statements',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: StatementsScreen());
        },
      ),

      GoRoute(
        name: AppRouteConstants.contactsRouteName,
        path: '/contacts',
        pageBuilder: (context, state) {
           return const MaterialPage(
            child: Contacts());
        },
      ),

      GoRoute(
        name: AppRouteConstants.pdfViewRouteName,
        path: '/pdfviewer',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: PDFViewer());
        },
      )
    ],

    errorPageBuilder: (context, state){
      return const MaterialPage(
        child: ErrorPage()
        );
    }
    );

}