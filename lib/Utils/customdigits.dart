import "package:intl/intl.dart";

NumberFormat formatter = NumberFormat.decimalPatternDigits(
    locale: 'en_us',
    decimalDigits: 2,
);

String beautifyNumber(double number){
  String newAmount = formatter.format(number);
  
  return newAmount;
}