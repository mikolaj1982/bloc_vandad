import 'dart:convert';
import 'dart:io';

import 'package:bloc_vandad/model/person_model.dart';

enum PersonUrl {
  person1,
  person2,
}

extension UrlString on PersonUrl {
  String get url {
    switch (this) {
      case PersonUrl.person1:
        return 'http://127.0.0.1:3000/api/person_1.json';
      case PersonUrl.person2:
        return 'http://127.0.0.1:3000/api/person_2.json';
    }
  }
}

Future<Iterable<Person>> getPersons(String url) => HttpClient()
    .getUrl(Uri.parse(url))
    .then((request) => request.close())
    .then((response) => response.transform(utf8.decoder).join())
    .then((str) => json.decode(str) as List<dynamic>)
    .then((list) => list.map((item) => Person.fromJson(jsonEncode(item))));
