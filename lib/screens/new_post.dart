import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import '../models/post.dart';

class NewPosts extends StatefulWidget {
  const NewPosts({Key? key}) : super(key: key);

  @override
  _NewPostsState createState() => _NewPostsState();
}

class _NewPostsState extends State<NewPosts> {
  late LocationData locationData = Location() as LocationData;
  Post post = Post(
      imageURL: '',
      latitude: 0.0,
      longitude: 0.0,
      num: 0,
      time: DateTime.now());
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    retrieveLocation();
  }

  void retrieveLocation() async {
    var locationService = Location();
    locationData = await locationService.getLocation();
    if (mounted) setState(() {});
    print(locationData.longitude);
    print(locationData.latitude);
  }

  void sendToDatabase() {
    FirebaseFirestore.instance.collection('posts').add({
      'num': post.num,
      'time': post.time,
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
                Semantics(
                  textField: true,
                  label: 'input number of wastes',
                  child: TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    decoration:
                        InputDecoration(labelText: 'Number of Wasted Items'),
                    onSaved: (value) {
                      post.num = int.tryParse(value!)!;
                      print('the value is ${post.num}');
                      // print(int.tryParse(value) == int);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'you stpid';
                      }
                      return 'it is not empty';
                    },
                  ),
                )
              ],
            )),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Container(
        child: Semantics(
          button: true,
          onTapHint: 'upload your file',
          label: 'upload',
          // height: MediaQuery.of(context).size.height * .1,
          child: ElevatedButton(
            onPressed: () async {
              // if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              // FirebaseFirestore.instance.collection('posts').add({
              //   'imageURL': 'hello',
              //   'num': 4,
              //   'time': DateTime.now(),
              //   'longitude': locationData?.longitude,
              //   'latitude': locationData?.latitude
              // }).then((value) => print('all done'));
              // post.num = 12;
              post.time = DateTime.now();
              post.imageURL = 'hello';
              post.longitude = locationData.longitude!;
              post.latitude = locationData.latitude!;

              sendToDatabase();
              // } else
              //   print("somethingis wrong");
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
