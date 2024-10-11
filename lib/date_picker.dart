import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:journal/store/journal_store.dart';

class DateSelector extends StatelessWidget {
  final JournalStore store;

  const DateSelector({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Observer(
        builder: (_) {
          String formattedDate =
              DateFormat('EEEE, MMMM d').format(store.selectedDate);
          return Text(
            formattedDate,
            style: TextStyle(color: Colors.black),
          );
        },
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: store.selectedDate,
      //seçim kontrol
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
    );
    // yeni bir tarih seçildi mi
    if (picked != null && picked != store.selectedDate) {
      store.updateDate(picked);
    }
  }
}
