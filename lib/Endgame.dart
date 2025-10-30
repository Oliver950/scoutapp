import 'package:flutter/material.dart';
import 'match_output.dart';

class Endgame extends StatefulWidget {  
  final String output3;
  final String output2;
  final String output1;
  
  const Endgame({super.key,
   required this.output3,
   required this.output2,
   required this.output1
   });

  @override  
  _FourthRouteState createState() => _FourthRouteState();  
}  
  
class _FourthRouteState extends State<Endgame> {  
  String _output4 = '';
  String _finalLocation = 'NA';
  bool _isDefence = false;
  bool _isAOR = false;
  bool _isImmobile = false;

  @override
  Widget build(BuildContext context) {  
    return Theme (
      data: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text ('EndGame',
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
              const SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Final Location'),
                  const SizedBox(width: 6,),
                  DropdownButton(
                    value: _finalLocation,
                    items: const [
                      DropdownMenuItem(value: 'P',child: Text('Parked'),),
                      DropdownMenuItem(value: 'D',child: Text('Deep climb'),),
                      DropdownMenuItem(value: 'S',child: Text('Shallow climb'),),
                      DropdownMenuItem(value: 'NA',child: Text('NA'),),
                    ],
                    onChanged: (value){
                      setState(() {
                        _finalLocation = value as String;
                      });
                    },
                  )
                ],
              ),
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  child: const Text('Note: DEEP climb is the LOWER cage, SHALLOW climb is the UPPER cage',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic
                    ),
                  ),
                ),
              ]
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 125,
                  child: const Text('Played Defence'),
                ),
                Checkbox(
                  value: _isDefence,
                  onChanged: (bool? value) {
                    setState(() {
                      _isDefence = value ?? false;
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
                  child: const Text('Can take Algae from the Reef'),
                ),
                Checkbox(
                  value: _isAOR,
                  onChanged: (bool? value) {
                    setState(() {
                      _isAOR = value ?? false;
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
                  child: const Text('Dissabled/Immobile'),
                ),
                Checkbox(
                  value: _isImmobile,
                  onChanged: (bool? value) {
                    setState(() {
                      _isImmobile = value ?? false;
                    });
                  }
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
                    _output4 ='$_finalLocation\t$_isDefence\t$_isAOR\t$_isImmobile';
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MatchOutput(
                          output4: _output4,
                          output3: widget.output3,
                          output2: widget.output2,
                          output1: widget.output1)),
                    );
                  },
                  child: const Text('        Next        '),
                )
              ],
            )
            ]
          )
        )
      )
    );
  }
}

