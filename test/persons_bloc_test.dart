import 'package:bloc_vandad/bloc/persons_bloc.dart';
import 'package:bloc_vandad/events/load_person_action.dart';
import 'package:bloc_vandad/model/person_model.dart';
import 'package:bloc_vandad/state/fetch_results_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

const mockedPerson1 = [
  Person(
    name: 'Foo',
    age: 20,
  ),
  Person(
    name: 'Bar',
    age: 30,
  ),
  Person(
    name: 'Baz',
    age: 40,
  ),
];
const mockedPerson2 = [
  Person(
    name: 'Foo',
    age: 20,
  ),
  Person(
    name: 'Bar',
    age: 30,
  ),
  Person(
    name: 'Baz',
    age: 40,
  ),
];

Future<Iterable<Person>> mockGetPerson1(String _) async {
  return Future.value(mockedPerson1);
}

Future<Iterable<Person>> mockGetPerson2(String _) async {
  return Future.value(mockedPerson2);
}

main() {
  late PersonsBloc bloc;

  setUp(() {
    bloc = PersonsBloc();
  });

  tearDown(() {
    bloc.close();
  });

  group('testing bloc', () {
    blocTest<PersonsBloc, FetchResults?>(
      'test initial state',
      build: () => bloc,
      verify: (bloc) {
        expect(bloc.state, null);
      },
    );

    blocTest<PersonsBloc, FetchResults?>(
      'fetch the mock data (mockedPerson1) and compare it with FetchResult',
      build: () => bloc,
      act: (bloc) {
        bloc.add(const LoadPersonAction(
          loader: mockGetPerson1,
          url: 'dummy_url_1',
        ));
        bloc.add(const LoadPersonAction(
          loader: mockGetPerson1,
          url: 'dummy_url_1',
        ));
      },
      wait: const Duration(seconds: 2),
      expect: () => [
        const FetchResults(
          persons: mockedPerson1,
          isRetrievedFromCache: false,
        ),
        const FetchResults(
          persons: mockedPerson1,
          isRetrievedFromCache: true,
        ),
      ],
    );


    blocTest<PersonsBloc, FetchResults?>(
      'fetch the mock data (mockedPerson2) and compare it with FetchResult',
      build: () => bloc,
      act: (bloc) {
        bloc.add(const LoadPersonAction(
          loader: mockGetPerson2,
          url: 'dummy_url_2',
        ));
        bloc.add(const LoadPersonAction(
          loader: mockGetPerson2,
          url: 'dummy_url_2',
        ));
      },
      wait: const Duration(seconds: 2),
      expect: () => [
        const FetchResults(
          persons: mockedPerson2,
          isRetrievedFromCache: false,
        ),
        const FetchResults(
          persons: mockedPerson2,
          isRetrievedFromCache: true,
        ),
      ],
    );
  });
}
