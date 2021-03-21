import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedPage;
  PageController _pageController;

  @override
  void initState() {
    selectedPage = 5;
    _pageController = PageController(initialPage: selectedPage);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pageCount = 5;

    return MaterialApp(
      title: 'Page view dot indicator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (page) {
                    setState(() {
                      selectedPage = page;
                    });
                  },
                  children: List.generate(pageCount, (index) {
                    return Container(
                      child: Center(
                        child: Text('Page $index'),
                      ),
                    );
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: PageViewDotIndicator(
                  currentItem: selectedPage,
                  count: pageCount,
                  unselectedColor: Colors.black26,
                  selectedColor: Colors.blue,
                  duration: Duration(milliseconds: 200),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
