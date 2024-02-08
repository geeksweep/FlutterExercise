import 'package:acmebank/Utils/customdates.dart';

class Statements {
  Statements({
     required this.allStatements
  });

  final List<Statement> allStatements;
  final List<String> possibleStatementYears = [];

   Statements.fromJson(List json) 
     : allStatements = List<Statement>.from(json.map((x) => Statement.fromJson(x)));
}

class Statement {
  Statement({
     required this.date,
     required this.description,
     required this.amount,
     this.year = ""
  });
   
  final String date;
  final String description;
  final double amount;
  String year;

  Statement.fromJson(Map<String, dynamic> json) 
   : date = (json['date']),
     description = json['description'],
     amount = json['amount'],
     year = parseYear(json['date']);
  }
  