import 'package:flutter/material.dart';
import 'teleop.dart';
import 'dart:async';

class Autonomous extends StatefulWidget{
  final String output1;

  const Autonomous({super.key, required this.output1});

  @override
  _SecondRouteState createState() => _SecondRouteState();
  }

  class _SecondRouteState extends State<Autonomous>{
    String _output2 = '';
    final _shooting = Stopwatch();
    int _fuel = 0;
    bool _depot = false;
    bool _outpost = false;
    bool _tower = false;
    Timer? _uiTimer;


  @override
  Widget build(BuildContext context) {

    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)
      ),
    child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Autonomous',
        style: TextStyle(
          fontSize: 20,
        )),
        toolbarHeight: 25,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 125,
                  child: const Text('Collected Depot?'),
                ),
                Checkbox(
                  value: _depot,
                  onChanged: (bool? value) {
                    setState(() {
                      _depot = value ?? false;
                    });
                  }
                )
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 125,
                  child: const Text('Collected Outpost?'),
                ),
                Checkbox(
                  value: _outpost,
                  onChanged: (bool? value) {
                    setState(() {
                      _outpost = value ?? false;
                    });
                  }
                )
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 125,
                  child: const Text('Climbed'),
                ),
                Checkbox(
                  value: _tower,
                  onChanged: (bool? value) {
                    setState(() {
                      _tower = value ?? false;
                    });
                  }
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [ElevatedButton(
              onPressed: (){
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
                    _output2 ='$_fuel\t$_depot\t$_outpost\t$_tower';
                    Navigator.push(
                      
                      context,
                      MaterialPageRoute(
                        builder: (context) => Teleop( 
                          output2: _output2,
                          output1: widget.output1)),
                    );
                  },
                  child: const Text('        Next        '),
                )
              ],
            )
          ],
        )
      ),
    )
    );
  }
}

