import "package:flutter/material.dart";
import 'package:graphql_flutter/graphql_flutter.dart';
import "package:acmebank/Queries/querystrings.dart";
import "package:acmebank/Models/home_model.dart";
import "package:acmebank/Utils/acmetheme.dart";
import "package:acmebank/Utils/customdigits.dart";

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(document: gql(QueryTypes.home.name)),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // TODO: Need to convert this into an alert of some kind.
          if (result.hasException) {
            return Center(child: Text(result.exception.toString()));
          }

          final userData = result.data?['home'];

          // TODO: Need to convert this into an alert of some kind.
          if (userData == null || userData.isEmpty) {
            return const Center(child: Text("No data was collected"));
          }

          final userInformation = User.fromJson(userData);

          return SingleChildScrollView(
            child: buildUserCard(userInformation)
            );
        });
  }

  Widget buildUserCard(User currentUser) {
    return Card(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AcmeTheme.blueberry,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Account Number: ${currentUser.accountNumber},', ),
                  Text('Balance: \$${currentUser.balance.toStringAsFixed(2)}'),
                  Text('Address: ${currentUser.address.buildingNumber} ${currentUser.address.streetName}'),
                  Text('${currentUser.address.townName}, ${currentUser.address.postCode}'),
                ],
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Text('Recent Transactions:', style: AcmeTheme.lightTextTheme.displayMedium),
            const SizedBox(
              height: 14.0,
            ),
            Container(
              alignment: Alignment.center,
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: currentUser.recentTransactions.length,
                itemBuilder: (context, transaction) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                    tileColor: AcmeTheme.blueberry,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    contentPadding: const EdgeInsets.all(15.0),
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(currentUser.recentTransactions[transaction].description,
                             style: AcmeTheme.darkTextTheme.displayMedium),
                        Text('From Account: ${currentUser.recentTransactions[transaction].fromAccount}',
                             style: AcmeTheme.darkTextTheme.displaySmall),
                        Text('To Account: ${currentUser.recentTransactions[transaction].toAccount}',
                             style: AcmeTheme.darkTextTheme.displaySmall),
                      ]
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('\$${beautifyNumber(currentUser.recentTransactions[transaction].amount)}',
                                  style: AcmeTheme.darkTextTheme.displayMedium),
                        Text(currentUser.recentTransactions[transaction].date,
                             style: AcmeTheme.darkTextTheme.displaySmall),
                        
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
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text('Upcoming Bills:', style: AcmeTheme.lightTextTheme.displayMedium),
             const SizedBox(
              height: 14.0,
            ),
            Container(
              alignment: Alignment.center,
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: currentUser.upcomingBills.length,
                itemBuilder: (context, bill) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                    tileColor: AcmeTheme.blueberry,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    contentPadding: const EdgeInsets.all(15.0),
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(currentUser.upcomingBills[bill].description,
                             style: AcmeTheme.darkTextTheme.displayMedium),
                        Text('From Account: ${currentUser.upcomingBills[bill].fromAccount}',
                             style: AcmeTheme.darkTextTheme.displaySmall),
                        Text('To Account: ${currentUser.upcomingBills[bill].toAccount}',
                             style: AcmeTheme.darkTextTheme.displaySmall),
                      ]
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('\$${beautifyNumber(currentUser.upcomingBills[bill].amount)}',
                                  style: AcmeTheme.darkTextTheme.displayMedium),
                        Text(currentUser.upcomingBills[bill].date,
                             style: AcmeTheme.darkTextTheme.displaySmall),
                        
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
          ],
        ));
  }
}
