import 'dart:math';
import 'package:flutter/material.dart';
import 'endgame.dart';
import 'dart:async';

class Teleop extends StatefulWidget {  
  final String output1;
  final String output2;
  
  const Teleop({super.key,
   required this.output1,
   required this.output2
   });

  @override  
  _ThirdRouteState createState() => _ThirdRouteState();  
}
  
class _ThirdRouteState extends State<Teleop> {  
  String _output3 = '';
  double _fuel = 0;
  final _shooting = Stopwatch();
  final _relay = Stopwatch();
  final _defense = Stopwatch();
  bool _trench = false;
  bool _bump = false;
  Timer? _uiTimer;
  final List<List<double>> points = [];
  double _rotation = 0;

  @override  
  Widget build(BuildContext context) {  
    setState(() {});
    return Theme (
      data: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text ('Teleop',
          style: TextStyle(
            fontSize: 20  ,
          )),
          toolbarHeight: 25,
          backgroundColor:  Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Fuel per second')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton (
                onPressed: () {
                  setState((){
                    _fuel=_fuel-0.5;
                    if(_fuel<0){_fuel=0;}
                  });
                },
                child: const Text('-0.5'),
              ),
              Container(width: 5,),
              ElevatedButton (
                onPressed: () {
                  setState((){
                    _fuel--;
                    if(_fuel<0){_fuel=0;}
                  });
                },
                child: const Text('-1'),
              ),
              Text('   $_fuel   '),
              ElevatedButton (
                onPressed: () {
                  setState((){
                    _fuel=_fuel+0.5;
                  });
                },
                child: const Text('+0.5'),
              ),
              Container(width: 5,),
              ElevatedButton (
                onPressed: () {
                  setState((){
                    _fuel++;
                  });
                },
                child: const Text('+1'),
              ),
             ]
            ),
            
            const SizedBox(height: 12),
            GestureDetector(
              onTapDown: (details){
                setState(() {
                  points.add([double.parse(details.localPosition.dx.toStringAsFixed(2)),double.parse(details.localPosition.dy.toStringAsFixed(2))]);
                });
              },
              child: Stack(
                children: [
                  Transform.rotate(
                    angle: _rotation,
                    child: Image.asset(
                      'assets/2026Field.png',
                      width: 356.5,
                      height: 174,
                      fit:BoxFit.contain
                      ),
                    ),
                    ...points.map((p) => Positioned(
              left: p[0]-5,
              top: p[1]-5,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            )),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.rotate_left),
                  onPressed: () {
                    setState(() {
                      _rotation += pi;
                    });
                  }
                ),
                IconButton(
                  icon: const Icon(Icons.undo),
                  onPressed: points.isNotEmpty ? () {
                    setState(() {
                      points.removeLast();
                    });
                  }
                  : null,
                ),
              ],
            ),
            const SizedBox(height: 12,),
            const Text('Time shooting'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton (
                  onPressed: () {
                    setState(() {
                      _shooting.start();
                      _uiTimer ??= Timer.periodic(
                        const Duration(milliseconds: 100),
                        (_) {
                          setState(() {});
                        }
                      );
                    });
                  },
                  child: const Text('start'),
                ),
                Container(width: 25, alignment: Alignment.center, child: Text(_shooting.elapsed.inSeconds.toString()),),
                ElevatedButton (
                  onPressed: () {
                    setState(() {
                      _shooting.stop();
                    });
                  },
                  child: const Text('stop'),
                )
              ],
            ),
            const SizedBox(height: 12,),
            const Text('Time relaying fuel'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton (
                  onPressed: () {
                    setState(() {
                      _relay.start();
                      _uiTimer ??= Timer.periodic(
                        const Duration(milliseconds: 100),
                        (_) {
                          setState(() {});
                        }
                      );
                    });
                  },
                  child: const Text('start'),
                ),
                Container(width: 25, alignment: Alignment.center, child: Text(_relay.elapsed.inSeconds.toString()),),
                ElevatedButton (
                  onPressed: () {
                    setState(() {
                      _relay.stop();
                    });
                  },
                  child: const Text('stop'),
                )
              ],
            ),
            const SizedBox(height: 12,),
            const Text('Time in the opponet\'s zone'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton (
                  onPressed: () {
                    setState(() {
                      _defense.start();
                      _uiTimer ??= Timer.periodic(
                        const Duration(milliseconds: 100),
                        (_) {
                          setState(() {});
                        }
                      );
                    });
                  },
                  child: const Text('start'),
                ),
                Container(width: 25, alignment: Alignment.center, child: Text(_defense.elapsed.inSeconds.toString()),),
                ElevatedButton (
                  onPressed: () {
                    setState(() {
                      _defense.stop();
                    });
                  },
                  child: const Text('stop'),
                )
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: const Text('Trench?'),
                ),
                Checkbox(
                  value: _trench,
                  onChanged: (bool? value) {
                    setState(() {
                      _trench = value ?? false;
                    });
                  }
                ),
                SizedBox(
                  child: const Text('Bump?'),
                ),
                Checkbox(
                  value: _bump,
                  onChanged: (bool? value) {
                    setState(() {
                      _bump = value ?? false;
                    });
                  }
                )
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [ElevatedButton(
              onPressed: (){
                _uiTimer?.cancel();
                Navigator.pop(context);
              },
              child: const Text('   Go Back   '),
            ),
            ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize:16),
                    padding: const EdgeInsets.all(12),
                  ),
                  onPressed: () {
                    _shooting.stop();
                    _relay.stop();
                    _defense.stop();
                    _output3 ='$_fuel\t$_fuel\t${points.map((p) => '${p[0]},${p[1]}').join(';')}\t${_shooting.elapsed.inSeconds.toString()}\t${_relay.elapsed.inSeconds.toString()}\t${_defense.elapsed.inSeconds.toString()}\t$_trench\t$_bump';
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Endgame( 
                          output3: _output3,
                          output2: widget.output2,
                          output1: widget.output1
                          )),
                    );
                  },
                  child: const Text('        Next        '),
                ) 
              ],
            )
            ],
          ),
        ),
      ),
    );
  }
}

