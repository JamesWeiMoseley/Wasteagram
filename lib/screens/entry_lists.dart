import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wasteagram/screens/new_post.dart';
import 'package:intl/intl.dart';
import 'detail.dart';

class EntryLists extends StatefulWidget {
  @override
  _EntryListsState createState() => _EntryListsState();
}

class _EntryListsState extends State<EntryLists> {
  int? total;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wastegram'),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .orderBy('time', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData && snapshot.data!.docs.length > 0) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var post = snapshot.data!.docs[index];
                    var size;
                    size = FirebaseFirestore.instance
                        .collection('posts')
                        .get()
                        .then((value) => size = value.size)
                        .then((value) => print(size));
                    return ListTile(
                      // subtitle: Text(post['name']),

                      trailing: Text(post['num'].toString()),
                      title: Text(DateFormat('EEEE MMMM d, y')
                          .format(post['time'].toDate())
                          .toString()),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                    num: post['num'].toString(),
                                    time: DateFormat('EEEE MMMM d, y')
                                        .format(post['time'].toDate())
                                        .toString(),
                                    latitude: post['latitude'].toString(),
                                    longitude: post['longitude'].toString(),
                                    imageURL: post['imageURL'].toString())));
                      },
                    );
                    // trailing: Text(snapshot.data!.docs.length.toString()));
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: NewEntryButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

/*
 * As an example I have added functionality to add an entry to the collection
 * if the button is pressed
 */
class NewEntryButton extends StatelessWidget {
  @override
  // DateTime now = DateTime.now();
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () {
          // FirebaseFirestore.instance.collection('bandnames').add({
          //   'name': 'hello',
          //   'votes': 99,
          //   'time': DateFormat('EEEE MMMM d, y').format(now)
          // }).then((value) => print('hello'));
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewPosts()));
        });
  }
}


// class DeleteButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () {
//           FirebaseFirestore.instance
//               .collection('bandnames')
//               .getDocuments()
//               .then((snapshot) {
//             for (DocumentSnapshot ds in snapshot.documents) {
//               ds.reference.delete();
//             }
//           });
//         });
//   }
// }
