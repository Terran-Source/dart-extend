extension ExtendJson on Map {
  /// A Dart port of classic `extend()` method from jQuery. It [extend]s an
  /// existing ***`Mutable`*** `Map` with another [source]. It can be extended
  /// by multiple additional [sources] in a sequence.
  ///
  /// **Beware**: the original `Map` will be modified and will be returned
  ///
  /// Example:
  /// ```
  /// // Don't use `const` or `final`. It'll make the Map `Immutable`
  /// var baseObj = {
  ///   'dummy': 'x',
  ///   'complex': {
  ///     'subKey': 'subValue',
  ///     'subComplex': {
  ///       'deepKey': 'deepValue',
  ///     },
  ///     'subUndefined': null
  ///   },
  ///   'baseUndefined': null
  /// };
  ///
  /// final result = baseObj.extend({
  ///   'complex': {
  ///     'subKey': 'subValueOther',
  ///     'subComplex': {'deepNewKey': 'deepNewValue'}
  ///   },
  ///   'newKey': 'newValue'
  /// });
  /// print(result);
  /// // beware, the original object is also changed
  /// print(baseObj);
  /// // in case, if you have one Immutable Map or don't want to change the
  /// // original Map, try to extend an empty Map
  /// final result = {}.extend(baseObj, [
  ///   {
  ///     'complex': {
  ///       'subKey': 'subValueOther',
  ///       'subComplex': {'deepNewKey': 'deepNewValue'}
  ///     },
  ///     'newKey': 'newValue'
  ///   }
  /// ]);
  ///
  /// print(result);
  /// ```
  /// Output:
  /// ```
  /// {
  ///   "dummy": "x",
  ///   "complex": {
  ///     "subKey": "subValueOther", // 👈 is extended
  ///     "subComplex": {
  ///       "deepKey": "deepValue", // 👈 remains unchanged
  ///       "deepNewKey": "deepNewValue"  // 👈 is added
  ///     },
  ///     "subUndefined": null
  ///   },
  ///   "baseUndefined": null,
  ///   "newKey": "newValue"  // 👈 is added
  /// }
  /// ```
  Map extend(Map source, [Iterable<Map>? sources]) {
    source.forEach((key, val) {
      if (containsKey(key)) {
        remove(key); // essential to remove the existing reference
        if (source[key] is! Map) {
          this[key] = source[key];
        } else if (this[key] is! Map) {
          this[key] = Map.of(source[key] as Map);
        } else {
          (this[key] as Map).extend(Map.from(source[key] as Map));
        }
      } else {
        this[key] = source[key];
      }
    });
    if (null != sources && sources.isNotEmpty) {
      final nextSource = sources.first;
      final nextSources = sources.skip(1);
      extend(nextSource, nextSources);
    }
    return this;
  }
}

/// A Dart port of classic `extend()` method from jQuery. It [extend]s an
/// existing ***`Mutable`*** [target] with another [source]. It can be extended
/// by multiple additional [sources] in a sequence.
///
/// **Beware**: the original [target] will be modified and will be returned
///
/// Example:
/// ```
/// // Don't use `const` or `final`. It'll make the Map `Immutable`
/// var baseObj = {
///   'dummy': 'x',
///   'complex': {
///     'subKey': 'subValue',
///     'subComplex': {
///       'deepKey': 'deepValue',
///     },
///     'subUndefined': null
///   },
///   'baseUndefined': null
/// };
///
/// final result = extend(baseObj,
/// {
///   'complex': {
///     'subKey': 'subValueOther',
///     'subComplex': {'deepNewKey': 'deepNewValue'}
///   },
///   'newKey': 'newValue'
/// });
/// print(result);
/// // beware, the original object is also changed
/// print(baseObj);
/// // in case, if you have one Immutable Map or don't want to change the
/// // original Map, try to extend an empty Map
/// final result = extend({}, baseObj,
/// [
///   {
///     'complex': {
///       'subKey': 'subValueOther',
///       'subComplex': {'deepNewKey': 'deepNewValue'}
///     },
///     'newKey': 'newValue'
///   }
/// ]);
///
/// print(result);
/// ```
/// Output:
/// ```
/// {
///   "dummy": "x",
///   "complex": {
///     "subKey": "subValueOther", // 👈 is extended
///     "subComplex": {
///       "deepKey": "deepValue", // 👈 remains unchanged
///       "deepNewKey": "deepNewValue"  // 👈 is added
///     },
///     "subUndefined": null
///   },
///   "baseUndefined": null,
///   "newKey": "newValue"  // 👈 is added
/// }
/// ```
Map extend(Map target, Map source, [Iterable<Map>? sources]) =>
    target.extend(source, sources);

/// A Dart port of classic `extend()` method from jQuery with a little twist. It
/// extends an existing ***`Mutable`*** [target] with multiple additional
/// [sources] in a sequence.
///
/// **Beware**: the original [target] will be modified and will be returned
///
/// Example:
/// ```
/// // Don't use `const` or `final`. It'll make the Map `Immutable`
/// var baseObj = {
///   'dummy': 'x',
///   'complex': {
///     'subKey': 'subValue',
///     'subComplex': {
///       'deepKey': 'deepValue',
///     },
///     'subUndefined': null
///   },
///   'baseUndefined': null
/// };
///
/// final result = extendAll(baseObj,
/// [
///   {
///     'complex': {
///       'subKey': 'subValueOther',
///       'subComplex': {'deepNewKey': 'deepNewValue'}
///     },
///     'newKey': 'newValue'
///   }
/// ]);
/// print(result);
/// // beware, the original object is also changed
/// print(baseObj);
/// // in case, if you have one Immutable Map or don't want to change the
/// // original Map, try to extend an empty Map
/// final result = extendAll({},
/// [
///   baseObj,
///   {
///     'complex': {
///       'subKey': 'subValueOther',
///       'subComplex': {'deepNewKey': 'deepNewValue'}
///     },
///     'newKey': 'newValue'
///   }
/// ]);
///
/// print(result);
/// ```
/// Output:
/// ```
/// {
///   "dummy": "x",
///   "complex": {
///     "subKey": "subValueOther", // 👈 is extended
///     "subComplex": {
///       "deepKey": "deepValue", // 👈 remains unchanged
///       "deepNewKey": "deepNewValue"  // 👈 is added
///     },
///     "subUndefined": null
///   },
///   "baseUndefined": null,
///   "newKey": "newValue"  // 👈 is added
/// }
/// ```
Map extendAll(Map target, Iterable<Map> sources) =>
    target.extend(sources.first, sources.skip(1));
