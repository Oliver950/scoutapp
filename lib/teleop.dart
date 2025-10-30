import 'package:flutter/material.dart';
import 'endgame.dart';

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
  int _l1 = 0;
  int _l2 = 0;
  int _l3 = 0;
  int _l4 = 0;
  int _processor = 0;
  int _net = 0;
  int _missed = 0;

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
              const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Coral')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                child: const Text('L4'),
              ),
              ElevatedButton (
                onPressed: () {
                  setState((){
                    _l4--;
                    if(_l4<0){_l4=0;}
                  });
                },
                child: const Icon(Icons.remove),
              ),
              Text('   $_l4   '),
              ElevatedButton (
                onPressed: () {
                  setState((){
                    _l4++;
                  });
                },
                child: const Icon(Icons.add),
              ),
             ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                child: const Text('L3'),
              ),
              ElevatedButton (
                onPressed: () {
                  setState((){
                    _l3--;
                  });
                },
                child: const Icon(Icons.remove),
              ),
              Text('   $_l3   '),
              ElevatedButton (
                onPressed: () {
                  setState((){
                    _l3++;
                    if(_l3<0){_l3=0;}
                  });
                },
                child: const Icon(Icons.add),
              ),
             ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                child: const Text('L2'),
              ),
              ElevatedButton (
                onPressed: () {
                  setState((){
                    _l2--;
                    if(_l2<0){_l2=0;}
                  });
                },
                child: const Icon(Icons.remove),
              ),
              Text('   $_l2   '),
              ElevatedButton (
                onPressed: () {
                  setState((){
                    _l2++;
                  });
                },
                child: const Icon(Icons.add),
              ),
             ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                child: const Text('L1'),
              ),
              ElevatedButton (
                onPressed: () {
                  setState((){
                    _l1--;
                    if(_l1<0){_l1=0;}
                  });
                },
                child: const Icon(Icons.remove),
              ),
              Text('   $_l1   '),
              ElevatedButton (
                onPressed: () {
                  setState((){
                    _l1++;
                  });
                },
                child: const Icon(Icons.add),
              ),
             ]
            ),
            const SizedBox(height: 12,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Algae')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                child: const Text('Processor'),
              ),
              ElevatedButton (
                onPressed: () {
                  setState((){
                    _processor--;
                    if(_processor<0){_processor=0;}
                  });
                },
                child: const Icon(Icons.remove),
              ),
              Text('   $_processor   '),
              ElevatedButton (
                onPressed: () {
                  setState((){
                    _processor++;
                  });
                },
                child: const Icon(Icons.add),
              ),
             ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                child: const Text('Net'),
              ),
              ElevatedButton (
                onPressed: () {
                  setState((){
                    _net--;
                  });
                },
                child: const Icon(Icons.remove),
              ),
              Text('   $_net   '),
              ElevatedButton (
                onPressed: () {
                  setState((){
                    _net++;
                    if(_net<0){_net=0;}
                  });
                },
                child: const Icon(Icons.add),
              ),
             ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  child: const Text('Note: This is for algae scored by the ROBOT',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ]
            ),
            const SizedBox(height: 12,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Missed/Dropped Cycles')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton (
                onPressed: () {
                  setState((){
                    _missed--;
                    if(_missed<0){_missed=0;}
                  });
                },
                child: const Icon(Icons.remove),
              ),
              Text('   $_missed   '),
              ElevatedButton (
                onPressed: () {
                  setState((){
                    _missed++;
                  });
                },
                child: const Icon(Icons.add),
              ),
             ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  child: const Text('Note: This is when a game piece is dropped because of the robot. NOT human player',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic
                    ),
                  ),
                ),
              ]
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
                    _output3 ='$_l1\t$_l2\t$_l3\t$_l4\t$_processor\t$_net';
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

