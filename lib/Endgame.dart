import 'package:flutter/material.dart';
import 'match_output.dart';

class Endgame extends StatefulWidget {
  final String output3;
  final String output2;
  final String output1;

  const Endgame({
    super.key,
    required this.output3,
    required this.output2,
    required this.output1,
  });

  @override
  State<Endgame> createState() => _EndgameState();
}

class _EndgameState extends State<Endgame> {
  String _output4 = '';
  String _tower = '0';
  String _position = 'NA';

  void _next() {
    _output4 = '$_tower\t$_position';
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MatchOutput(
          output4: _output4,
          output3: widget.output3,
          output2: widget.output2,
          output1: widget.output1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Endgame'),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Endgame Details',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),

                    InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Final Location',
                        border: OutlineInputBorder(),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _tower,
                          isExpanded: true,
                          items: const [
                            DropdownMenuItem(value: '3', child: Text('Level 3')),
                            DropdownMenuItem(value: '2', child: Text('Level 2')),
                            DropdownMenuItem(value: '1', child: Text('Level 1')),
                            DropdownMenuItem(value: '0', child: Text('NA')),
                          ],
                          onChanged: (v) => setState(() => _tower = v ?? '0'),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Climb position',
                        border: OutlineInputBorder(),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _position,
                          isExpanded: true,
                          items: const [
                            DropdownMenuItem(value: 'side', child: Text('Side')),
                            DropdownMenuItem(value: 'front', child: Text('Front')),
                            DropdownMenuItem(value: 'NA', child: Text('NA')),
                          ],
                          onChanged: (v) => setState(() => _position = v ?? 'NA'),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.arrow_back),
                            label: const Text('Back'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FilledButton.icon(
                            icon: const Icon(Icons.arrow_forward),
                            label: const Text('Next'),
                            onPressed: _next,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}