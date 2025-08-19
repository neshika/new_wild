import 'package:flutter_test/flutter_test.dart';
import 'package:new_wild/services/helpers.dart';

void main() {
  group('validateEmail', () {
    test('Returns error when Email is null', () {
      expect(validateEmail(null), 'Email cannot be empty');
    });
    test('Returns error when Email is empty', () {
      expect(validateEmail(''), 'Email cannot be empty');
    });
    test('Returns error when Email does not contain "@"', () {
      expect(validateEmail('dfsdf.eff'), 'Please enter a valid email address');
    });
    test('Returns error when Email does not contain "@"', () {
      expect(validateEmail('@dfsdf.eff'), 'Please enter a valid email address');
    });
    test('Returns error when Email does not contain "@"', () {
      expect(validateEmail('dfsdf.eff@'), 'Please enter a valid email address');
    });
    test('Returns null when Email valid', () {
      expect(validateEmail('test@eff.ru'), null);
    });
  });
}
