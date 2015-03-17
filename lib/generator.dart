// Copyright (c) 2015, the uix project authors. Please see the AUTHORS file for
// details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library uix.generator;

import 'dart:async';
import 'package:analyzer/src/generated/element.dart';

import 'package:source_gen/source_gen.dart';
import 'package:source_gen/src/utils.dart';

import 'src/meta.dart';

class UixGenerator extends GeneratorForAnnotation<ComponentMeta> {
  const UixGenerator();

  @override
  Future<String> generateForAnnotatedElement(Element element, ComponentMeta annotation) async {
    if (element is! ClassElement) {
      final friendlyName = frieldlyNameForElement(element);
      throw new InvalidGenerationSourceError(
          'Generator cannot target `$friendlyName`.',
          todo: 'Remove the ComponentMeta annotation from `$friendlyName`.');
    }

    final classElement = element as ClassElement;
    final classArguments = classElement.supertype.typeArguments;
    final className = classElement.name;

    final createFnName = 'create$className';

    var dataClassName = classArguments[0].name;

    var flags = 'VNode.componentFlag';
    if (annotation.dirtyCheck) {
      flags += ' | VNode.dirtyCheckFlag';
    }

    final buffer = new StringBuffer();

    buffer.writeln('$className $createFnName([$dataClassName data]) {');
    buffer.writeln('  final r = new $className()');
    buffer.writeln('    ..data = data;');
    buffer.writeln('  return r;');
    buffer.writeln('}');
    buffer.writeln('VNode v$className({$dataClassName data, Object key, String type, Map<String, String> attrs, Map<String, String> style, List<String> classes, List<VNode> children}) => new VNode.component($createFnName, flags: $flags, key: key, data: data, type: type, attrs: attrs, style: style, classes: classes, children: children);');

    return buffer.toString();
  }

  @override
  String toString() => 'UixGenerator';
}
