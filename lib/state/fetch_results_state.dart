import 'package:bloc_vandad/bloc/persons_bloc.dart';
import 'package:bloc_vandad/model/person_model.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class FetchResults {
  final Iterable<Person> persons;
  final bool isRetrievedFromCache;

  const FetchResults({
    required this.persons,
    required this.isRetrievedFromCache,
  });

  @override
  String toString() {
    return 'FetchResults(persons: $persons, isRetrievedFromCache: $isRetrievedFromCache)';
  }

  @override
  bool operator ==(covariant FetchResults other) {
    if (identical(this, other)) return true;

    return other.persons.isEqualIgnoringOrder(persons)
        && other.isRetrievedFromCache == isRetrievedFromCache;
  }

  @override
  int get hashCode => persons.hashCode ^ isRetrievedFromCache.hashCode;
}
