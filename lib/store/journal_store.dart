import 'package:mobx/mobx.dart';

part 'journal_store.g.dart';

class JournalStore = _JournalStore with _$JournalStore;

abstract class _JournalStore with Store {
  //tarihin değişmesini gözlemler
  @observable
  DateTime selectedDate = DateTime.now();
  //tarihi günceller
  @action
  void updateDate(DateTime newDate) {
    selectedDate = newDate;
  }
}
