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
  final Stopwatch _stopwatch = Stopwatch();
  bool _isRunning = false;
  String _elapsedTime = '00.00';
  String _finalLocation = ' C';
  String _objective = ' NA';

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer(){
    Stream.periodic(const Duration(milliseconds: 100), (i){
      if (_isRunning) {
        setState(() {
          _elapsedTime = _formatDuration(_stopwatch.elapsed);
        });
      }
    }).listen((_){});
  }

    String _formatDuration(Duration duration) {  
   int seconds = duration.inSeconds;  
   _output4 ='$_elapsedTime $_finalLocation $_objective';
   int milliseconds = duration.inMilliseconds.remainder(1000) ~/10;  
   return '${seconds.toString().padLeft(2, '0')}.${milliseconds.toString().padLeft(2, '0')}';  
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
              const Text('Endgame Objective Timer'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  ElevatedButton(
                    child: Text(_isRunning? 'Stop': 'Start'),
                    onPressed: (){
                      setState(() {
                        if (_isRunning) {
                          _stopwatch.stop();
                        }else{
                          _stopwatch.start();
                          
                        }
                        _isRunning=!_isRunning;
                      });
                    },
                  ),
                  Text('   Elapsed time: $_elapsedTime   '),
                  ElevatedButton(
                    child: const Text('Reset'),
                    onPressed: (){
                      setState(() {
                        _stopwatch.reset();
                        _elapsedTime = '00.00';
                        _output4 ='$_elapsedTime $_finalLocation $_objective';
                      });
                    },
                  )
                ],
              ),
              const SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Final Location'),
                  const SizedBox(width: 6,),
                  DropdownButton(
                    value: _finalLocation,
                    items: const [
                      DropdownMenuItem(value: ' A',child: Text('Position A'),),
                      DropdownMenuItem(value: ' B',child: Text('Position B'),),
                      DropdownMenuItem(value: ' C',child: Text('Position C'),),
                    ],
                    onChanged: (value){
                      setState(() {
                        _finalLocation = value as String;
                        _output4 ='$_elapsedTime $_finalLocation $_objective';
                      });
                    },
                  )
                ],
              ),
              const SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Final Location'),
                  const SizedBox(width: 6,),
                  DropdownButton(
                    value: _objective,
                    items: const [
                      DropdownMenuItem(value: ' A',child: Text('Objective A'),),
                      DropdownMenuItem(value: ' B',child: Text('Objective B'),),
                      DropdownMenuItem(value: ' C',child: Text('Objective C'),),
                      DropdownMenuItem(value: ' NA',child: Text('NA'),),
                    ],
                    onChanged: (value){
                      setState(() {
                        _objective = value as String;
                        _output4 ='$_elapsedTime $_finalLocation $_objective';
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

