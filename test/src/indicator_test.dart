import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

void main() {
  Widget _instantiateWidget(Widget indicator) {
    return MaterialApp(
      home: MediaQuery(
        data: MediaQueryData(),
        child: indicator,
      ),
    );
  }

  testWidgets('indicator creates a listview with count of elements',
      (tester) async {
    await tester.pumpWidget(_instantiateWidget(
      PageViewDotIndicator(
        count: 5,
        currentItem: 0,
        selectedColor: Colors.black26,
        unselectedColor: Colors.blue,
      ),
    ));

    final listViewFinder = find.byType(ListView);
    expect(listViewFinder, findsOneWidget);

    final dotsFinder = find.descendant(
        of: listViewFinder, matching: find.byType(AnimatedContainer));
    expect(dotsFinder, findsNWidgets(5));
  });

  testWidgets(
      'indicator sets color of selected element different from unselected',
      (tester) async {
    final unselectedColor = Color(0xFF00FFFF);
    final selectedColor = Color(0xFFFF00FF);

    await tester.pumpWidget(_instantiateWidget(
      PageViewDotIndicator(
        count: 3,
        currentItem: 2,
        selectedColor: selectedColor,
        unselectedColor: unselectedColor,
      ),
    ));

    final listViewFinder = find.byType(ListView);
    expect(listViewFinder, findsOneWidget);

    final dotsFinder = find.descendant(
        of: listViewFinder, matching: find.byType(AnimatedContainer));

    final selectedDot =
        dotsFinder.evaluate().elementAt(2).widget as AnimatedContainer;
    expect((selectedDot.decoration as BoxDecoration).color, selectedColor);

    final unselectedDot0 =
        dotsFinder.evaluate().elementAt(0).widget as AnimatedContainer;
    expect((unselectedDot0.decoration as BoxDecoration).color, unselectedColor);

    final unselectedDot1 =
        dotsFinder.evaluate().elementAt(1).widget as AnimatedContainer;
    expect((unselectedDot1.decoration as BoxDecoration).color, unselectedColor);
  });

  testWidgets('indicator sets size correctly', (tester) async {
    final selectedSize = Size(20, 20);
    final unselectedSize = Size(16, 16);

    await tester.pumpWidget(_instantiateWidget(
      PageViewDotIndicator(
        count: 3,
        currentItem: 1,
        selectedColor: Color(0xFFFF00FF),
        unselectedColor: Color(0xFF00FFFF),
        size: selectedSize,
        unselectedSize: unselectedSize,
      ),
    ));

    final listViewFinder = find.byType(ListView);
    expect(listViewFinder, findsOneWidget);

    final dotsFinder = find.descendant(
        of: listViewFinder, matching: find.byType(AnimatedContainer));

    final selectedDot =
        dotsFinder.evaluate().elementAt(1).widget as AnimatedContainer;
    expect((selectedDot.constraints), BoxConstraints.tight(selectedSize));

    final unselectedDot0 =
        dotsFinder.evaluate().elementAt(0).widget as AnimatedContainer;
    expect((unselectedDot0.constraints), BoxConstraints.tight(unselectedSize));

    final unselectedDot2 =
        dotsFinder.evaluate().elementAt(2).widget as AnimatedContainer;
    expect((unselectedDot2.constraints), BoxConstraints.tight(unselectedSize));
  });

  testWidgets('indicator uses animated containers', (tester) async {
    final unselectedColor = Color(0xFF00FFFF);
    final selectedColor = Color(0xFFFF00FF);

    await tester.pumpWidget(_instantiateWidget(
      PageViewDotIndicator(
        count: 5,
        currentItem: 2,
        selectedColor: selectedColor,
        unselectedColor: unselectedColor,
      ),
    ));

    final listViewFinder = find.byType(ListView);
    expect(listViewFinder, findsOneWidget);

    final dotsFinder = find.descendant(
        of: listViewFinder, matching: find.byType(AnimatedContainer));

    expect(dotsFinder, findsWidgets);
  });

  testWidgets('indicator uses margin provided', (tester) async {
    final margin = const EdgeInsets.symmetric(horizontal: 12);
    await tester.pumpWidget(_instantiateWidget(
      PageViewDotIndicator(
        count: 5,
        currentItem: 2,
        selectedColor: Color(0xFFFF00FF),
        unselectedColor: Color(0xFF00FFFF),
        margin: margin,
      ),
    ));

    final listViewFinder = find.byType(ListView);

    final dotsFinder = find.descendant(
        of: listViewFinder, matching: find.byType(AnimatedContainer));

    expect(
      (dotsFinder.evaluate().elementAt(0).widget as AnimatedContainer).margin,
      margin,
    );
  });

  testWidgets('indicator uses duration provided', (tester) async {
    final duration = const Duration(milliseconds: 1000);
    await tester.pumpWidget(_instantiateWidget(
      PageViewDotIndicator(
        count: 5,
        currentItem: 2,
        selectedColor: Color(0xFFFF00FF),
        unselectedColor: Color(0xFF00FFFF),
        duration: duration,
      ),
    ));

    final listViewFinder = find.byType(ListView);

    final dotsFinder = find.descendant(
        of: listViewFinder, matching: find.byType(AnimatedContainer));

    expect(
      (dotsFinder.evaluate().elementAt(0).widget as AnimatedContainer).duration,
      duration,
    );
  });

  testWidgets('indicators list should not scroll', (tester) async {
    final margin = const EdgeInsets.symmetric(horizontal: 12);
    await tester.pumpWidget(_instantiateWidget(
      PageViewDotIndicator(
        count: 5,
        currentItem: 2,
        selectedColor: Color(0xFFFF00FF),
        unselectedColor: Color(0xFF00FFFF),
        margin: margin,
      ),
    ));

    final listViewFinder = find.byType(ListView);

    expect(
      (listViewFinder.evaluate().first.widget as ListView).physics
          is NeverScrollableScrollPhysics,
      true,
    );
  });
}
