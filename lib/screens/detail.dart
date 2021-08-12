import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wasteagram/models/post.dart';

class DetailsScreen extends StatelessWidget {
  final post;

  final num;
  final time;
  final latitude;
  final longitude;
  final imageURL;
  const DetailsScreen(
      {Key? key,
      this.num,
      this.time,
      this.latitude,
      this.longitude,
      this.imageURL,
      this.post})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(time),
            Text(imageURL),
            Text('$num items'),
            Text(
              'Location: ($latitude $longitude)',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
