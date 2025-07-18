// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manage_transaction_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ManageTransactionState implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ManageTransactionState'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ManageTransactionState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ManageTransactionState()';
}


}

/// @nodoc
class $ManageTransactionStateCopyWith<$Res>  {
$ManageTransactionStateCopyWith(ManageTransactionState _, $Res Function(ManageTransactionState) __);
}


/// Adds pattern-matching-related methods to [ManageTransactionState].
extension ManageTransactionStatePatterns on ManageTransactionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( EditLoading value)?  loading,TResult Function( EditContent value)?  content,TResult Function( EditError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case EditLoading() when loading != null:
return loading(_that);case EditContent() when content != null:
return content(_that);case EditError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( EditLoading value)  loading,required TResult Function( EditContent value)  content,required TResult Function( EditError value)  error,}){
final _that = this;
switch (_that) {
case EditLoading():
return loading(_that);case EditContent():
return content(_that);case EditError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( EditLoading value)?  loading,TResult? Function( EditContent value)?  content,TResult? Function( EditError value)?  error,}){
final _that = this;
switch (_that) {
case EditLoading() when loading != null:
return loading(_that);case EditContent() when content != null:
return content(_that);case EditError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( ManageTransactionViewModel content)?  content,TResult Function( Exception error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case EditLoading() when loading != null:
return loading();case EditContent() when content != null:
return content(_that.content);case EditError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( ManageTransactionViewModel content)  content,required TResult Function( Exception error)  error,}) {final _that = this;
switch (_that) {
case EditLoading():
return loading();case EditContent():
return content(_that.content);case EditError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( ManageTransactionViewModel content)?  content,TResult? Function( Exception error)?  error,}) {final _that = this;
switch (_that) {
case EditLoading() when loading != null:
return loading();case EditContent() when content != null:
return content(_that.content);case EditError() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class EditLoading with DiagnosticableTreeMixin implements ManageTransactionState {
  const EditLoading();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ManageTransactionState.loading'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ManageTransactionState.loading()';
}


}




/// @nodoc


class EditContent with DiagnosticableTreeMixin implements ManageTransactionState {
  const EditContent(this.content);
  

 final  ManageTransactionViewModel content;

/// Create a copy of ManageTransactionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditContentCopyWith<EditContent> get copyWith => _$EditContentCopyWithImpl<EditContent>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ManageTransactionState.content'))
    ..add(DiagnosticsProperty('content', content));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditContent&&(identical(other.content, content) || other.content == content));
}


@override
int get hashCode => Object.hash(runtimeType,content);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ManageTransactionState.content(content: $content)';
}


}

/// @nodoc
abstract mixin class $EditContentCopyWith<$Res> implements $ManageTransactionStateCopyWith<$Res> {
  factory $EditContentCopyWith(EditContent value, $Res Function(EditContent) _then) = _$EditContentCopyWithImpl;
@useResult
$Res call({
 ManageTransactionViewModel content
});




}
/// @nodoc
class _$EditContentCopyWithImpl<$Res>
    implements $EditContentCopyWith<$Res> {
  _$EditContentCopyWithImpl(this._self, this._then);

  final EditContent _self;
  final $Res Function(EditContent) _then;

/// Create a copy of ManageTransactionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? content = null,}) {
  return _then(EditContent(
null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as ManageTransactionViewModel,
  ));
}


}

/// @nodoc


class EditError with DiagnosticableTreeMixin implements ManageTransactionState {
  const EditError(this.error);
  

 final  Exception error;

/// Create a copy of ManageTransactionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditErrorCopyWith<EditError> get copyWith => _$EditErrorCopyWithImpl<EditError>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ManageTransactionState.error'))
    ..add(DiagnosticsProperty('error', error));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ManageTransactionState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $EditErrorCopyWith<$Res> implements $ManageTransactionStateCopyWith<$Res> {
  factory $EditErrorCopyWith(EditError value, $Res Function(EditError) _then) = _$EditErrorCopyWithImpl;
@useResult
$Res call({
 Exception error
});




}
/// @nodoc
class _$EditErrorCopyWithImpl<$Res>
    implements $EditErrorCopyWith<$Res> {
  _$EditErrorCopyWithImpl(this._self, this._then);

  final EditError _self;
  final $Res Function(EditError) _then;

/// Create a copy of ManageTransactionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(EditError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as Exception,
  ));
}


}

// dart format on
