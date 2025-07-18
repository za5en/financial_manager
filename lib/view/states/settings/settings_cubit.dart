import 'package:financial_manager/data/local/local_auth_service.dart';
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
      emit(SettingsState.content(SettingsViewModel.buildWith(false)));
    } on Exception catch (e) {
      emit(SettingsState.error(e));
    }
  }

  void getBiometricsInfo() async {
    emit(SettingsState.loading());
    try {
      var auth = await LocalAuthService.canAuthenticate();
      emit(SettingsState.content(SettingsViewModel.buildWith(auth)));
    } on Exception catch (e) {
      emit(SettingsState.error(e));
    }
  }
}
