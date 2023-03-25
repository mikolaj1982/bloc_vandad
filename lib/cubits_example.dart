import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

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
      home: const HomePage(),
    );
  }
}

const names = [
  'John',
  'Paul',
  'George',
  'Ringo',
];

class NamesCubit extends Cubit<String?> {
  NamesCubit() : super(null); // -> initial state is null

  void pickRandomName() {
    emit(names.getRandomElement());
  }
}

/// creates generic random iterable out of anything
extension RandomElement<T> on Iterable<T> {
  T getRandomElement() {
    return elementAt(Random().nextInt(length));
  }
}

/// we use stateful widget to be able to initialize our cubit and dispose it
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late final NamesCubit namesCubit; // -> variable's value is computed only when it's needed

  @override
  void initState() {
    /*
    By calling super.initState(); first, you make sure that the parent class's initialization logic is executed before your custom initialization code, which helps avoid potential issues related to the widget's lifecycle.
     */
    super.initState(); // -> Always call this first.
    namesCubit = NamesCubit();
  }

  @override
  dispose() {
    namesCubit.close();
    super.dispose(); // -> Always call this after your custom disposal code.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cubits'),
      ),
      body: StreamBuilder<String?>(
        stream: namesCubit.stream, // -> we can use cubit as a stream
        builder: (context, snapshot) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  snapshot.data ?? 'No name selected',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => namesCubit.pickRandomName(),
                  child: const Text('Pick random name'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
