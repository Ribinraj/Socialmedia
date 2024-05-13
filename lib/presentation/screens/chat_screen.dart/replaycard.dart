import 'package:flutter/material.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:intl/intl.dart';
class ReplayMessagecard extends StatelessWidget {
  final String message;
  final DateTime time;
  const ReplayMessagecard({super.key, required this.message, required this.time});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          color: kpurplelightColor,
          child:  Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 10, right: 60, top: 10, bottom: 20),
                child: Text(
                  message,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Positioned(bottom: 4, right: 10, child: Text( DateFormat('h:mm a').format(time.toLocal()),))
            ],
          ),
        ),
      ),
    );
  }
}
