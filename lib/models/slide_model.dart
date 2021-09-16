
class Slide {
  String id;
  String title;
  String image;
  String description;

  Slide();

  Slide.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      title = jsonMap['nama'] != null ? jsonMap['nama'].toString() : '';
      image = jsonMap['img_url'] != null ? jsonMap['img_url'].toString() : '';
      description = jsonMap['deskripsi']!= null ? jsonMap['deskripsi'] : '';


    } catch (e) {
      id = '';
      title = '';
      description = '';
      image = '';
      print(e);
      print("Error Slider Model");
    }
  }
}
