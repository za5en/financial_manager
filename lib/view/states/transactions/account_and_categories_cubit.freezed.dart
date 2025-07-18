// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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


/// Adds pattern-matching-related methods to [AccountAndCategoriesState].
extension AccountAndCategoriesStatePatterns on AccountAndCategoriesState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Loading value)?  loading,TResult Function( Content value)?  content,TResult Function( CustomError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Loading() when loading != null:
return loading(_that);case Content() when content != null:
return content(_that);case CustomError() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Loading value)  loading,required TResult Function( Content value)  content,required TResult Function( CustomError value)  error,}){
final _that = this;
switch (_that) {
case Loading():
return loading(_that);case Content():
return content(_that);case CustomError():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Loading value)?  loading,TResult? Function( Content value)?  content,TResult? Function( CustomError value)?  error,}){
final _that = this;
switch (_that) {
case Loading() when loading != null:
return loading(_that);case Content() when content != null:
return content(_that);case CustomError() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( AccountAndCategoriesViewModel? content,  ManageTransactionLocal? transactionContent)?  content,TResult Function( Exception error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Loading() when loading != null:
return loading();case Content() when content != null:
return content(_that.content,_that.transactionContent);case CustomError() when error != null:
return error(_that.error);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( AccountAndCategoriesViewModel? content,  ManageTransactionLocal? transactionContent)  content,required TResult Function( Exception error)  error,}) {final _that = this;
switch (_that) {
case Loading():
return loading();case Content():
return content(_that.content,_that.transactionContent);case CustomError():
return error(_that.error);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( AccountAndCategoriesViewModel? content,  ManageTransactionLocal? transactionContent)?  content,TResult? Function( Exception error)?  error,}) {final _that = this;
switch (_that) {
case Loading() when loading != null:
return loading();case Content() when content != null:
return content(_that.content,_that.transactionContent);case CustomError() when error != null:
return error(_that.error);case _:
  return null;

}
}

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
