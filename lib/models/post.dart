//model class for each 'post' to the database
class Post {
  String imageURL;
  int num;
  double latitude;
  double longitude;
  DateTime time;

  Post(
      {required this.imageURL,
      required this.num,
      required this.latitude,
      required this.longitude,
      required this.time});
}
