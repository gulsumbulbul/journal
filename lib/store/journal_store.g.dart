// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$JournalStore on _JournalStore, Store {
  late final _$selectedDateAtom =
      Atom(name: '_JournalStore.selectedDate', context: context);

  @override
  DateTime get selectedDate {
    _$selectedDateAtom.reportRead();
    return super.selectedDate;
  }

  @override
  set selectedDate(DateTime value) {
    _$selectedDateAtom.reportWrite(value, super.selectedDate, () {
      super.selectedDate = value;
    });
  }

  late final _$_JournalStoreActionController =
      ActionController(name: '_JournalStore', context: context);

  @override
  void updateDate(DateTime newDate) {
    final _$actionInfo = _$_JournalStoreActionController.startAction(
        name: '_JournalStore.updateDate');
    try {
      return super.updateDate(newDate);
    } finally {
      _$_JournalStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedDate: ${selectedDate}
    ''';
  }
}
