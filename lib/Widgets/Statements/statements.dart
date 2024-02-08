import "package:acmebank/Navigation/Routes/app_route_constants.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import 'package:graphql_flutter/graphql_flutter.dart';
import "package:acmebank/Queries/querystrings.dart";
import "package:acmebank/Models/statements_model.dart";
import "package:acmebank/Widgets/Statements/statementsparse.dart";
import "package:acmebank/Utils/acmetheme.dart";
import "package:acmebank/Utils/customdigits.dart";
import "package:acmebank/Widgets/Statements/statementspdfviewer.dart";


class StatementsScreen extends StatefulWidget {
  const StatementsScreen({super.key});

  @override
  StatementsState createState() => StatementsState();
}

class StatementsState extends State<StatementsScreen> {

  int selecteddropDownItem = 0;
  List<String> _dropDownListValues = [];
  late List<Statement> _updatedFilteredStatements;
  List<Statement> _originalStatements = [];
  String label = "";
  bool _initializedState = false;

  void initializeData(Statements userStatements) {
    _dropDownListValues = collectStatementYears(userStatements.allStatements);
    _originalStatements = userStatements.allStatements;
    _updatedFilteredStatements = _originalStatements.where((statement) => 
          statement.year == _dropDownListValues[0]).toList();
    }

  void _onItemTapped(String? year) {
    setState(() {
      _initializedState = true;
      _updatedFilteredStatements = 
       _originalStatements.where((statement) => 
          statement.year == year).toList();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(document: gql(QueryTypes.statements.name)),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // TODO: Need to convert this into an alert of some kind.
          if (result.hasException) {
            return Center(child: Text(result.exception.toString()));
          }

          final userStatementsData = result.data?['statements'];

          // TODO: Need to convert this into an alert of some kind.
          if (userStatementsData == null || userStatementsData.isEmpty) {
            return const Center(child: Text("No data was collected"));
          }

          final userStatements = Statements.fromJson(userStatementsData);
          if (!_initializedState){
            initializeData(userStatements);
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('Statements'),
             backgroundColor: AcmeTheme.blueberry,
             ),
             body: SingleChildScrollView(
             child: buildStatementsCard(_dropDownListValues),
          ));
        });
  }

  Widget buildStatementsCard(List<String> dropDownListValues) {
    return Card(
      child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
              Container(
              alignment: Alignment.center,
              child: DropdownMenu<String>(
                  initialSelection: _dropDownListValues[0],
                  requestFocusOnTap: true,
                  label: const Text('Year'),
                  onSelected: (String? year) {
                    _onItemTapped(year);
                      },
                  dropdownMenuEntries: _dropDownListValues.map<DropdownMenuEntry<String>>((String year) {
                        return DropdownMenuEntry<String>(
                          value: year,
                          label: year,
                        );
                      }).toList(),   
              )
              ),
              const SizedBox(
              height: 30,
            ),
              Container(
              alignment: Alignment.center,
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: _updatedFilteredStatements.length,
                itemBuilder: (context, statement) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      onTap: (){
                        //context.pushNamed(AppRouteConstants.pdfViewRouteName);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => 
                                          const PDFViewer(),
                            ),
                         );
                      },
                    tileColor: AcmeTheme.blueberry,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    contentPadding: const EdgeInsets.all(15.0),
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text("Monthly Statement",
                             style: AcmeTheme.darkTextTheme.displayMedium),
                        Text('\$${beautifyNumber(_updatedFilteredStatements[statement].amount)}',
                             style: AcmeTheme.darkTextTheme.displaySmall),
                      ]
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_updatedFilteredStatements[statement].date,
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
