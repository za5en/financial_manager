// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'analysis_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AnalysisState implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AnalysisState'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnalysisState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AnalysisState()';
}


}

/// @nodoc
class $AnalysisStateCopyWith<$Res>  {
$AnalysisStateCopyWith(AnalysisState _, $Res Function(AnalysisState) __);
}


/// @nodoc


class Loading with DiagnosticableTreeMixin implements AnalysisState {
  const Loading();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AnalysisState.loading'))
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
  return 'AnalysisState.loading()';
}


}




/// @nodoc


class Content with DiagnosticableTreeMixin implements AnalysisState {
  const Content(this.content, this.previousContent);
  

 final  AnalysisViewModel content;
 final  AnalysisViewModel? previousContent;

/// Create a copy of AnalysisState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentCopyWith<Content> get copyWith => _$ContentCopyWithImpl<Content>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AnalysisState.content'))
    ..add(DiagnosticsProperty('content', content))..add(DiagnosticsProperty('previousContent', previousContent));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Content&&(identical(other.content, content) || other.content == content)&&(identical(other.previousContent, previousContent) || other.previousContent == previousContent));
}


@override
int get hashCode => Object.hash(runtimeType,content,previousContent);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AnalysisState.content(content: $content, previousContent: $previousContent)';
}


}

/// @nodoc
abstract mixin class $ContentCopyWith<$Res> implements $AnalysisStateCopyWith<$Res> {
  factory $ContentCopyWith(Content value, $Res Function(Content) _then) = _$ContentCopyWithImpl;
@useResult
$Res call({
 AnalysisViewModel content, AnalysisViewModel? previousContent
});




}
/// @nodoc
class _$ContentCopyWithImpl<$Res>
    implements $ContentCopyWith<$Res> {
  _$ContentCopyWithImpl(this._self, this._then);

  final Content _self;
  final $Res Function(Content) _then;

/// Create a copy of AnalysisState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? content = null,Object? previousContent = freezed,}) {
  return _then(Content(
null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as AnalysisViewModel,freezed == previousContent ? _self.previousContent : previousContent // ignore: cast_nullable_to_non_nullable
as AnalysisViewModel?,
  ));
}


}

/// @nodoc


class CustomError with DiagnosticableTreeMixin implements AnalysisState {
  const CustomError(this.error);
  

 final  Exception error;

/// Create a copy of AnalysisState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomErrorCopyWith<CustomError> get copyWith => _$CustomErrorCopyWithImpl<CustomError>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AnalysisState.error'))
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
  return 'AnalysisState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $CustomErrorCopyWith<$Res> implements $AnalysisStateCopyWith<$Res> {
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

/// Create a copy of AnalysisState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(CustomError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as Exception,
  ));
}


}

// dart format on
