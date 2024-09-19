import 'dart:math';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'autonomous.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Scouting App',
      home:MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

@override
_MainAppState createState() => _MainAppState();
}

class _MainAppState extends State {
  String _scouterName = '';
  String _event = '';
  String _match = '';
  String _robot = 'R1';
  String _output = '';
  Offset _startLocation = const Offset(-25, -25);
  double _rotation = 0;
  String _image = '';
@override
Widget build(BuildContext context) {
  return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor:Colors.blue),
          textTheme: const TextTheme(
          bodyMedium:TextStyle(fontSize: 16),
          bodyLarge: TextStyle(fontSize: 12),
          bodySmall: TextStyle(fontSize: 12)
          )
        ),
      home:Scaffold(
        appBar: AppBar(
          title: const Text('ScoutingApp',
          style: TextStyle(
            fontSize: 20,
          ),
          ),
          toolbarHeight: 25,
          backgroundColor: Colors.blue,
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            SizedBox(
              width: 250,
              height: 35,
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _scouterName = value;
                  _output ='$_scouterName $_event $_match $_robot $_startLocation $_image';
                });
              },
              decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Scouter Name'
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
            ],
            )
            )
              ]
            ),
             const SizedBox(height: 12,),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            SizedBox(
              width: 250,
              height: 35,
              child: TextField(
                onChanged: (value) {
                  setState(() {

                    _event = value;
                    _output ='$_scouterName $_event $_match $_robot $_startLocation $_image';
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Event'
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))
                ],
              ),
            )
              ]
            ),
             const SizedBox(height: 12,),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 250,
                  height: 35,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _match = value;
                        _output ='$_scouterName $_event $_match $_robot $_startLocation $_image';
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Match Number'
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height:12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Robot'),
                const SizedBox(width: 6,),
                DropdownButton(
                  value: _robot,
                  items: const [
                    DropdownMenuItem(value: 'R1', child: Text('Red 1')),
                    DropdownMenuItem(value: 'R2', child: Text('Red 2')),
                    DropdownMenuItem(value: 'R3', child: Text('Red 3')),
                    DropdownMenuItem(value: 'B1', child: Text('Blue 1')),
                    DropdownMenuItem(value: 'B2', child: Text('Blue 2')),
                    DropdownMenuItem(value: 'B3', child: Text('Blue 3')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _robot = value as String;
                      _output ='$_scouterName $_event $_match $_robot $_startLocation $_image';
                    });
                  },
                )
              ],
            ),
            const SizedBox(height: 12,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Starting Location')
              ],
            ),
            const SizedBox(height:12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTapDown: (TapDownDetails details){
                    if ((details.localPosition.dx >=0 && details.localPosition.dx <=40)||
                    (details.localPosition.dx >=305 && details.localPosition.dx <=345)){
                    setState(() {
                      _startLocation = details.localPosition;
                      _output ='$_scouterName $_event $_match $_robot $_startLocation $_image';
                    });
                    }
                  },
                  child:Stack(
                    children: [
                      Transform.rotate(
                        angle: _rotation,
                        child: Image.asset(
                          'assets/Field2024.png',
                          width: 345,
                          height: 171,
                          ),
                      ),
                      Positioned(
                        left: _startLocation.dx - 5,
                        top: _startLocation.dy - 5,
                        child: Container(
                          width: 10,
                          height:10,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                        )
                      ),
                    ],
                  )
                )
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
                    });
                     _startLocation = Offset (345 - _startLocation.dx, 171 - _startLocation.dy);
                    _output ='$_scouterName $_event $_match $_robot $_startLocation $_image';
                  },
                  child: const Icon(Icons.rotate_right),
                  )
              ]
            ),
            const SizedBox(height:60,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize:16),
                    padding: const EdgeInsets.all(12),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Autonomous(output1:_output)),
                    );
                  },
                  child: const Text('        Next        '),
                )
                  ],
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