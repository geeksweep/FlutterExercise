import "package:acmebank/Utils/customdates.dart";

// instead of required you could make this optional if you knew more about nullability of data.
// knowing certain nullability you can check for null and assign default values
class User {
  User({
     required this.accountNumber,
     required this.address,
     required this.name,
     required this.balance,
     required this.currency,
     required this.recentTransactions,
     required this.upcomingBills
  });

  final String accountNumber;
  final Address address;
  final String name;
  final double balance;
  final String currency;
  final List<TransactionsBills> recentTransactions;
  final List<TransactionsBills> upcomingBills;

   User.fromJson(Map<String, dynamic> json) 
   : accountNumber = json['accountNumber'],
     address = Address.fromJson(json["address"]),
     name = json['name'],
     balance = json['balance'],
     currency = json['currency'],
     recentTransactions = List<TransactionsBills>.from(json["recentTransactions"].map((x) => TransactionsBills.fromJson(x))),
     upcomingBills = List<TransactionsBills>.from(json["upcomingBills"].map((x) => TransactionsBills.fromJson(x)));
}

class Address {
  Address({
      required this.postCode,
      required this.country,
      required this.buildingNumber,
      required this.streetName,
      required this.townName
  });
   
   final String postCode;
   final String country;
   final String buildingNumber;
   final String streetName;
   final String townName;

  Address.fromJson(Map<String, dynamic> json) 
   : postCode = json['postCode'],
     country = json['country'],
     buildingNumber = json['buildingNumber'],
     streetName = json['streetName'],
     townName = json['townName'];
  }

// same format for transactions and bills but these models could be different later.
class TransactionsBills {
  TransactionsBills({
    required this.date,
    required this.description,
    required this.amount,
    required this.fromAccount,
    required this.toAccount
  });

  final String date;
  final String description;
  final double amount;
  final String fromAccount;
  final String toAccount;


  TransactionsBills.fromJson(Map<String, dynamic> json) 
   : date = convertDate(json['date']),
     description = json['description'],
     amount = json['amount'].toDouble(),
     fromAccount = json['fromAccount'],
     toAccount = json['toAccount'];
}

