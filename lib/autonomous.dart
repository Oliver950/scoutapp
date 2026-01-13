import 'package:flutter/material.dart';
import 'teleop.dart';

class Autonomous extends StatefulWidget{
  final String output1;

  const Autonomous({super.key, required this.output1});

  @override
  _SecondRouteState createState() => _SecondRouteState();
  }

  class _SecondRouteState extends State<Autonomous>{
    String _output2 = '';
    int _fuel = 0;
    bool _depot = false;
    bool _outpost = false;
    bool _tower = false;

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                child: const Text('Fuel'),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton (
                onPressed: () {
                  setState((){
                    _fuel=_fuel-5;
                    if(_fuel<0){_fuel=0;}
                  });
                },
                child: const Text('-5'),
              ),
              Container(width: 5,),
              ElevatedButton (
                onPressed: () {
                  setState((){
                    _fuel=_fuel-2;
                    if(_fuel<0){_fuel=0;}
                  });
                },
                child: const Text('-2'),
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
                    _fuel++;
                  });
                },
                child: const Text('+1'),
              ),
              Container(width: 5,),
              ElevatedButton (
                onPressed: () {
                  setState((){
                    _fuel=_fuel+2;
                  });
                },
                child: const Text('+2'),
              ),
              Container(width: 5,),
              ElevatedButton (
                onPressed: () {
                  setState((){
                    _fuel=_fuel+5;
                  });
                },
                child: const Text('+5'),
              ),
             ]
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

