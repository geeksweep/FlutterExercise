import "package:flutter/material.dart";
import 'package:graphql_flutter/graphql_flutter.dart';
import "package:acmebank/Queries/querystrings.dart";
import "package:acmebank/Models/accounts_model.dart";
import "package:acmebank/Models/transactions_model.dart";
import "package:acmebank/Utils/acmetheme.dart";
import "package:acmebank/Utils/customdigits.dart";
import 'dart:math';

class TransactionsDetails extends StatelessWidget {
  const TransactionsDetails({super.key, required this.account});

  final Account account;
  //final List<Transactions> updatedTransactions = [];

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(document: gql(QueryTypes.transactions.name)),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          //print("Query Results: $results");

          // TODO: Need to convert this into an alert of some kind.
          if (result.hasException) {
            return Center(child: Text(result.exception.toString()));
          }

          final userTransactionsData = result.data?['transactions'];

          // TODO: Need to convert this into an alert of some kind.
          if (userTransactionsData == null || userTransactionsData.isEmpty) {
            return const Center(child: Text("No data was collected"));
          }

          final userTransactions = UserTransactions.fromJson(userTransactionsData);
          userTransactions.addNewTransactions(userTransactions.allTransactions);
          List<Transaction> updatedTransactions = userTransactions.filterTransactionsById(userTransactions, account.id);

          return SingleChildScrollView(
              child: buildTransactionsCard(updatedTransactions));
        });
  }

  Widget buildTransactionsCard(List<Transaction> transactions) {
    return Card(
        child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
          const SizedBox(
            height: 20.0,
          ),
          Container(
            
          ),
           const SizedBox(
            height: 14.0,
          ),
          Container(
            alignment: Alignment.center,
            child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: transactions.length,
                itemBuilder: (context, transaction) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                          tileColor: AcmeTheme.blueberry,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          contentPadding: const EdgeInsets.all(15.0),
                          leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(transactions[transaction].description,
                                    style: AcmeTheme.darkTextTheme.displayMedium),
                                Text('To Account: ${transactions[transaction].toAccount}',
                                    style: AcmeTheme.darkTextTheme.displaySmall),
                                Text('From Account: ${transactions[transaction].fromAccount}',
                                    style:AcmeTheme.darkTextTheme.displaySmall),
                              ]),
                          trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('\$${beautifyNumber(transactions[transaction].amount)}',
                                    style: AcmeTheme.darkTextTheme.displayMedium),
                                Text(transactions[transaction].date,
                                    style: AcmeTheme.darkTextTheme.displaySmall)
                              ])),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  );
                }),
          )
        ]));
  }
}

extension on UserTransactions {
  void addNewTransactions(List<Transaction> list) {
    //these are the current graphql server account ids.
    List<String> descriptions = [
      "Online Shopping",
      "Checking Deposit",
      "ATM Withdrawel",
      "ATM Deposit",
      "Money Market Deposit",
      "Gasoline",
      "Warehouse Superstore",
      "ACH Withdrawel",
      "Direct Deposit",
      "Grocery"
    ];

    //these are the current graphql server account ids.
    List<String> transactionIds = [
      "33870ce2-3070-473a-a4d3-5c441e220ddb",
      "d3a5a1a8-f935-472d-89f4-38fc474d7c12",
      "dd047e72-0c44-48c9-b870-44dddbc38e3c",
      "bfcf623d-14bc-432c-a59a-f3eec803eef6",
      "61fb9c04-d8a8-4250-8685-a41958589c9d",
      "d74ea886-4837-4c79-b510-5da8a1c1ce83",
      "bd668cf4-63c8-44f4-a164-9fa8f9b2e48e",
      "ffc270e8-0455-478a-9425-f674902561a9",
      "7a181975-f014-4a8a-8c2b-63f044c53ecf",
      "b7419021-b4b5-4ba3-b194-c5b3621705b7"
    ];

    // manually adding ids and changing descriptions to all transactions from query.
    for (int index = 0; index < list.length; index++) {
      list[index].id = transactionIds[index];
      list[index].description = descriptions[index];
    }

    // adding brand new transactions
    for (int index = 0; index < 100; index++) {
      String transdescription =
          descriptions[Random().nextInt(descriptions.length)];
      String transactionId =
          transactionIds[Random().nextInt(transactionIds.length)];

      list.add(Transaction(
          id: transactionId,
          date: "1990-04-23",
          description: transdescription,
          amount: 424.0,
          fromAccount: "Checking",
          toAccount: "Savings"));
    }
  }

  List<Transaction> filterTransactionsById(UserTransactions list, String accountId) {
    return list.allTransactions.where((transaction) => transaction.id == accountId).toList();
}
}
