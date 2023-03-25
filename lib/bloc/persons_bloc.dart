import 'package:bloc/bloc.dart';
import 'package:bloc_vandad/events/load_person.dart';
import 'package:bloc_vandad/state/fetch_results.dart';
import 'package:bloc_vandad/model/person_model.dart';
import 'package:bloc_vandad/model/person_url.dart';

class PersonsBloc extends Bloc<LoadPersonAction, FetchResults?> {
  final Map<PersonUrl, Iterable<Person>> _cache = {};

  PersonsBloc() : super(null) {
    on<LoadPersonAction>((event, emit) async {
      final PersonUrl url = event.url;
      if (_cache.containsKey(url)) {
        /// we have the value in the cache
        emit(FetchResults(
          persons: _cache[url]!,
          isRetrievedFromCache: true,
        ));
      } else {
        /// we don't have the value in the cache so we need to fetch it
        final persons = await getPersons(url.url);
        _cache[url] = persons;
        emit(FetchResults(
          persons: persons,
          isRetrievedFromCache: false,
        ));
      }
    });
  }
}
