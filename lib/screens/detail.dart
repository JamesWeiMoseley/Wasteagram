import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final quantity;
  final date;
  final latitude;
  final longitude;
  final imageURL;

  const DetailsScreen(
      {Key? key,
      this.quantity,
      this.date,
      this.latitude,
      this.longitude,
      this.imageURL})
      : super(key: key);

  //details screen simply displays all the parameters
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(date),
            //uses image network to get picture
            Image.network(imageURL, fit: BoxFit.cover),
            Text('$quantity items'),
            Text(
              'Location: ($latitude, $longitude)',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
