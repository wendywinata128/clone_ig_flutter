import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoveWidget extends StatelessWidget {
  const LoveWidget({super.key, this.isLoved = false, required this.onTap});

  final bool isLoved;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: isLoved
            ? FaIcon(
                FontAwesomeIcons.solidHeart,
                key: ValueKey(isLoved),
                color: Colors.red.shade800,
              )
            : FaIcon(
                FontAwesomeIcons.heart,
                key: ValueKey(isLoved),
              ),
      ),
    );
  }
}
