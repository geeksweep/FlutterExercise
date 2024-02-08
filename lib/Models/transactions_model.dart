import "package:acmebank/Utils/customdates.dart";

// instead of required you could make this optional if you knew more about nullability of data.
// knowing certain nullability you can check for null and assign default values
class UserTransactions {
  UserTransactions({
     required this.allTransactions
  });

  final List<Transaction> allTransactions;

   UserTransactions.fromJson(List json) 
     : allTransactions = List<Transaction>.from(json.map((x) => Transaction.fromJson(x)));
}
class Transaction {
  Transaction({
    this.id = "",
    required this.date,
    required this.description,
    required this.amount,
    required this.fromAccount,
    required this.toAccount
  });

  String id;
  final String date;
  String description;
  final double amount;
  final String fromAccount;
  final String toAccount;


  Transaction.fromJson(Map<String, dynamic> json) 
   : id = "",
     date = convertDate(json['date']),
     description = json['description'],
     amount = json['amount'].toDouble(),
     fromAccount = json['fromAccount'],
     toAccount = json['toAccount'];
}

