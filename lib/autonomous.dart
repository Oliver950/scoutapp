import 'dart:math';
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
    final int _fuel = 0;
    int _outpost = 0;
    int _depot = 0;
    int _trench = 0;
    int _bump = 0;
    int _tower = 0;
    Timer? _uiTimer;
    final List<List<double>> points = [];
    double _rotation = 0;

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
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  child: Text('Depot?'),
                ),
                Checkbox(
                  value: _depot == 1,
                  onChanged: (bool? value) {
                    setState(() {
                      _depot = value == true ? 1 : 0;
                    });
                  }
                ),
                const SizedBox(
                  child: Text('Outpost?'),
                ),
                Checkbox(
                  value: _outpost == 1,
                  onChanged: (bool? value) {
                    setState(() {
                      _outpost = value == true ? 1 : 0;
                    });
                  }
                )
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  child: Text('Trench?'),
                ),
                Checkbox(
                  value: _trench == 1,
                  onChanged: (bool? value) {
                    setState(() {
                      _trench = value == true ? 1 : 0;
                    });
                  }
                ),
                const SizedBox(
                  child: Text('Bump?'),
                ),
                Checkbox(
                  value: _bump == 1,
                  onChanged: (bool? value) {
                    setState(() {
                      _bump = value == true ? 1 : 0;
                    });
                  }
                )
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  child: Text('Climbed?'),
                ),
                Checkbox(
                  value: _tower == 1,
                  onChanged: (bool? value) {
                    setState(() {
                      _tower = value == true ? 1 : 0;
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
                    _output2 ='$_fuel\t${points.map((p) => '${p[0]},${p[1]}').join(';')}\t$_outpost\t$_depot\t$_trench\t$_bump\t$_tower';
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

