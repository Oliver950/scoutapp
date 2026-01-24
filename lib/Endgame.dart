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
  String _tower = '0';
  String _position = 'NA';

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
                    value: _tower,
                    items: const [
                      DropdownMenuItem(value: '3',child: Text('Tower 3'),),
                      DropdownMenuItem(value: '2',child: Text('Tower 2'),),
                      DropdownMenuItem(value: '1',child: Text('Tower 1'),),
                      DropdownMenuItem(value: '0',child: Text('NA'),),
                    ],
                    onChanged: (value){
                      setState(() {
                        _tower = value as String;
                      });
                    },
                  )
                ],
              ),
              const SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Climb position'),
                  const SizedBox(width: 6,),
                  DropdownButton(
                    value: _position,
                    items: const [
                      DropdownMenuItem(value: 'side',child: Text('Side'),),
                      DropdownMenuItem(value: 'front',child: Text('Front'),),
                      DropdownMenuItem(value: 'NA',child: Text('NA'),),
                    ],
                    onChanged: (value){
                      setState(() {
                        _position = value as String;
                      });
                    },
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
                    _output4 =_tower;
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

