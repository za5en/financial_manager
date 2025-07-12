// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_and_categories_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AccountAndCategoriesState implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AccountAndCategoriesState'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountAndCategoriesState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AccountAndCategoriesState()';
}


}

/// @nodoc
class $AccountAndCategoriesStateCopyWith<$Res>  {
$AccountAndCategoriesStateCopyWith(AccountAndCategoriesState _, $Res Function(AccountAndCategoriesState) __);
}


/// @nodoc


class Loading with DiagnosticableTreeMixin implements AccountAndCategoriesState {
  const Loading();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AccountAndCategoriesState.loading'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AccountAndCategoriesState.loading()';
}


}




/// @nodoc


class Content with DiagnosticableTreeMixin implements AccountAndCategoriesState {
  const Content({this.content, this.transactionContent});
  

 final  AccountAndCategoriesViewModel? content;
 final  ManageTransactionLocal? transactionContent;

/// Create a copy of AccountAndCategoriesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentCopyWith<Content> get copyWith => _$ContentCopyWithImpl<Content>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AccountAndCategoriesState.content'))
    ..add(DiagnosticsProperty('content', content))..add(DiagnosticsProperty('transactionContent', transactionContent));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Content&&(identical(other.content, content) || other.content == content)&&(identical(other.transactionContent, transactionContent) || other.transactionContent == transactionContent));
}


@override
int get hashCode => Object.hash(runtimeType,content,transactionContent);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AccountAndCategoriesState.content(content: $content, transactionContent: $transactionContent)';
}


}

/// @nodoc
abstract mixin class $ContentCopyWith<$Res> implements $AccountAndCategoriesStateCopyWith<$Res> {
  factory $ContentCopyWith(Content value, $Res Function(Content) _then) = _$ContentCopyWithImpl;
@useResult
$Res call({
 AccountAndCategoriesViewModel? content, ManageTransactionLocal? transactionContent
});




}
/// @nodoc
class _$ContentCopyWithImpl<$Res>
    implements $ContentCopyWith<$Res> {
  _$ContentCopyWithImpl(this._self, this._then);

  final Content _self;
  final $Res Function(Content) _then;

/// Create a copy of AccountAndCategoriesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? content = freezed,Object? transactionContent = freezed,}) {
  return _then(Content(
content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as AccountAndCategoriesViewModel?,transactionContent: freezed == transactionContent ? _self.transactionContent : transactionContent // ignore: cast_nullable_to_non_nullable
as ManageTransactionLocal?,
  ));
}


}

/// @nodoc


class CustomError with DiagnosticableTreeMixin implements AccountAndCategoriesState {
  const CustomError(this.error);
  

 final  Exception error;

/// Create a copy of AccountAndCategoriesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomErrorCopyWith<CustomError> get copyWith => _$CustomErrorCopyWithImpl<CustomError>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AccountAndCategoriesState.error'))
    ..add(DiagnosticsProperty('error', error));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AccountAndCategoriesState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $CustomErrorCopyWith<$Res> implements $AccountAndCategoriesStateCopyWith<$Res> {
  factory $CustomErrorCopyWith(CustomError value, $Res Function(CustomError) _then) = _$CustomErrorCopyWithImpl;
@useResult
$Res call({
 Exception error
});




}
/// @nodoc
class _$CustomErrorCopyWithImpl<$Res>
    implements $CustomErrorCopyWith<$Res> {
  _$CustomErrorCopyWithImpl(this._self, this._then);

  final CustomError _self;
  final $Res Function(CustomError) _then;

/// Create a copy of AccountAndCategoriesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(CustomError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as Exception,
  ));
}


}

// dart format on
