import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

void main() {
  Widget buildBoilerPlate(Widget indicator) {
    return MaterialApp(
      home: Scaffold(
        body: indicator,
      ),
    );
  }

  testWidgets('indicator creates a listview with count of elements', (tester) async {
    await tester.pumpWidget(buildBoilerPlate(
      PageViewDotIndicator(
        count: 5,
        currentItem: 0,
        selectedColor: Colors.black26,
        unselectedColor: Colors.blue,
      ),
    ));

    final listViewFinder = find.byType(ListView);
    expect(listViewFinder, findsOneWidget);

    final dotsFinder =
        find.descendant(of: listViewFinder, matching: find.byType(AnimatedContainer));
    expect(dotsFinder, findsNWidgets(5));
  });

  testWidgets('indicator asserts current item is within valid range', (tester) async {
    expect(
      () => buildBoilerPlate(
        PageViewDotIndicator(
          count: 5,
          currentItem: -1,
          selectedColor: Colors.black26,
          unselectedColor: Colors.blue,
        ),
      ),
      throwsAssertionError,
    );

    expect(
      () => buildBoilerPlate(
        PageViewDotIndicator(
          count: 5,
          currentItem: 5,
          selectedColor: Colors.black26,
          unselectedColor: Colors.blue,
        ),
      ),
      throwsAssertionError,
    );
  });

  testWidgets('indicator uses correct box shape', (tester) async {
    await tester.pumpWidget(buildBoilerPlate(
      PageViewDotIndicator(
        count: 3,
        currentItem: 1,
        selectedColor: const Color(0xFFFF00FF),
        unselectedColor: const Color(0xFF00FFFF),
        boxShape: BoxShape.rectangle,
      ),
    ));

    final listViewFinder = find.byType(ListView);
    expect(listViewFinder, findsOneWidget);

    final dotsFinder =
        find.descendant(of: listViewFinder, matching: find.byType(AnimatedContainer));

    final selectedDot = dotsFinder.evaluate().elementAt(1).widget as AnimatedContainer;
    expect((selectedDot.decoration as BoxDecoration).shape, BoxShape.rectangle);
  });

  testWidgets('indicator sets color of selected element different from unselected', (tester) async {
    const unselectedColor = Color(0xFF00FFFF);
    const selectedColor = Color(0xFFFF00FF);

    await tester.pumpWidget(buildBoilerPlate(
      PageViewDotIndicator(
        count: 3,
        currentItem: 2,
        selectedColor: selectedColor,
        unselectedColor: unselectedColor,
      ),
    ));

    final listViewFinder = find.byType(ListView);
    expect(listViewFinder, findsOneWidget);

    final dotsFinder =
        find.descendant(of: listViewFinder, matching: find.byType(AnimatedContainer));

    final selectedDot = dotsFinder.evaluate().elementAt(2).widget as AnimatedContainer;
    expect((selectedDot.decoration as BoxDecoration).color, selectedColor);

    final unselectedDot0 = dotsFinder.evaluate().elementAt(0).widget as AnimatedContainer;
    expect((unselectedDot0.decoration as BoxDecoration).color, unselectedColor);

    final unselectedDot1 = dotsFinder.evaluate().elementAt(1).widget as AnimatedContainer;
    expect((unselectedDot1.decoration as BoxDecoration).color, unselectedColor);
  });

  testWidgets('indicator sets size correctly', (tester) async {
    const selectedSize = Size(20, 20);
    const unselectedSize = Size(16, 16);

    await tester.pumpWidget(buildBoilerPlate(
      PageViewDotIndicator(
        count: 3,
        currentItem: 1,
        selectedColor: const Color(0xFFFF00FF),
        unselectedColor: const Color(0xFF00FFFF),
        size: selectedSize,
        unselectedSize: unselectedSize,
      ),
    ));

    final listViewFinder = find.byType(ListView);
    expect(listViewFinder, findsOneWidget);

    final dotsFinder =
        find.descendant(of: listViewFinder, matching: find.byType(AnimatedContainer));

    final selectedDot = dotsFinder.evaluate().elementAt(1).widget as AnimatedContainer;
    expect((selectedDot.constraints), BoxConstraints.tight(selectedSize));

    final unselectedDot0 = dotsFinder.evaluate().elementAt(0).widget as AnimatedContainer;
    expect((unselectedDot0.constraints), BoxConstraints.tight(unselectedSize));

    final unselectedDot2 = dotsFinder.evaluate().elementAt(2).widget as AnimatedContainer;
    expect((unselectedDot2.constraints), BoxConstraints.tight(unselectedSize));
  });

  testWidgets('indicator uses animated containers', (tester) async {
    const unselectedColor = Color(0xFF00FFFF);
    const selectedColor = Color(0xFFFF00FF);

    await tester.pumpWidget(buildBoilerPlate(
      PageViewDotIndicator(
        count: 5,
        currentItem: 2,
        selectedColor: selectedColor,
        unselectedColor: unselectedColor,
      ),
    ));

    final listViewFinder = find.byType(ListView);
    expect(listViewFinder, findsOneWidget);

    final dotsFinder =
        find.descendant(of: listViewFinder, matching: find.byType(AnimatedContainer));

    expect(dotsFinder, findsWidgets);
  });

  testWidgets('indicator uses margin provided', (tester) async {
    const margin = EdgeInsets.symmetric(horizontal: 12);
    await tester.pumpWidget(buildBoilerPlate(
      PageViewDotIndicator(
        count: 5,
        currentItem: 2,
        selectedColor: const Color(0xFFFF00FF),
        unselectedColor: const Color(0xFF00FFFF),
        margin: margin,
      ),
    ));

    final listViewFinder = find.byType(ListView);

    final dotsFinder =
        find.descendant(of: listViewFinder, matching: find.byType(AnimatedContainer));

    expect(
      (dotsFinder.evaluate().elementAt(0).widget as AnimatedContainer).margin,
      margin,
    );
  });

  testWidgets('indicator uses duration provided', (tester) async {
    const duration = Duration(milliseconds: 1000);
    await tester.pumpWidget(buildBoilerPlate(
      PageViewDotIndicator(
        count: 5,
        currentItem: 2,
        selectedColor: const Color(0xFFFF00FF),
        unselectedColor: const Color(0xFF00FFFF),
        duration: duration,
      ),
    ));

    final listViewFinder = find.byType(ListView);

    final dotsFinder =
        find.descendant(of: listViewFinder, matching: find.byType(AnimatedContainer));

    expect(
      (dotsFinder.evaluate().elementAt(0).widget as AnimatedContainer).duration,
      duration,
    );
  });

  testWidgets('indicators list should not scroll', (tester) async {
    const margin = EdgeInsets.symmetric(horizontal: 12);
    await tester.pumpWidget(buildBoilerPlate(
      PageViewDotIndicator(
        count: 5,
        currentItem: 2,
        selectedColor: const Color(0xFFFF00FF),
        unselectedColor: const Color(0xFF00FFFF),
        margin: margin,
      ),
    ));

    final listViewFinder = find.byType(ListView);

    expect(
      (listViewFinder.evaluate().first.widget as ListView).physics is NeverScrollableScrollPhysics,
      true,
    );
  });

  testWidgets('indicator should use shadermask', (tester) async {
    const margin = EdgeInsets.symmetric(horizontal: 12);
    await tester.pumpWidget(buildBoilerPlate(
      PageViewDotIndicator(
        count: 5,
        currentItem: 2,
        selectedColor: const Color(0xFFFF00FF),
        unselectedColor: const Color(0xFF00FFFF),
        margin: margin,
      ),
    ));

    final shaderMask = find.byType(ShaderMask);

    expect(shaderMask, findsOneWidget);
  });

  testWidgets('indicator should scroll list to selected position when it starts', (tester) async {
    const selectedWidgetColor = Color(0xFFFF00FF);
    await tester.pumpWidget(buildBoilerPlate(
      SizedBox(
        width: 100,
        child: PageViewDotIndicator(
          count: 20,
          currentItem: 19,
          selectedColor: selectedWidgetColor,
          unselectedColor: const Color(0xFF00FFFF),
          margin: const EdgeInsets.symmetric(horizontal: 12),
        ),
      ),
    ));

    final listViewFinder = find.byType(ListView);

    await tester.pumpAndSettle();

    final dotsFinder =
        find.descendant(of: listViewFinder, matching: find.byType(AnimatedContainer));
    final selectedDot = dotsFinder.evaluate().last.widget as AnimatedContainer;
    expect((selectedDot.decoration as BoxDecoration).color, selectedWidgetColor);
  });

  testWidgets('indicator should scroll list to selected position when it is updated',
      (tester) async {
    const selectedWidgetColor = Color(0xFFFF00FF);
    await tester.pumpWidget(buildBoilerPlate(
      SizedBox(
        width: 100,
        child: PageViewDotIndicator(
          count: 20,
          currentItem: 0,
          selectedColor: selectedWidgetColor,
          unselectedColor: const Color(0xFF00FFFF),
          margin: const EdgeInsets.symmetric(horizontal: 12),
        ),
      ),
    ));

    await tester.pumpAndSettle();

    final listViewFinder = find.byType(ListView);
    var dotsFinder = find.descendant(of: listViewFinder, matching: find.byType(AnimatedContainer));
    var selectedDot = dotsFinder.evaluate().first.widget as AnimatedContainer;
    expect((selectedDot.decoration as BoxDecoration).color, selectedWidgetColor);

    await tester.pumpWidget(buildBoilerPlate(
      SizedBox(
        width: 100,
        child: PageViewDotIndicator(
          count: 20,
          currentItem: 19,
          selectedColor: selectedWidgetColor,
          unselectedColor: const Color(0xFF00FFFF),
          margin: const EdgeInsets.symmetric(horizontal: 12),
        ),
      ),
    ));

    await tester.pumpAndSettle();

    dotsFinder = find.descendant(of: listViewFinder, matching: find.byType(AnimatedContainer));
    selectedDot = dotsFinder.evaluate().last.widget as AnimatedContainer;
    expect((selectedDot.decoration as BoxDecoration).color, selectedWidgetColor);
  });

  testWidgets('indicator should assign click listener', (tester) async {
    const selectedWidgetColor = Color(0xFFFF00FF);
    final clicks = <int>[];
    await tester.pumpWidget(buildBoilerPlate(
      SizedBox(
        width: 100,
        child: PageViewDotIndicator(
          count: 20,
          currentItem: 0,
          selectedColor: selectedWidgetColor,
          unselectedColor: const Color(0xFF00FFFF),
          onItemClicked: (index) => clicks.add(index),
        ),
      ),
    ));

    await tester.pumpAndSettle();

    final listViewFinder = find.byType(ListView);
    final dotGestureDetector =
        find.descendant(of: listViewFinder, matching: find.byType(GestureDetector));

    await tester.tap(dotGestureDetector.at(2));
    expect(clicks, [2]);
  });
}
