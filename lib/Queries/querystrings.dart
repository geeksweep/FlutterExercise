enum QueryTypes {
  home, accounts, contacts, statements, transactions
}

const String home = """
query homeQuery {
  home {
    accountNumber
    address {
      postCode
      streetName
      townName
      country
      buildingNumber
    }
    balance
    currency
    name
    recentTransactions {
      amount
      date
      description
      fromAccount
      toAccount
    }
    upcomingBills {
      amount
      date
      description
      fromAccount
      toAccount
    }
  }
}
""";

const String accounts = """
query accountsQuery {
  accounts {
    accountHolder
    accountNumber
    accountType
    balance
    id
  }
}
""";

const String contacts = """
query contactsQuery {
  contacts
 }
""";

const String statements = """ 
query statementsQuery {
  statements {
    date
    description
    amount
  }
}
""";

const String transactions = """
  query transactionsQuery {
  transactions {
    amount
    date
    description
    fromAccount
    toAccount
  }
}
""";


extension QueryExtension on QueryTypes {
  String get name {
    print("query name: $this");
    switch(this){
      case QueryTypes.home:
        return home;
      case QueryTypes.accounts:
        return accounts;
      case QueryTypes.contacts:
        return contacts;
      case QueryTypes.statements:
        return statements;
      case QueryTypes.transactions:
        return transactions;
    }
  }
}