import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pregame.dart';

class MatchDisplay extends StatefulWidget {
  final String finaloutput;
  const MatchDisplay({super.key, required this.finaloutput});

  @override
  State<MatchDisplay> createState() => _MatchDisplayState();
}

class _MatchDisplayState extends State<MatchDisplay> {
  static const _storageKey = 'outputs';

  List<String> _outputs = [];
  final Set<String> _selected = {};
  String? _qrData;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList(_storageKey) ?? [];

    if (widget.finaloutput.trim().isNotEmpty) {
      saved.add(widget.finaloutput.trim());
      await prefs.setStringList(_storageKey, saved);
    }

    if (!mounted) return;
    setState(() => _outputs = saved);
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_storageKey, _outputs);
  }

  void _toggleSelect(String output) {
    setState(() {
      if (_selected.contains(output)) {
        _selected.remove(output);
      } else {
        _selected.add(output);
      }
      _qrData = null;
    });
  }

  Future<void> _deleteSelected() async {
    if (_selected.isEmpty) return;

    setState(() {
      _outputs.removeWhere(_selected.contains);
      _selected.clear();
      _qrData = null;
    });

    await _save();
  }

  void _generateQr() {
    if (_selected.isEmpty) return;
    setState(() {
      _qrData = _selected.join('\n');
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final hasSelection = _selected.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Games Viewer'),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: FilledButton.icon(
                                onPressed: hasSelection ? _generateQr : null,
                                icon: const Icon(Icons.qr_code),
                                label: const Text('Generate QR'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: hasSelection ? _deleteSelected : null,
                                icon: const Icon(Icons.delete_outline),
                                label: const Text('Delete'),
                              ),
                            ),
                          ],
                        ),
                        if (_qrData != null) ...[
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: scheme.outlineVariant),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: QrImageView(
                              data: _qrData!,
                              version: QrVersions.auto,
                              size: 220,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Selected: ${_selected.length}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: scheme.onSurfaceVariant),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Expanded(
                  child: Card(
                    elevation: 2,
                    child: _outputs.isEmpty
                        ? const Center(child: Text('No matches available'))
                        : ListView.separated(
                      itemCount: _outputs.length,
                      separatorBuilder: (_, __) =>
                          Divider(height: 1, color: scheme.outlineVariant),
                      itemBuilder: (context, index) {
                        final output = _outputs[index];
                        final selected = _selected.contains(output);

                        return ListTile(
                          dense: true,
                          title: Text(
                            output,
                            style: const TextStyle(fontSize: 12),
                          ),
                          selected: selected,
                          selectedTileColor: scheme.primaryContainer,
                          trailing: selected
                              ? Icon(Icons.check_circle, color: scheme.primary)
                              : null,
                          onTap: () => _toggleSelect(output),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Back to Scouting'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const Pregame()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}