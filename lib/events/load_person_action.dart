import 'package:bloc_vandad/model/person_model.dart';
import 'package:flutter/foundation.dart' show immutable;

typedef PersonsLoader = Future<Iterable<Person>> Function(String url);

@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class LoadPersonAction implements LoadAction {
  final String url;
  final PersonsLoader loader;

  const LoadPersonAction({
    required this.loader,
    required this.url,
  });
}
