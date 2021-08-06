# Page view dot indicator

This lib draws a simple dot indicator for page views with a simple API. Right now it is able to draw
dots with custom size, colors, spacing and duration. Besides that it also handles overflow by fading
the edges if there are more dots than the width of the page allows.

<img src="https://user-images.githubusercontent.com/1608564/111876654-7f539200-897e-11eb-9d1e-7a9ceb820ec7.gif" width="50%"/>

## Getting Started

Add `page_view_dot_indicator` to your pubspec.yaml:

```yml
dependencies:
  page_view_dot_indicator: ^1.0.0
```

import `package:page_view_dot_indicator/page_view_dot_indicator.dart`

## Most basic dot indicator

```dart
PageViewDotIndicator(
  currentItem: selectedPage,
  count: pageCount,
  unselectedColor: Colors.black26,
  selectedColor: Colors.blue,
)
```

## But you can also customise other parameters, such as:

```dart
PageViewDotIndicator(
  currentItem: selectedPage,
  count: pageCount,
  unselectedColor: Colors.black26,
  selectedColor: Colors.blue,
  size : const Size(12, 12),
  unselectedSize : const Size(8, 8),
  duration : const Duration(milliseconds: 200),
  margin : const EdgeInsets.symmetric(horizontal: 8),
)
```
