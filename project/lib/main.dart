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
  Color boxcolor = Colors.green;

  double currency = 0;
  double multiplier = 1;
  int squaresFilled = 0;
  int characterHealth = 10;
  double dmg = 0;
  double clickdmg = 1;
  double fivesecondstimerdmg = 0;
  Timer? fivesecondstimer;

  double twosecondstimerdmg = 0;
  Timer? twosecondstimer;

  double resetmultiplier = 1;

  @override
  void initState() {
    super.initState();
    fivesecondstimer = Timer.periodic(const Duration(seconds: 5), (Timer t) => fivesecondstimerdmgfunc());
    twosecondstimer = Timer.periodic(const Duration(seconds: 2), (Timer t) => twosecondstimerdmgfunc());
  }
  void fivesecondstimerdmgfunc(){
    setState(() {
      dmg+=fivesecondstimerdmg*resetmultiplier;
      checkResetBox();
    });
  }
    void twosecondstimerdmgfunc(){
    setState(() {
      dmg+=twosecondstimerdmg*resetmultiplier;
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
        characterHealth += squaresFilled~/25;
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
            Text('Automated Clicks per Second: ${fivesecondstimerdmg/5 + twosecondstimerdmg/2}'),
            const SizedBox(height: 100,),

            const Text(
              'Boxes filled:',
            ),
            Text(
              '$squaresFilled',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            NormalTarget(color: boxcolor, hp: characterHealth, taken: dmg,onTouch: _clickDamage,),

            const SizedBox(height: 150,),
            ListTile(
              title: const Text('Stronger clicking'),
              subtitle: const Text('add +0.2 to each click (-5 Boxes)'),
              onTap: () {
                if(currency>=5){
                setState(() {
                  clickdmg+=0.2;
                  currency-=5;
                });
                }
            },),
            ListTile(
              title: const Text('Does a couple clicks every 2 seconds'),
              subtitle: const Text('+1 clicks / 2 seconds (-10 Boxes)'),
              onTap: () {
                if(currency>=10){
                setState(() {
                  twosecondstimerdmg+=1;
                  currency-=10;
                });
                }
            },),
            ListTile(
              title: const Text('Does more clicks every 5 seconds'),
              subtitle: const Text('+10 clicks / 5 seconds (-25 Boxes)'),
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
              subtitle: const Text('box duplicator! ${"Don't put yourself in, it wouldn't make a new you"} (*1.1 boxes per box) (-50 Boxes)'),
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
              subtitle: Text('reset to 0 for a x${(squaresFilled/10000.0).toStringAsFixed(3)} multiplier on everything (cannot reset with <100 boxes)'),
              onTap: () {
                if(squaresFilled>=100){
                setState(() {
                  resetmultiplier += squaresFilled/10000;
                  multiplier = 1;
                  currency = 0;
                  squaresFilled = 0;
                  clickdmg = 1;
                  fivesecondstimerdmg = 0;
                  characterHealth = 10;
                });
                }
            },),
            ListTile(
              title: const Text('choose your color...'),
              subtitle: Row(
                children: [
                  ElevatedButton(onPressed: (){setState(() {
                    boxcolor = const Color.fromARGB(255, 255, 0, 0);
                  });}, child: const Text("Red",style: TextStyle(color: Colors.white),), style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 255, 0, 0)),),),
                                    ElevatedButton(onPressed: (){setState(() {
                    boxcolor = Colors.green;
                  });}, child: const Text("Green",style: TextStyle(color: Colors.white),), style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green),),),
                                    ElevatedButton(onPressed: (){setState(() {
                    boxcolor = Colors.blue;
                  });}, child: const Text("Blue",style: TextStyle(color: Colors.white),), style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue),),),
                                    ElevatedButton(onPressed: (){setState(() {
                    boxcolor = Colors.pink;
                  });}, child: const Text("Pink",style: TextStyle(color: Colors.white),), style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.pink),),),
                  OutlinedButton(onPressed: (){setState(() {
                    boxcolor = Colors.white;
                  });}, child: const Text("White",style: TextStyle(color: Colors.black),), style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white),),),
                ]
                ),),
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
