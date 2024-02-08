import "package:acmebank/Navigation/Routes/app_route_constants.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import 'package:graphql_flutter/graphql_flutter.dart';
import "package:acmebank/Queries/querystrings.dart";
import "package:acmebank/Models/accounts_model.dart";
import 'package:acmebank/Widgets/Transactions/transactionsscreen.dart';
import "package:acmebank/Utils/acmetheme.dart";
import "package:acmebank/Utils/customdigits.dart";

class Accounts extends StatelessWidget {
  const Accounts({super.key});

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(
            document: gql(QueryTypes.accounts.name)),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading){
            return const Center(child: CircularProgressIndicator());
          }
          //print("Query Results: $results");

          // TODO: Need to convert this into an alert of some kind.
          if (result.hasException){
            return Center(child: Text(result.exception.toString()));
          }

          final userAccountsData = result.data?['accounts'];

         // TODO: Need to convert this into an alert of some kind.
          if (userAccountsData == null || userAccountsData.isEmpty) {
            return const Center(child: Text("No data was collected"));
          }

          final useraccounts = UserAccounts.fromJson(userAccountsData);
  
          return SingleChildScrollView(
            child: buildAccountsCard(useraccounts)
            );
        });
  }

  Widget buildAccountsCard(UserAccounts currentUser) {
    return Card(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
                  height: 20.0,
            ),
            Container(
              alignment: Alignment.center,
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: currentUser.allAccounts.length,
                itemBuilder: (context, account) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      onTap: (){
                        //context.go(AppRouteConstants.transactionsRouteName, extra: currentUser.allAccounts[account]);
                        Navigator.push(context, MaterialPageRoute(builder: (_) => 
                                                TransactionsScreen(account: currentUser.allAccounts[account])));
                      },
                    tileColor: AcmeTheme.blueberry,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    contentPadding: const EdgeInsets.all(15.0),
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(currentUser.allAccounts[account].accountHolder,
                             style: AcmeTheme.darkTextTheme.displayMedium),
                        Text('Account Number: ${currentUser.allAccounts[account].accountNumber}',
                             style: AcmeTheme.darkTextTheme.displaySmall),
                         Text('Account Type: ${currentUser.allAccounts[account].accountType}',
                             style: AcmeTheme.darkTextTheme.displaySmall),
                      ]
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('\$${beautifyNumber(currentUser.allAccounts[account].balance)}',
                                  style: AcmeTheme.darkTextTheme.displayMedium),
                      ]
                    )
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                  ],
                );
                }  
              ),
            )
          ]
        )
    );
  }
}
