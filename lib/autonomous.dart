import 'dart:math';
import 'package:flutter/material.dart';
import 'teleop.dart';

class Autonomous extends StatefulWidget{
  final String output1;

  const Autonomous({super.key, required this.output1});

  @override
  _SecondRouteState createState() => _SecondRouteState();
  }

  class _SecondRouteState extends State<Autonomous>{
    int _score1 = 0;
    int _score2 =0;
    String _output2 = '';
    double _rotation = 0;
    String _image = '';
    List _tapLocations = [];
    final List _undoStack = [];

    void _undo() {
      if (_undoStack.length >1){
        setState(() {
          _undoStack.removeLast();
          _tapLocations = _undoStack.last.toList();
          _output2 ='$_score1 $_score2 $_tapLocations $_image';
        });
      }
    }

    _SecondRouteState() {
      _undoStack.add([]);
    }

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
            Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Score #1   '),
              ElevatedButton (
                onPressed: () {
                  setState((){
                    _score1--;
                  });
                  _output2 ='$_score1 $_score2 $_tapLocations $_image';
                },
                child: const Icon(Icons.remove),
              ),
              Text('   $_score1   '),
              ElevatedButton (
                onPressed: () {
                  setState((){
                    _score1++;
                  });
                  _output2 ='$_score1 $_score2 $_tapLocations $_image';
                },
                child: const Icon(Icons.add),
              ),
             ]
            ),
            const SizedBox(height: 12,),
            Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Score #2   '),
              ElevatedButton (
                onPressed: () {
                  setState((){
                    _score2--;
                  });
                  _output2 ='$_score1 $_score2 $_tapLocations $_image';
                },
                child: const Icon(Icons.remove),
              ),
              Text('   $_score2   '),
              ElevatedButton (
                onPressed: () {
                  setState((){
                    _score2++;
                  });
                  _output2 ='$_score1 $_score2 $_tapLocations $_image';
                },
                child: const Icon(Icons.add),
              ),
             ]
            ),
            const SizedBox(height: 12,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Positions went to')
              ],
            ),
            const SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTapDown: (TapDownDetails details) {
                    setState(() {
                      _tapLocations.add(details.localPosition);
                      if (_undoStack.isNotEmpty) {
                        _undoStack.add(_tapLocations.toList());
                      }else {
                        _undoStack.add([details.localPosition]);
                      }
                      _output2 ='$_score1 $_score2 $_tapLocations $_image';
                    });
                    },
                    child: Stack(
                      children: [
                         Transform.rotate(
                  angle: _rotation,
                  child: Image.asset('assets/Field2024.png',
                  width: 345,
                  height: 171,
                  ),
                ),
                ..._tapLocations.map((location){
                  return Positioned(
                    left: location.dx - 5,
                    top: location.dy - 5,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                    ),
                  );
                })
                      ],
                    ),
                ),
              ],
            ),
            const SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: (){
                    setState(() {
                      if (_rotation == 0){
                        _rotation = pi;
                        _image = 'Rotated';
                      } else {
                        _rotation = 0;
                        _image = 'Default';
                      }
                      _tapLocations = _tapLocations.map((location){
                        return Offset((345-location.dx).toDouble(),(171-location.dy).toDouble());
                      }).toList();
                      _undoStack.add(_tapLocations.toList());
                    });
                    _output2 ='$_score1 $_score2 $_tapLocations $_image';
                  },
                  child: const Icon(Icons.rotate_right),
                ),
                const SizedBox(width: 8,),
                ElevatedButton(
                  onPressed: _undo,
                  child: const Icon(Icons.undo),
                )
              ],
            ),
            const SizedBox(height: 12,),
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

