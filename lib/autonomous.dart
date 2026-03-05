import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'teleop.dart';

class Autonomous extends StatefulWidget {
  final String output1;
  const Autonomous({super.key, required this.output1});

  @override
  State<Autonomous> createState() => _AutonomousState();
}

class _AutonomousState extends State<Autonomous> {
  String _output2 = '';

  final Stopwatch _shooting = Stopwatch();
  Timer? _uiTimer;

  final int _fuel = 0;
  bool _outpost = false;
  bool _depot = false;
  bool _trench = false;
  bool _bump = false;
  bool _tower = false;

  final List<Offset> _points = [];
  double _rotation = 0;

  @override
  void dispose() {
    _uiTimer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _shooting.start();
    _uiTimer ??= Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (mounted) setState(() {});
    });
    setState(() {});
  }

  void _stopTimer() {
    _shooting.stop();
    if (!_shooting.isRunning) {
      _uiTimer?.cancel();
      _uiTimer = null;
    }
    setState(() {});
  }

  void _next() {
    _output2 =
    '$_fuel\t'
        '${_points.map((p) => '${p.dx.toStringAsFixed(2)},${p.dy.toStringAsFixed(2)}').join(';')}\t'
        '${_outpost ? 1 : 0}\t'
        '${_depot ? 1 : 0}\t'
        '${_trench ? 1 : 0}\t'
        '${_bump ? 1 : 0}\t'
        '${_tower ? 1 : 0}';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Teleop(output2: _output2, output1: widget.output1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Autonomous'),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Shooting Timer',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: FilledButton.icon(
                                onPressed:
                                _shooting.isRunning ? null : _startTimer,
                                icon: const Icon(Icons.play_arrow),
                                label: const Text('Start'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              decoration: BoxDecoration(
                                border: Border.all(color: scheme.outlineVariant),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${_shooting.elapsed.inSeconds}s',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed:
                                _shooting.isRunning ? _stopTimer : null,
                                icon: const Icon(Icons.stop),
                                label: const Text('Stop'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Tap shots on the field',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 12),

                        Center(
                          child: GestureDetector(
                            onTapDown: (details) {
                              setState(() {
                                _points.add(details.localPosition);
                              });
                            },
                            child: Stack(
                              children: [
                                Transform.rotate(
                                  angle: _rotation,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      'assets/2026Field.png',
                                      width: 356.5,
                                      height: 174,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                ..._points.map(
                                      (p) => Positioned(
                                    left: p.dx - 5,
                                    top: p.dy - 5,
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: scheme.error,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              tooltip: 'Rotate 180°',
                              icon: const Icon(Icons.rotate_left),
                              onPressed: () => setState(() => _rotation += pi),
                            ),
                            IconButton(
                              tooltip: 'Undo last tap',
                              icon: const Icon(Icons.undo),
                              onPressed: _points.isNotEmpty
                                  ? () => setState(() => _points.removeLast())
                                  : null,
                            ),
                            IconButton(
                              tooltip: 'Clear',
                              icon: const Icon(Icons.delete_outline),
                              onPressed: _points.isNotEmpty
                                  ? () => setState(() => _points.clear())
                                  : null,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        SwitchListTile(
                          title: const Text('Depot'),
                          value: _depot,
                          onChanged: (v) => setState(() => _depot = v),
                        ),
                        SwitchListTile(
                          title: const Text('Outpost'),
                          value: _outpost,
                          onChanged: (v) => setState(() => _outpost = v),
                        ),
                        SwitchListTile(
                          title: const Text('Trench'),
                          value: _trench,
                          onChanged: (v) => setState(() => _trench = v),
                        ),
                        SwitchListTile(
                          title: const Text('Bump'),
                          value: _bump,
                          onChanged: (v) => setState(() => _bump = v),
                        ),
                        SwitchListTile(
                          title: const Text('Climbed'),
                          value: _tower,
                          onChanged: (v) => setState(() => _tower = v),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // NAV BUTTONS
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
    );
  }
}