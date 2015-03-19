// Copyright (c) 2015, the uix project authors. Please see the AUTHORS file for
// details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library uix.src.data.node;

import 'dart:async';
import '../env.dart';

abstract class RevisionedNode {
  int _rev = 0;
  int get rev => _rev;

  void updateRev() { _rev = scheduler.clock; }

  bool isNewer(RevisionedNode other) => _rev > other._rev;
}

abstract class StreamListenerNode {
  List<StreamSubscription> _subscriptions;
  List<StreamSubscription> _subscriptionsOneShot;

  void addSubscription(StreamSubscription s) {
    if (_subscriptions == null) {
      _subscriptions = <StreamSubscription>[];
    }
    _subscriptions.add(s);
  }

  void resetSubscriptions() {
    if (_subscriptions != null) {
      for (var i = 0; i < _subscriptions.length; i++) {
        _subscriptions[i].cancel();
      }
      _subscriptions = null;
    }
  }

  void addSubscriptionOneShot(StreamSubscription s) {
    if (_subscriptionsOneShot == null) {
      _subscriptionsOneShot = <StreamSubscription>[];
    }
    _subscriptionsOneShot.add(s);
  }

  void resetSubscriptionsOneShot() {
    if (_subscriptionsOneShot != null) {
      for (var i = 0; i < _subscriptionsOneShot.length; i++) {
        _subscriptionsOneShot[i].cancel();
      }
      _subscriptionsOneShot = null;
    }
  }
}
