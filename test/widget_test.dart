// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:e_comers_app/main.dart';
import 'package:e_comers_app/pages/home_page.dart';
import 'package:e_comers_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Login page renders and validates empty form', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Welcome\nback, curator.'), findsOneWidget);
    expect(find.text('Enter the store  ->'), findsOneWidget);

    await tester.tap(find.text('Enter the store  ->'));
    await tester.pump();

    expect(find.text('Email tidak boleh kosong'), findsOneWidget);
    expect(find.text('Password tidak boleh kosong'), findsOneWidget);
  });

  testWidgets('Home layout fits a compact phone and navigation stays active', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.light, home: const HomePage()),
    );
    await tester.pumpAndSettle();

    expect(find.text('AURA'), findsOneWidget);
    expect(find.text('Shape your\neveryday.'), findsOneWidget);

    await tester.tap(find.bySemanticsLabel('Cart'));
    await tester.pumpAndSettle();

    expect(find.text('The bag'), findsOneWidget);
  });
}
