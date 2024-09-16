import 'package:flutter/material.dart';

class BaseLayout extends StatelessWidget {
  const BaseLayout({
    super.key,
    required this.child,
    this.appBar,
    this.bottomNavigationBar,
    this.padding = const EdgeInsets.all(16),
  });
  final Widget child;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: Container(
        decoration: BoxDecoration(
          gradient: bottomNavigationBar != null
              ? null
              : const LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Color.fromARGB(237, 246, 254, 255),
                    Color.fromARGB(255, 255, 255, 255)
                  ],
                ),
          color: Colors.white,
        ),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
