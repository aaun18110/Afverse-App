// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final Color color;
  final bool loading;
  const RoundedButton(
      {Key? key,
      required this.title,
      required this.onPress,
      required this.color,
      this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: loading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white))
            : Center(
                child: Text(
                  title,
                  style: GoogleFonts.roboto(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
      ),
    );
  }
}
