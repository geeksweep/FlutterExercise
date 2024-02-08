import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:acmebank/Queries/querystrings.dart';

class Contacts extends StatelessWidget {
  const Contacts({super.key});

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(document: gql(QueryTypes.contacts.name)),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          //print("Query Results: $results");

          // TODO: Need to convert this into an alert of some kind.
          if (result.hasException) {
             final errors = result.exception?.graphqlErrors[0];

             if (errors == null) {
              return const Center(child: Text("No Errors Included"));
             }
            
            return Center(
              child: AlertDialog(
              title: const Text("Contacts Alert!"),
              content: Text(errors.message),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text("OK"),
                ),
              ],
            ));
          }

          return const SingleChildScrollView();
        });
  }
}
