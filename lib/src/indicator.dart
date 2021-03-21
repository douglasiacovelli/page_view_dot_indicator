library page_view_dot_indicator;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

class PageViewDotIndicator extends StatefulWidget {
  final int currentItem;
  final int count;
  final Color unselectedColor;
  final Color selectedColor;
  final Size size;
  final Size unselectedSize;
  final Duration duration;
  final EdgeInsets margin;

  const PageViewDotIndicator({
    Key? key,
    required this.currentItem,
    required this.count,
    required this.unselectedColor,
    required this.selectedColor,
    this.size = const Size(12, 12),
    this.unselectedSize = const Size(12, 12),
    this.duration = const Duration(milliseconds: 150),
    this.margin = const EdgeInsets.symmetric(horizontal: 4),
  }) : super(key: key);

  @override
  _PageViewDotIndicatorState createState() => _PageViewDotIndicatorState();
}

class _PageViewDotIndicatorState extends State<PageViewDotIndicator> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      scrollToCurrentPosition();
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant PageViewDotIndicator oldWidget) {
    scrollToCurrentPosition();
    super.didUpdateWidget(oldWidget);
  }

  void scrollToCurrentPosition() {
    double widgetOffset = _getOffsetForCurrentPosition();
    _scrollController
      ..animateTo(
        widgetOffset,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
  }

  double _getOffsetForCurrentPosition() {
    final offsetPerPosition =
        _scrollController.position.maxScrollExtent / widget.count;
    final widgetOffset = widget.currentItem * offsetPerPosition;
    return widgetOffset;
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            Color.fromARGB(0, 255, 255, 255),
            Colors.white,
            Colors.white,
            Color.fromARGB(0, 255, 255, 255),
          ],
          tileMode: TileMode.mirror,
          stops: [0, 0.05, 0.95, 1],
        ).createShader(bounds);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        height: widget.size.height,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.count,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.antiAlias,
          controller: _scrollController,
          itemBuilder: (context, index) {
            return AnimatedContainer(
              margin: widget.margin,
              duration: widget.duration,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index == widget.currentItem
                    ? widget.selectedColor
                    : widget.unselectedColor,
              ),
              width: index == widget.currentItem
                  ? widget.size.width
                  : widget.unselectedSize.width,
              height: index == widget.currentItem
                  ? widget.size.height
                  : widget.unselectedSize.height,
            );
          },
        ),
      ),
    );
  }
}
