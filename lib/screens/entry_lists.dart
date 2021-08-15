import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasteagram/screens/new_post.dart';
import 'package:intl/intl.dart';
import 'detail.dart';

class EntryLists extends StatefulWidget {
  final String title;
  const EntryLists({Key? key, required this.title}) : super(key: key);
  @override
  _EntryListsState createState() => _EntryListsState();
}

class _EntryListsState extends State<EntryLists> {
  num total = 0;
  File? image;
  final picker = ImagePicker();

  //get image function to get url for image
  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);

    var fileName = DateTime.now().toString() + '.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageReference.putFile(image!);
    await uploadTask;
    final url = await storageReference.getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${this.widget.title}'),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .orderBy('date', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData && snapshot.data!.docs.length > 0) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var post = snapshot.data!.docs[index];

                    //Semantics wrapped list tile
                    return Semantics(
                        hint: 'Click here to view details',
                        enabled: true,
                        child: ListTile(
                          trailing: Text(post['quantity'].toString()),
                          title: Text(DateFormat('EEEE MMMM d, y')
                              .format(post['date'].toDate())
                              .toString()),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                        quantity: post['quantity'].toString(),
                                        date: DateFormat('EEEE MMMM d, y')
                                            .format(post['date'].toDate())
                                            .toString(),
                                        latitude: post['latitude'].toString(),
                                        longitude: post['longitude'].toString(),
                                        imageURL:
                                            post['imageURL'].toString())));
                          },
                        ));
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: newEntryButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  //semantics wrapped floating action button at the bottom of the page
  Widget newEntryButton() {
    return Semantics(
        button: true,
        enabled: true,
        onTapHint: 'Click to post',
        child: FloatingActionButton(
            child: Icon(Icons.camera_alt),
            onPressed: () async {
              String url = await getImage();
              print('the urls is $url');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewPosts(url: url)));
            }));
  }
}
