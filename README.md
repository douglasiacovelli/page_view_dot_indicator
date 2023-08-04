# Page view dot indicator

[![pub package](https://img.shields.io/pub/v/page_view_dot_indicator?style=plastic&logo=flutter)](https://pub.dev/packages/flutter_formx)

This lib draws a simple dot indicator for page views with a simple API. Right now it is able to draw
dots with custom size, colors, spacing and duration. Besides that it also handles overflow by fading
the edges if there are more dots than the width of the page allows.

<img src="https://user-images.githubusercontent.com/1608564/111876654-7f539200-897e-11eb-9d1e-7a9ceb820ec7.gif" width="50%"/>

## Usage

Simply use this Widget in your page and make sure to use any form of state management to update the currentItem, such as setState.

#### These are the mandatory parameters:

```dart
PageViewDotIndicator(
  currentItem: selectedPage,
  count: pageCount,
  unselectedColor: Colors.black26,
  selectedColor: Colors.blue,
)
```

#### But you can also customize it using other parameters, such as:

```dart
PageViewDotIndicator(
  currentItem: selectedPage,
  count: pageCount,
  unselectedColor: Colors.black26,
  selectedColor: Colors.blue,
  size: const Size(12, 12),
  unselectedSize: const Size(8, 8),
  duration: const Duration(milliseconds: 200),
  margin: const EdgeInsets.symmetric(horizontal: 8),
  padding: EdgeInsets.zero,
  alignment: Alignment.centerLeft,
  fadeEdges: false,
  boxShape: BoxShape.square, //defaults to circle
  borderRadius: BorderRadius.circular(5), //only for rectangle shape
  onItemClicked: (index) { ... }
)
```
