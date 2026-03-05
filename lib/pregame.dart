import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'autonomous.dart';

class Pregame extends StatefulWidget {
  const Pregame({super.key});

  @override
  State<Pregame> createState() => _PregameState();
}

class _PregameState extends State<Pregame> {
  final _scouterController = TextEditingController();
  final _matchController = TextEditingController();
  final _teamController = TextEditingController();

  String _robot = 'R1';

  bool get _canContinue =>
      _scouterController.text.trim().isNotEmpty &&
          _matchController.text.trim().isNotEmpty &&
          _teamController.text.trim().isNotEmpty;

  @override
  void dispose() {
    _scouterController.dispose();
    _matchController.dispose();
    _teamController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pregame'),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Match Setup',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Fill these in before scouting.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    TextFormField(
                      controller: _scouterController,
                      onChanged: (_) => setState(() {}),
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Scouter Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\s]")),
                      ],
                    ),
                    const SizedBox(height: 12),

                    TextFormField(
                      controller: _matchController,
                      onChanged: (_) => setState(() {}),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Match Number',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.confirmation_number),
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    const SizedBox(height: 12),

                    TextFormField(
                      controller: _teamController,
                      onChanged: (_) => setState(() {}),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        labelText: 'Team Number',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.groups),
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    const SizedBox(height: 16),

                    InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Robot',
                        border: OutlineInputBorder(),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _robot,
                          isExpanded: true,
                          items: const [
                            DropdownMenuItem(value: 'R1', child: Text('Red 1')),
                            DropdownMenuItem(value: 'R2', child: Text('Red 2')),
                            DropdownMenuItem(value: 'R3', child: Text('Red 3')),
                            DropdownMenuItem(value: 'B1', child: Text('Blue 1')),
                            DropdownMenuItem(value: 'B2', child: Text('Blue 2')),
                            DropdownMenuItem(value: 'B3', child: Text('Blue 3')),
                          ],
                          onChanged: (v) => setState(() => _robot = v ?? 'R1'),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      height: 48,
                      child: FilledButton.icon(
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text('Next'),
                        onPressed: _canContinue
                            ? () {
                          final output =
                              '${_scouterController.text.trim()}\t'
                              '${_matchController.text.trim()}\t'
                              '${_teamController.text.trim()}\t'
                              '$_robot';

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Autonomous(output1: output),
                            ),
                          );
                        }
                            : null,
                      ),
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