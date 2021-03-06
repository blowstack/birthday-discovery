import 'package:uuid/uuid.dart';

var uuid = Uuid();
const unavailable_url = 'https://firebasestorage.googleapis.com/v0/b/birthdaydiscovery-c1d4c.appspot.com/o/images%2Fno-img.jpg?alt=media&token=6e1e4dd5-2026-4f4d-b6d2-2aab4ee8c737';

class FamousPerson {
  final String id;
  final String name;
  final String title;
  final String thumbnail;
  final String extract;
  final int year;

  FamousPerson({this.id, this.name, this.title,this.thumbnail,this.extract, this.year});

  List<String> splitNames(text) {
    var names = text.contains(',') ? text.split(',') : [text, ''];
    return names;
  }

  factory FamousPerson.fromJson(Map<String, dynamic> json) {

    return FamousPerson(
        id: uuid.v1(),
        name: json['text'].contains(',') ? json['text'].split(',')[0] : json['text'],
        title: json['text'].contains(',') ? json['text'].split(',')[1] : '',
        thumbnail: json['pages'] != null && json['pages'].asMap().containsKey(0) && json['pages'][0]['thumbnail'] != null  ? json['pages'][0]['thumbnail']['source'] : unavailable_url,
        extract: json['pages'] != null && json['pages'].asMap().containsKey(0) && json['pages'][0]['extract'] != null  ? json['pages'][0]['extract'] : 'Sorry. No content available at the moment',
        year: json['year']
    );
  }
}