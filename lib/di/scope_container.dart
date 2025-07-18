import 'package:financial_manager/view/resources/locale/locale_provider.dart';
import 'package:financial_manager/view/resources/theme/color_themes.dart';
import 'package:yx_scope/yx_scope.dart';

class AppScopeHolder extends ScopeHolder<AppScopeContainer> {
  @override
  AppScopeContainer createContainer() => AppScopeContainer();
}

class AppScopeContainer extends ScopeContainer with Holders {}

mixin Holders on ScopeContainer {
  late final themeHolder = dep(() => ThemeProvider());
  late final localeHolder = dep(() => LocaleProvider());
}
