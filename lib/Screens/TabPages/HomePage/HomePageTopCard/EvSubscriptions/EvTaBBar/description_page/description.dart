
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class Description extends StatefulWidget {
  final String? carDescription;
  Description({super.key, this.carDescription});

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            // Text("${widget.carDescription}", textAlign: TextAlign.left,
            //   style: TextStyle(fontSize: 12, fontFamily: poppinRegular, color: Colors.black)),
            HtmlWidget('${widget.carDescription}'),

          ],
        ),
      ),
    );
  }
}
