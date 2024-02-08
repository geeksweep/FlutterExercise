// instead of required you could make this optional if you knew more about nullability of data.
// knowing certain nullability you can check for null and assign default values
class UserAccounts {
  UserAccounts({
     required this.allAccounts
  });

  final List<Account> allAccounts;

   UserAccounts.fromJson(List json) 
     : allAccounts = List<Account>.from(json.map((x) => Account.fromJson(x)));
}

class Account {
  Account({
     required this.accountHolder,
     required this.accountNumber,
     required this.accountType,
     required this.balance,
     required this.id,
  });
   
  final String accountHolder;
  final String accountNumber;
  final String accountType;
  final double balance;
  final String id;

  Account.fromJson(Map<String, dynamic> json) 
   : accountHolder = json['accountHolder'],
     accountNumber = json['accountNumber'],
     accountType = json['accountType'],
     balance = json['balance'],
     id = json['id'];
  }