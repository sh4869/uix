// Copyright (c) 2015, the uix project authors. Please see the AUTHORS file for
// details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library uix.example.state_diff.main;

import 'dart:async';
import 'dart:html' as html;
import 'package:uix/uix.dart';

class Counter {
  StreamController _sc = new StreamController.broadcast();
  Stream get onChange => _sc.stream;

  int _value = 0;
  int get value => _value;
  set value(int v) {
    _value = v;
    _sc.add(null);
  }
}

class CounterStore {
  Counter counter = new Counter();

  CounterStore() {
    new Timer.periodic(const Duration(milliseconds: 200), (_) {
      counter.value++;
    });
  }
}

CounterStore store;

class CounterView extends Component {
  int _counter;

  updateState() {
    final c = store.counter;
    addTransientSubscription(c.onChange.listen(invalidate));
    if (_counter != c.value) {
      _counter = c.value;
      return true;
    }
    return false;
  }

  updateView() { updateRoot(vRoot()('Counter: $_counter')); }
}

main() {
  initUix();

  store = new CounterStore();

  injectComponent(new CounterView(), html.document.body);
}
