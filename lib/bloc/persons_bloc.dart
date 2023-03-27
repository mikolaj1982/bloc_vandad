import 'package:bloc/bloc.dart';
import 'package:bloc_vandad/events/load_person_action.dart';
import 'package:bloc_vandad/state/fetch_results_state.dart';
import 'package:bloc_vandad/model/person_model.dart';

extension IsEqualIgnoringOrder<T> on Iterable<T> {
  bool isEqualIgnoringOrder(Iterable<T> other) =>
      length == other.length && {...this}.intersection({...other}).length == length;
}

class PersonsBloc extends Bloc<LoadAction, FetchResults?> {
  final Map<String, Iterable<Person>> _cache = {};

  PersonsBloc() : super(null) {
    on<LoadPersonAction>((event, emit) async {
      print('on<LoadPersonAction>');
      final url = event.url;
      if (_cache.containsKey(url)) {
        /// we have the value in the cache
        print('from cache');
        emit(FetchResults(
          persons: _cache[url]!,
          isRetrievedFromCache: true,
        ));
      } else {
        /// we don't have the value in the cache so we need to fetch it
        final loader = event.loader;
        final persons = await loader(url);
        _cache[url] = persons;
        print('from API');
        emit(FetchResults(
          persons: persons,
          isRetrievedFromCache: false,
        ));
      }
    });
  }
}
