import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import '../models/food_waste_post.dart';

class NewPosts extends StatefulWidget {
  final String url;
  const NewPosts({Key? key, required this.url}) : super(key: key);

  @override
  _NewPostsState createState() => _NewPostsState();
}

class _NewPostsState extends State<NewPosts> {
  late LocationData locationData = Location() as LocationData;
  Post post = Post();
  final _formKey = GlobalKey<FormState>();
  late Image theImage;

  @override
  void initState() {
    super.initState();
    retrieveLocation();
  }

  //get the latitude and longidue using location
  void retrieveLocation() async {
    var locationService = Location();
    locationData = await locationService.getLocation();
    if (mounted) setState(() {});
  }

  //sends info to firebase
  void sendToDatabase() {
    FirebaseFirestore.instance.collection('posts').add({
      'quantity': post.quantity,
      'date': post.date,
      'latitude': post.latitude,
      'longitude': post.longitude,
      'imageURL': post.imageURL
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wasteagram'),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.network(this.widget.url, fit: BoxFit.cover),
                Semantics(
                  textField: true,
                  label: 'number of wastes',
                  child: TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    decoration:
                        InputDecoration(labelText: 'Number of Wasted Items'),
                    onSaved: (value) {
                      post.quantity = int.tryParse(value!)!;
                      print('the value is ${post.quantity}');
                    },
                    //validator for this form
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Its Empty';
                      }
                      return null;
                    },
                  ),
                )
              ],
            )),
      ),
      //Bottom app bar is the button with the cloud upload icon in it
      bottomNavigationBar: BottomAppBar(
          child: Container(
        child: Semantics(
          button: true,
          onTapHint: 'upload your file',
          label: 'upload',
          child: ElevatedButton(
            onPressed: () async {
              //validator will display snackbar is something is wrong
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                post.date = DateTime.now();
                post.imageURL = this.widget.url;
                post.longitude = locationData.longitude!;
                post.latitude = locationData.latitude!;

                sendToDatabase();
              } else
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("you messed up")));
              Navigator.of(context).pop();
            },
            child: Icon(Icons.cloud_upload,
                size: MediaQuery.of(context).size.height * .12),
          ),
        ),
      )),
    );
  }
}
