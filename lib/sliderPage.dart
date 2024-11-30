import 'package:flutter/material.dart';

class SlidePageRoute extends MaterialPageRoute {
  final Widget page;

  SlidePageRoute({required this.page}) : super(builder: (context) => page);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return page;
  }
}
