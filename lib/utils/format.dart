import 'package:intl/intl.dart';

String priceFormated(int price) => NumberFormat.currency(
      name: 'IDR ',
      decimalDigits: 0,
    ).format(price);
