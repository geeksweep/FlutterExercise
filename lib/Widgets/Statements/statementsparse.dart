import "package:acmebank/Models/statements_model.dart";
import "package:acmebank/Utils/customdates.dart";

List<String> collectStatementYears(List<Statement> userStatements) {
  List<String> yearList = [];

  for (var statement in userStatements) {
    yearList.add(parseYear(statement.date));
  }

  yearList.sort((a, b) {
    var adate = a; 
    var bdate = b;
    return -adate.compareTo(bdate);
  });

  return yearList.toSet().toList();
}
