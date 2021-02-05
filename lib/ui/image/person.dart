import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

// Rive Image
class RivePerson extends StatefulWidget {
  @override
  _RivePersonState createState() => _RivePersonState();
}

class _RivePersonState extends State<RivePerson> {
  final riveFileName = 'assets/rive/person.riv';
  Artboard _artBoard;

  @override
  void initState() {
    _loadRiveFile();
    super.initState();
  }

  @override
  void dispose() {
    _artBoard.remove();
    super.dispose();
  }

  // loads a Rive file
  void _loadRiveFile() async {
    final bytes = await rootBundle.load(riveFileName);
    final file = RiveFile();

    if (file.import(bytes)) {
      // Select an animation by it's name
      if (this.mounted) setState(() => _artBoard = file.mainArtboard);
    }
  }

  /// Show the rive file, when loaded
  @override
  Widget build(BuildContext context) {
    return _artBoard != null ? Rive(artboard: _artBoard, fit: BoxFit.contain) : const SizedBox();
  }
}
