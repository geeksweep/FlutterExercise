import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'Utils/graphqlbuilder.dart';
import 'package:acmebank/Navigation/Routes/app_router.dart';

void main() {
  runApp(const ProjectDemo());
}

class ProjectDemo extends StatelessWidget {
  const ProjectDemo({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: GraphQLBuilder.graphqlClient(),
        child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routeInformationParser: AppRouter().router.routeInformationParser,
            routerDelegate: AppRouter().router.routerDelegate,
            routeInformationProvider: AppRouter().router.routeInformationProvider,
            title: 'Flutter Demo'
        )
    );
  }
}

@override
Widget build(BuildContext context) {
  // This method is rerun every time setState is calZled, for instance as done
  // by the _incrementCounter method above.
  //
  // The Flutter framework has been optimized to make rerunning build methods
  // fast, so that you can just rebuild anything that needs updating rather
  // than having to individually change instances of widgets.
  return Scaffold(
    appBar: AppBar(
      // TRY THIS: Try changing the color here to a specific color (to
      // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
      // change color while the other colors stay the same.
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
      title: const Text('Acme Bank'),
    ), // This trailing comma makes auto-formatting nicer for build methods.
  );
}
