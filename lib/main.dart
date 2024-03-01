

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main () {
  runApp(Lab());
}

class Lab extends StatelessWidget{
  const Lab ({super.key});
  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider(
      create: (context) =>LabState(),
      child: MaterialApp(
        title: 'CampusMatch',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        ),
        home: MyHomePage(),
      ),
    );
  } 
}

class LabState extends ChangeNotifier {
  var current = WordPair.random();
  
  void getNext(){  //este metodo de la una nueva palabra aleatoria a current
    current= WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
  var appState = context.watch<LabState>();
  var pair = appState.current;

  return Scaffold(
    body: Center( //; se puede centrar dandole click derecho a column, refactor y wrap with center
      child: Column( //widget que ordena en forma lista los widget hijos debajo de hijos; 
      mainAxisAlignment: MainAxisAlignment.center, //centra los elementos dentro de column pero a lo largo de el eje principal (vertical)
        children: [
          //const Text('este es tu boton de confianza:'),
          BigCard(pair: pair), //esto crea una nueva clase de la tarjeta
          //Text(appState.current.asUpperCase), // asUpperCase: metodo para que las palabals esten en mayuscula, se puede cambiar 
          SizedBox(height: 10),
    
    
          ElevatedButton(
            onPressed:(){
              appState.getNext(); //llamamos el metodo cada vez que presionamos el boton 
            print('button pressed!'); // en la consola aparece este mensaje cada vez que oprimimos el boton
          },
          child: Text('next'),
          )
        ],
      ),
    )
  );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.headlineLarge!.copyWith( //se accede a la fuente de texto
      color: theme.colorScheme.onPrimary,
    );

    
    return Card( //widget nativo que permite dejar una carta (cuadrito) para poner un widget hijo
      color: theme.colorScheme.primary, //se elige el color de card
      child: Padding( //crea un nuevo widget donde la palabra aleatora de toma current, adquiere una carta en el fondo para mejorar la presentación
        padding: const EdgeInsets.all(20), // centra el texto del cuadro carta o dependiendo del aldo que queremos centrar
       // child: Text(pair.asUpperCase), //widget hijo que ewl paddin pide para ponert algo, puede ser un botton o en ese caso, el texto que viene desde el BigCard  y es una palabra aleatoria
       child: Text(
        pair.asUpperCase,
        style: style,
        semanticsLabel: "${pair.first} ${pair.second}",
       )
      ),
    );
  }
}