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
  final _neutral = Stopwatch();
  final _relay = Stopwatch();
  final _defense = Stopwatch();
  Timer? _uiTimer;

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
            const SizedBox(height: 12,),
            Text('Time shooting'),
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
                  child: Text('start'),
                ),
                Container(width: 25, child: Text(_shooting.elapsed.inSeconds.toString()), alignment: Alignment.center,),
                ElevatedButton (
                  onPressed: () {
                    setState(() {
                      _shooting.stop();
                    });
                  },
                  child: Text('stop'),
                )
              ],
            ),
            const SizedBox(height: 12,),
            Text('Time in neutral zone'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton (
                  onPressed: () {
                    setState(() {
                      _neutral.start();
                      _uiTimer ??= Timer.periodic(
                        const Duration(milliseconds: 100),
                        (_) {
                          setState(() {});
                        }
                      );
                    });
                  },
                  child: Text('start'),
                ),
                Container(width: 25, child: Text(_neutral.elapsed.inSeconds.toString()), alignment: Alignment.center,),
                ElevatedButton (
                  onPressed: () {
                    setState(() {
                      _neutral.stop();
                    });
                  },
                  child: Text('stop'),
                )
              ],
            ),
            const SizedBox(height: 12,),
            Text('Time relaying fuel'),
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
                  child: Text('start'),
                ),
                Container(width: 25, child: Text(_relay.elapsed.inSeconds.toString()), alignment: Alignment.center,),
                ElevatedButton (
                  onPressed: () {
                    setState(() {
                      _relay.stop();
                    });
                  },
                  child: Text('stop'),
                )
              ],
            ),
            const SizedBox(height: 12,),
            Text('Time on the opponet\'s zone'),
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
                  child: Text('start'),
                ),
                Container(width: 25, child: Text(_defense.elapsed.inSeconds.toString()), alignment: Alignment.center,),
                ElevatedButton (
                  onPressed: () {
                    setState(() {
                      _defense.stop();
                    });
                  },
                  child: Text('stop'),
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
                    _neutral.stop();
                    _relay.stop();
                    _defense.stop();
                    _output3 ='$_fuel\t${_shooting.elapsed.inSeconds.toString()}\t${_neutral.elapsed.inSeconds.toString()}\t${_relay.elapsed.inSeconds.toString()}\t${_defense.elapsed.inSeconds.toString()}';
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

