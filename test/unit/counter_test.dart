import 'package:flutter_test/flutter_test.dart';

import '../../lib/utils/counter.dart';

void main() {
  group('Counter', () {
    final counter = Counter();

    test('value should start at 0', () {
      expect(counter.value, 0);
    });
    test('Counter value should be incremented', () {
      counter.increment();

      expect(counter.value, 1);
    });

    test('value should be decremented', () {
      counter.decrement();
      counter.decrement();

      expect(counter.value, -1);
    });

    test('value should end at 0', () {
      counter.increment();

      expect(counter.value, 0);
    });
  });
}
