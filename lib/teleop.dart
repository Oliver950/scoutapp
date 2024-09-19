import 'dart:math';
import 'package:flutter/material.dart';
import 'Endgame.dart';

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
  int _score1 = 0;
  int _score2 = 0;
  int _score3 = 0;
  double _rotation = 0;
  String _pickupMethod = 'NA';
  List _tapLocations = [];
  final List _undoStack = [];
  String _image = '';

    void _undo() {
      if (_undoStack.length >1){
        setState(() {
          _undoStack.removeLast();
          _tapLocations = _undoStack.last.toList();
          _output3 ='$_score1 $_score2 $_score3 $_pickupMethod $_tapLocations $_rotation';
        });
      }
    }

  @override  
  Widget build(BuildContext context) {  
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              const Text('Score #1   '),
              ElevatedButton (
                onPressed: () {
                  setState((){
                    _score1--;
                  });
                  _output3 ='$_score1 $_score2 $_score3 $_pickupMethod $_tapLocations $_rotation';
                },
                child: const Icon(Icons.remove),
              ),
              Text('   $_score1   '),
              ElevatedButton (
                onPressed: () {
                  setState((){
                    _score1++;
                  });
                  _output3 ='$_score1 $_score2 $_score3 $_pickupMethod $_tapLocations $_rotation';
                },
                child: const Icon(Icons.add),
              ),
                ],
              ),
              const SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              const Text('Score #2   '),
              ElevatedButton (
                onPressed: () {
                  setState((){
                    _score2--;
                  });
                  _output3 ='$_score1 $_score2 $_score3 $_pickupMethod $_tapLocations $_rotation';
                },
                child: const Icon(Icons.remove),
              ),
              Text('   $_score2   '),
              ElevatedButton (
                onPressed: () {
                  setState((){
                    _score2++;
                  });
                  _output3 ='$_score1 $_score2 $_score3 $_pickupMethod $_tapLocations $_rotation';
                },
                child: const Icon(Icons.add),
              ),
                ],
              ),
              const SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              const Text('Score #3   '),
              ElevatedButton (
                onPressed: () {
                  setState((){
                    _score3--;
                  });
                  _output3 ='$_score1 $_score2 $_score3 $_pickupMethod $_tapLocations $_rotation';
                },
                child: const Icon(Icons.remove),
              ),
              Text('   $_score3   '),
              ElevatedButton (
                onPressed: () {
                  setState((){
                    _score3++;
                  });
                  _output3 ='$_score1 $_score2 $_score3 $_pickupMethod $_tapLocations $_rotation';
                },
                child: const Icon(Icons.add),
              ),
                ],
              ),
              const SizedBox(height: 12,),
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Pickup Method'),
                const SizedBox(width: 6,),
                DropdownButton(
                  value: _pickupMethod,
                  items: const [
                    DropdownMenuItem(value: 'A', child: Text('Method A')),
                    DropdownMenuItem(value: 'B', child: Text('Method B')),
                    DropdownMenuItem(value: 'AB', child: Text('Both')),
                    DropdownMenuItem(value: 'NA', child: Text('NA')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _pickupMethod = value as String;
                     _output3 ='$_score1 $_score2 $_score3 $_pickupMethod $_tapLocations $_rotation';
                    });
                  },
                )
              ],
            ),
            const SizedBox(height: 12,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Location Shot From')
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
                      _output3 ='$_score1 $_score2 $_score3 $_pickupMethod $_tapLocations $_rotation';
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
                    _output3 ='$_score1 $_score2 $_score3 $_pickupMethod $_tapLocations $_rotation';
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

