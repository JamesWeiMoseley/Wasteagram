//model class for each 'post' to the database

class Post {
  late String imageURL;
  late int quantity;
  late double latitude;
  late double longitude;
  late DateTime date;

  Post();

  Post.fromMap(Map<String, dynamic> post) {
    imageURL = post['imageURL'];
    quantity = post['quantity'];
    latitude = post['latitude'];
    longitude = post['longitude'];
    date = post['date'];
  }

  Map<String, dynamic> toMap() {
    return {
      'imageURL': imageURL,
      'quantity': quantity,
      'latitude': latitude,
      'longitude': longitude,
      'date': date
    };
  }
}
