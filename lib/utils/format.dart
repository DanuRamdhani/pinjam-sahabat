import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String priceFormated(int price, bool wrap) {
  if (wrap == true) {
    if (price >= 1000000) {
      return "${NumberFormat.currency(
        name: 'Rp',
        decimalDigits: 0,
      ).format(price ~/ 1000000)}Jt";
    } else if (price >= 100000) {
      return "${NumberFormat.currency(
        name: 'Rp',
        decimalDigits: 0,
      ).format(price ~/ 1000)}Rb";
    } else {
      return NumberFormat.currency(
        name: 'Rp',
        decimalDigits: 0,
      ).format(price);
    }
  }

  return NumberFormat.currency(
    name: 'Rp',
    decimalDigits: 0,
  ).format(price);
}

String dateFormatted(Timestamp date) {
  return DateFormat('dd/M/yyyy').format(date.toDate());
}
