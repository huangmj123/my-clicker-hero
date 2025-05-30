import 'dart:async';

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
  double currency = 0;
  double multiplier = 1;
  int squaresFilled = 0;
  int characterHealth = 10;
  double dmg = 0;
  double clickdmg = 1;
  double fivesecondstimerdmg = 0;
  Timer? fivesecondstimer;

  double resetmultiplier = 1;

  @override
  void initState() {
    super.initState();
    fivesecondstimer = Timer.periodic(const Duration(seconds: 5), (Timer t) => fivesecondstimerdmgfunc());
  }
  void fivesecondstimerdmgfunc(){
    setState(() {
      dmg+=fivesecondstimerdmg*resetmultiplier;
      checkResetBox();
    });
  }
    void _clickDamage() {
    setState(() {
      dmg+=clickdmg*resetmultiplier;
      checkResetBox();
    });
  }

  void checkResetBox(){
    if(dmg>=characterHealth){
        squaresFilled++;
        currency+= (characterHealth/10)*multiplier*resetmultiplier;
        dmg = 0;
        characterHealth += 1;
      }
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
          children: <Widget>[
            Text('Spendable Boxes: ${currency.toStringAsFixed(2)}'),
            Text('Clicks do: ${clickdmg.toStringAsFixed(2)}'),
            Text('Every five seconds, ${fivesecondstimerdmg.toStringAsFixed(2)} clicks'),
            const SizedBox(height: 200,),

            const Text(
              'Boxes filled:',
            ),
            Text(
              '$squaresFilled',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            NormalTarget(hp: characterHealth, taken: dmg,onTouch: _clickDamage,),

            const SizedBox(height: 150,),
            ListTile(
              title: const Text('decrease clicks required'),
              subtitle: const Text('add +0.1 to each click (-10 Boxes)'),
              onTap: () {
                if(currency>=10){
                setState(() {
                  clickdmg+=0.1;
                  currency-=10;
                });
                }
            },),
            ListTile(
              title: const Text('Does a couple clicks every 5 seconds'),
              subtitle: const Text('10 clicks / 5 seconds (-25 Boxes)'),
              onTap: () {
                if(currency>=25){
                setState(() {
                  fivesecondstimerdmg+=10;
                  currency-=25;
                });
                }
            },),
            ListTile(
              title: const Text('bonus spendable boxes!!'),
              subtitle: const Text('box duplicator! it only kind of works (*1.1 boxes per box) (-50 Boxes)'),
              onTap: () {
                if(currency>=50){
                setState(() {
                  multiplier+=0.1;
                  currency-=50;
                });
                }
            },),
            ListTile(
              title: Text('Youve filled $squaresFilled boxes...'),
              subtitle: Text('reset to 0 for a x${squaresFilled/10000.0} multiplier on everything (cannot reset with <1000 boxes)'),
              onTap: () {
                if(squaresFilled>=1000){
                setState(() {
                  multiplier = 1;
                  currency = 0;
                  squaresFilled = 0;
                  clickdmg = 1;
                  fivesecondstimerdmg = 0;
                  characterHealth = 10;
                });
                }
            },),
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
