import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';

final HttpLink _httpLink = HttpLink("http://localhost:4000");
final ValueNotifier<GraphQLClient> _client = ValueNotifier<GraphQLClient>(
  GraphQLClient(
    link: _httpLink,
    cache: GraphQLCache(),
  ),
);

class GraphQLBuilder {

  static graphqlClient() {
    return _client;
  }
}