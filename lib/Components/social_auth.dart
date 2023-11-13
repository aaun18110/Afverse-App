// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final VoidCallback? onPress;
  final String? url;
  const SocialButton({
    Key? key,
    this.onPress,
    this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Image(
          fit: BoxFit.contain,
          width: 50,
          height: 50,
          image: AssetImage("$url")),
    );
  }
}
