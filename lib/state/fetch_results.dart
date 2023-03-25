import 'package:bloc_vandad/model/person_model.dart';
import 'package:flutter/material.dart';

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
}