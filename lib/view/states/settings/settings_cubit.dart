import 'package:financial_manager/view/states/settings/settings_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.dart';
part 'settings_cubit.freezed.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState.loading());

  void getSettings() async {
    emit(SettingsState.loading());
    try {
      emit(SettingsState.content(SettingsViewModel.buildWith()));
    } on Exception catch (e) {
      emit(SettingsState.error(e));
    }
  }
}
