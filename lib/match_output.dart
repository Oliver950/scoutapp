import 'package:flutter/material.dart';

class MatchOutput extends StatelessWidget {  
  final String output4;
  final String output3;
  final String output2;
  final String output1;  
  
  const MatchOutput({super.key,
   required this.output4,
   required this.output3,
   required this.output2,
   required this.output1
   });  
  
  

  @override
  Widget build(BuildContext context){
    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('End',
          style: TextStyle(fontSize: 20)),
          toolbarHeight: 20,
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Pregame: $output1')
                ],
              ),
              const SizedBox(height:12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Autonomous: $output2')
                ],
              ),
              const SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('teleop: $output3')
                ],
              ),
              const SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Endgame: $output4')
                ],
              ),
              const SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Final Output: $output1 $output2 $output3 $output4')
                ],
              ),
              const SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text('Go Back'),
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