import 'package:clone_ig_flutter/core/constants/url.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void navigateToWidget(BuildContext context, Widget screen) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (ctx) => screen),
  );
}

void navigateReplacementToWidget(BuildContext context, Widget screen) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (ctx) => screen),
  );
}

void navigateReplacementAllToWidget(BuildContext context, Widget screen) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (ctx) => screen), ModalRoute.withName("/"));
}

T getProvider<T>(BuildContext context, [bool? listen]) {
  return Provider.of<T>(context, listen: listen ?? true);
}

String formatDateFromString(String stringDate) {
  DateTime date = DateTime.parse(stringDate);

  return DateFormat("dd MMM yyyy").format(date);
}

String getTimeLeftConvert(String stringDate) {
  DateTime date = DateTime.parse(stringDate);

  DateTime now = DateTime.now();

  final second = now.difference(date).inSeconds;

  if (second > 60) {
    final minute = (second / 60).round();
    if (minute > 60) {
      final hours = (minute / 60).round();

      if (hours > 24) {
        final days = (hours / 24).round();
        return "${days}d";
      }

      return "${hours}h";
    } else {
      return "${minute}m";
    }
  } else {
    return "${second < 0 ? 0 : second}s";
  }
}

Widget getAvatarOfUser(String? avatar, {double? size}) {
  Widget containerDefault({Color color = Colors.black}) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: FaIcon(
        FontAwesomeIcons.user,
        color: Colors.white,
        size: size ?? 13,
      ),
    );
  }

  return avatar == null
      ? containerDefault()
      : ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: Image.network(
            ConstantURL.USER_IMAGE_URL + avatar,
            fit: BoxFit.cover,
            errorBuilder: (ctx, _, __) =>
                containerDefault(color: Colors.red.shade600),
          ),
        );
}

doSomethingAfterWidgetsReady(Function() callback) {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    callback();
  });
}
