import 'package:flutter/cupertino.dart';

class FilterTextShape extends StatelessWidget {
  String text = '';

  FilterTextShape({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 10,
        fontWeight: FontWeight.bold),
      ),
    );
  }
}
