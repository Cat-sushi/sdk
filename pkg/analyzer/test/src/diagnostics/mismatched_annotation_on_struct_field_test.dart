// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/src/dart/error/hint_codes.dart';
import 'package:analyzer/src/error/codes.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../dart/resolution/driver_resolution.dart';

main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(MismatchedAnnotationOnStructFieldTest);
  });
}

@reflectiveTest
class MismatchedAnnotationOnStructFieldTest extends DriverResolutionTest {
  test_double_on_int() async {
    await assertErrorsInCode(r'''
import 'dart:ffi';
class C extends Struct<C> {
  @Double() int x;
}
''', [
      error(HintCode.MISMATCHED_ANNOTATION_ON_STRUCT_FIELD, 49, 9),
    ]);
  }

  test_int32_on_double() async {
    await assertErrorsInCode(r'''
import 'dart:ffi';
class C extends Struct<C> {
  @Int32() double x;
}
''', [
      error(HintCode.MISMATCHED_ANNOTATION_ON_STRUCT_FIELD, 49, 8),
    ]);
  }
}
