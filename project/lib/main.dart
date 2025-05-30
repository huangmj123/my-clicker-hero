import 'package:flutter/material.dart';
import 'package:project/targets/normal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clicker Game',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Clicker Game'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int defeatedEnemies = 0;
  int characterHealth = 10;
  int dmg = 0;

  void _incrementCounter() {
    setState(() {
      defeatedEnemies++;
    });
  }

    void _clickDamage() {
    setState(() {
      dmg++;
      if(dmg==characterHealth){
        defeatedEnemies++;
        dmg = 0;
        characterHealth += 2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Enemies Defeated:',
            ),
            Text(
              '$defeatedEnemies',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            NormalTarget(hp: characterHealth, taken: dmg,onTouch: _clickDamage,),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
