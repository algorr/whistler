import 'package:bloc/bloc.dart';

/// Change Language State with Cubit
class LanguageCubit extends Cubit<bool> {
  LanguageCubit() : super(false);

  /// The line `bool isLanguageTurkish = false;` is declaring a boolean variable named
  /// `isLanguageTurkish` and initializing it with a value of `false`. This variable is used to keep
  /// track of whether the language is Turkish or not in the context of the `LanguageCubit` class.
  bool isLanguageTurkish = false;

  /// The function `updateLanguage` toggles the language between Turkish and English language and emits
  /// the updated language status.
  void updateLanguage() {
    isLanguageTurkish = !isLanguageTurkish;
    emit(isLanguageTurkish);
  }
}
