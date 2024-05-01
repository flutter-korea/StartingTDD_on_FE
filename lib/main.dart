import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stdd_ex/screen/product_page/view_product_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Bloc.observer = SimpleBlocObserver();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ProductPage(),
    );
  }
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(final Bloc bloc, final Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      print('--- Event ---');
      print(bloc);
      print(event);
    }
  }

  @override
  void onTransition(final Bloc bloc, final Transition transition) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      print('--- Transition ---');
      print(bloc);
      print(transition.event);
      print("current: ${transition.currentState}");
      print("next: ${transition.nextState}");
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    if (kDebugMode) {
      print('--- Error ---');
      print(bloc);
      print(error);
    }
  }
}
