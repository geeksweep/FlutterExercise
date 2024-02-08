import "package:flutter/material.dart";
import "package:intl/intl.dart";


String convertDate(String date) {
    return DateFormat("MM-dd-yyyy").format(DateTime.parse(date));    
  }

String parseYear(String date){
  return date.characters.take(4).toString();
}