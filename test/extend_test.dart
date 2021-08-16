import 'dart:convert';

import 'package:extend/extend.dart';
import 'package:interpolation/interpolation.dart';
import 'package:test/test.dart';

void main() {
  final interpolation = Interpolation();
  late Map base;
  late Map source;

  setUp(() {
    base = {
      'dummy': 'x',
      'complex': {
        'subKey': 'subValue',
        'subComplex': {
          'deepKey': 'deepValue',
        },
        'subUndefined': null,
      },
      'baseUndefined': null,
    };

    source = {
      'complex': {
        'subKey': 'subValueOther',
      },
      'newKey': 'newValue'
    };
  });

  tearDown(() {
    base = {};
    source = {};
  });

  group('Map.extend():', () {
    test('Test', () async {
      base.extend(source);

      expect(interpolation.traverse(base, 'complex.subKey'), 'subValueOther');
      expect(interpolation.traverse(base, 'newKey'), 'newValue');
    });

    test('Test with empty base', () async {
      final beforeExtend = json.encode(base);

      final result = {}.extend(base, [source]);

      expect(interpolation.traverse(result, 'complex.subKey'), 'subValueOther');
      expect(interpolation.traverse(result, 'newKey'), 'newValue');
      expect(interpolation.traverse(base, 'complex.subKey'), 'subValue');
      expect(interpolation.traverse(base, 'newKey'), '');
      expect(json.encode(base), beforeExtend);
    });

    test('Test with empty source', () async {
      final beforeExtend = json.encode(base);
      base.extend({});

      expect(json.encode(base), beforeExtend);
    });
  });

  group('extend():', () {
    test('Test', () async {
      extend(base, source);

      expect(interpolation.traverse(base, 'complex.subKey'), 'subValueOther');
      expect(interpolation.traverse(base, 'newKey'), 'newValue');
    });

    test('Test with empty base', () async {
      final beforeExtend = json.encode(base);

      final result = extend({}, base, [source]);

      expect(interpolation.traverse(result, 'complex.subKey'), 'subValueOther');
      expect(interpolation.traverse(result, 'newKey'), 'newValue');
      expect(interpolation.traverse(base, 'complex.subKey'), 'subValue');
      expect(interpolation.traverse(base, 'newKey'), '');
      expect(json.encode(base), beforeExtend);
    });

    test('Test with empty source', () async {
      final beforeExtend = json.encode(base);
      extend(base, {});

      expect(json.encode(base), beforeExtend);
    });
  });

  group('extendAll():', () {
    test('Test', () async {
      extendAll(base, [source]);

      expect(interpolation.traverse(base, 'complex.subKey'), 'subValueOther');
      expect(interpolation.traverse(base, 'newKey'), 'newValue');
    });

    test('Test with empty base', () async {
      final beforeExtend = json.encode(base);

      final result = extendAll({}, [base, source]);

      expect(interpolation.traverse(result, 'complex.subKey'), 'subValueOther');
      expect(interpolation.traverse(result, 'newKey'), 'newValue');
      expect(interpolation.traverse(base, 'complex.subKey'), 'subValue');
      expect(interpolation.traverse(base, 'newKey'), '');
      expect(json.encode(base), beforeExtend);
    });

    test('Test with empty source', () async {
      final beforeExtend = json.encode(base);
      extendAll(base, [{}]);

      expect(json.encode(base), beforeExtend);
    });
  });
}
