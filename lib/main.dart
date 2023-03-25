import 'package:bloc_vandad/state/fetch_results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/persons_bloc.dart';
import 'events/load_person.dart';
import 'model/person_url.dart';

import 'dart:developer' as devtools show log;
extension Log on Object{
  void log() => devtools.log(toString());
}

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      debugShowMaterialGrid: false,
      home: BlocProvider(
        create: (_) => PersonsBloc(),
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BloC Demo'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<PersonsBloc>().add(const LoadPersonAction(url: PersonUrl.person1));
                },
                child: const Text('Fetch #person1'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<PersonsBloc>().add(const LoadPersonAction(url: PersonUrl.person2));
                },
                child: const Text('Fetch #person2'),
              ),
            ],
          ),
          BlocBuilder<PersonsBloc, FetchResults?>(
            buildWhen: (previousResult, currentResult) => previousResult?.persons != currentResult?.persons,
            builder: (context, fetchResults) {
              fetchResults?.log();
              if (fetchResults != null) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: fetchResults.persons.length,
                    itemBuilder: (context, index) {
                      final person = fetchResults.persons.elementAt(index);
                      return ListTile(
                        title: Text(person.name),
                        subtitle: Text(person.age.toString()),
                      );
                    },
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}
