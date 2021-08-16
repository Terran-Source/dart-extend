# extend [![Pub version](https://img.shields.io/pub/v/extend.svg?style=plastic)](https://pub.dev/packages/extend) [![GitHub](https://img.shields.io/github/license/Terran-Source/dart-extend?logo=github&style=plastic)](LICENSE)

A Dart port of classic `extend()` method from jQuery. It `extend` an existing Mutable Map with another `source`. It can be extended by multiple additional `sources` in a sequence.

***Beware***: the original Map will be modified and will be returned.

Example:
```Dart
// Don't use `const` or `final`. It'll make the Map `Immutable`
var baseObj = {
  'dummy': 'x',
  'complex': {
    'subKey': 'subValue',
    'subComplex': {
      'deepKey': 'deepValue',
    },
    'subUndefined': null
  },
  'baseUndefined': null
};

final result = baseObj.extend({
  'complex': {
    'subKey': 'subValueOther',
    'subComplex': {'deepNewKey': 'deepNewValue'}
  },
  'newKey': 'newValue'
});
// beware, the original object is also changed
print(baseObj);
// Hence, you may discard using result
print(result);
// in case, if you have one Immutable Map or don't want to change the
// original Map, try to extend an empty Map
final result = {}.extend(baseObj, [
  {
    'complex': {
      'subKey': 'subValueOther',
      'subComplex': {'deepNewKey': 'deepNewValue'}
    },
    'newKey': 'newValue'
  }
]);

print(result);
```
Output:
```Json
{
  "dummy": "x",
  "complex": {
    "subKey": "subValueOther", // 👈 is extended
    "subComplex": {
      "deepKey": "deepValue", // 👈 remains unchanged
      "deepNewKey": "deepNewValue"  // 👈 is added
    },
    "subUndefined": null
  },
  "baseUndefined": null,
  "newKey": "newValue"  // 👈 is added
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/Terran-Source/dart-extend/issues
