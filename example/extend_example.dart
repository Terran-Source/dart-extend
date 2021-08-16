import 'dart:convert';

import 'package:extend/extend.dart';

const _encoder = JsonEncoder.withIndent('  ');

final source = {
  'complex': {
    'subKey': 'subValueOther',
    'subComplex': {
      'deepNewKey': 'deepNewValue',
    }
  },
  'newKey': 'newValue'
};

void main() {
  mapExtend();
  mapExtendWithEmptyTarget();
  extendMap();
  extendMapWithEmptyTarget();
  extendAllMap();
  extendAllMapWithEmptyTarget();
}

void mapExtend() {
  print('Map.extend():');
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
  print('baseObj: \n${_encoder.convert(baseObj)}');
  print('source: \n${_encoder.convert(source)}');

  baseObj.extend(source);

  print('After extend:');
  print('baseObj: \n${_encoder.convert(baseObj)}');
  // output:
  // {
  //   "dummy": "x",
  //   "complex": {
  //     "subKey": "subValueOther", 👈 is extended
  //     "subComplex": {
  //       "deepKey": "deepValue", 👈 remains unchanged
  //       "deepNewKey": "deepNewValue"  👈 is added
  //     },
  //     "subUndefined": null
  //   },
  //   "baseUndefined": null,
  //   "newKey": "newValue"  👈 is added
  // }
}

void mapExtendWithEmptyTarget() {
  print('Map.extend() with empty base:');
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
  print('baseObj: \n${_encoder.convert(baseObj)}');
  print('source: \n${_encoder.convert(source)}');

  // Try to extend an `Immutable` `Map` with empty map as [target]
  final result = {}.extend(baseObj, [source]);

  print('After extend:');
  print('result: \n${_encoder.convert(result)}');
  // output:
  // {
  //   "dummy": "x",
  //   "complex": {
  //     "subKey": "subValueOther", 👈 is extended
  //     "subComplex": {
  //       "deepKey": "deepValue", 👈 remains unchanged
  //       "deepNewKey": "deepNewValue"  👈 is added
  //     },
  //     "subUndefined": null
  //   },
  //   "baseUndefined": null,
  //   "newKey": "newValue"  👈 is added
  // }

  print('baseObj: \n${_encoder.convert(baseObj)}');
  // output: it's unchanged
  // {
  //   "dummy": "x",
  //   "complex": {
  //     "subKey": "subValue",
  //     "subComplex": {
  //       "deepKey": "deepValue"
  //     },
  //     "subUndefined": null
  //   },
  //   "baseUndefined": null
  // }
}

void extendMap() {
  print('extend():');
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
  print('baseObj: \n${_encoder.convert(baseObj)}');
  print('source: \n${_encoder.convert(source)}');

  extend(baseObj, source);

  print('After extend:');
  print('baseObj: \n${_encoder.convert(baseObj)}');
  // output:
  // {
  //   "dummy": "x",
  //   "complex": {
  //     "subKey": "subValueOther", 👈 is extended
  //     "subComplex": {
  //       "deepKey": "deepValue", 👈 remains unchanged
  //       "deepNewKey": "deepNewValue"  👈 is added
  //     },
  //     "subUndefined": null
  //   },
  //   "baseUndefined": null,
  //   "newKey": "newValue"  👈 is added
  // }
}

void extendMapWithEmptyTarget() {
  print('extend() with empty base:');
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
  print('baseObj: \n${_encoder.convert(baseObj)}');
  print('source: \n${_encoder.convert(source)}');

  // Try to extend an `Immutable` `Map` with empty map as [target]
  final result = extend({}, baseObj, [source]);

  print('After extend:');
  print('result: \n${_encoder.convert(result)}');
  // output:
  // {
  //   "dummy": "x",
  //   "complex": {
  //     "subKey": "subValueOther", 👈 is extended
  //     "subComplex": {
  //       "deepKey": "deepValue", 👈 remains unchanged
  //       "deepNewKey": "deepNewValue"  👈 is added
  //     },
  //     "subUndefined": null
  //   },
  //   "baseUndefined": null,
  //   "newKey": "newValue"  👈 is added
  // }

  print('baseObj: \n${_encoder.convert(baseObj)}');
  // output: it's unchanged
  // {
  //   "dummy": "x",
  //   "complex": {
  //     "subKey": "subValue",
  //     "subComplex": {
  //       "deepKey": "deepValue"
  //     },
  //     "subUndefined": null
  //   },
  //   "baseUndefined": null
  // }
}

void extendAllMap() {
  print('extendAll():');
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
  print('baseObj: \n${_encoder.convert(baseObj)}');
  print('source: \n${_encoder.convert(source)}');

  extendAll(baseObj, [source]);

  print('After extend:');
  print('baseObj: \n${_encoder.convert(baseObj)}');
  // output:
  // {
  //   "dummy": "x",
  //   "complex": {
  //     "subKey": "subValueOther", 👈 is extended
  //     "subComplex": {
  //       "deepKey": "deepValue", 👈 remains unchanged
  //       "deepNewKey": "deepNewValue"  👈 is added
  //     },
  //     "subUndefined": null
  //   },
  //   "baseUndefined": null,
  //   "newKey": "newValue"  👈 is added
  // }
}

void extendAllMapWithEmptyTarget() {
  print('extendAll() with empty base:');
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
  print('baseObj: \n${_encoder.convert(baseObj)}');
  print('source: \n${_encoder.convert(source)}');

  // Try to extend an `Immutable` `Map` with empty map as [target]
  final result = extendAll({}, [baseObj, source]);

  print('After extend:');
  print('result: \n${_encoder.convert(result)}');
  // output:
  // {
  //   "dummy": "x",
  //   "complex": {
  //     "subKey": "subValueOther", 👈 is extended
  //     "subComplex": {
  //       "deepKey": "deepValue", 👈 remains unchanged
  //       "deepNewKey": "deepNewValue"  👈 is added
  //     },
  //     "subUndefined": null
  //   },
  //   "baseUndefined": null,
  //   "newKey": "newValue"  👈 is added
  // }

  print('baseObj: \n${_encoder.convert(baseObj)}');
  // output: it's unchanged
  // {
  //   "dummy": "x",
  //   "complex": {
  //     "subKey": "subValue",
  //     "subComplex": {
  //       "deepKey": "deepValue"
  //     },
  //     "subUndefined": null
  //   },
  //   "baseUndefined": null
  // }
}
