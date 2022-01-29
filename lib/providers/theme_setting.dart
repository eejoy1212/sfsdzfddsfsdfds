import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class ThemeSettingProviderState extends Equatable {
  final bool isChanged;

  ThemeSettingProviderState({
    required this.isChanged,
  });
  factory ThemeSettingProviderState.initial() {
    return ThemeSettingProviderState(isChanged: false);
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ThemeSettingProvider with ChangeNotifier {
  ThemeSettingProviderState _state = ThemeSettingProviderState.initial();
  ThemeSettingProviderState get state => _state;

  bool changeTheme(bool isChanged) {
    if (isChanged == false) {
      isChanged = true;
      return isChanged;
    }
    if (isChanged == true) {
      isChanged = false;
      return isChanged;
    }
    return isChanged;
  }
}
