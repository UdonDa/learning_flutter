import 'package:flutter/material.dart';
import 'package:platformdesign/tabs/widgets.dart';


class PreferenceCard extends StatelessWidget {
  const PreferenceCard({this.header, this.content, this.preferenceChoices});

  final String header;
  final String content;
  final List<String> preferenceChoices;

  @override
  Widget build(BuildContext context) {
    return PressableCard(
      color: Colors.green,
      flattenAnimation: AlwaysStoppedAnimation(0),
      child: Stack(
        children: [
          Container(
            height: 120,
            width: 250,
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Center(
                child: Text(
                  content,
                  style: TextStyle(fontSize: 48),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black12,
              height: 40,
              padding: const EdgeInsets.only(left: 12),
              alignment: Alignment.centerLeft,
              child: Text(
                header,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
          )
        ],
      ),
      onPressed: () => showChoices(context, preferenceChoices),
    );
  }
}