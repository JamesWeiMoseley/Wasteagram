import 'package:test/test.dart';
import 'package:wasteagram/models/food_waste_post.dart';

void main() {
  test('Post created from Map should have appropriate property values', () {
    final date = DateTime.parse('2020-01-01');
    const url = 'FAKE';
    const quantity = 1;
    const latitude = 1.0;
    const longitude = 2.0;

    Post foodWastePost = Post.fromMap({
      'date': date,
      'imageURL': url,
      'quantity': quantity,
      'latitude': latitude,
      'longitude': longitude
    });

    expect(foodWastePost.imageURL, url);
    expect(foodWastePost.quantity, quantity);
    expect(foodWastePost.latitude, latitude);
    expect(foodWastePost.longitude, longitude);
    expect(foodWastePost.date, date);
  });
}
