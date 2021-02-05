import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class RiveLogoAnimated extends StatefulWidget {
  final String animation;

  const RiveLogoAnimated({Key key, this.animation = 'go'}) : super(key: key);

  @override
  _RiveLogoAnimatedState createState() => _RiveLogoAnimatedState();
}

class _RiveLogoAnimatedState extends State<RiveLogoAnimated> {
  final riveFileName = 'assets/rive/logo.riv';
  String get _animName {
    switch (widget.animation) {
      case 'aby':
        return 'aby';
        break;
      default:
        return 'go';
        break;
    }
  }

  Artboard _artBoard;

  @override
  void initState() {
    super.initState();
    _loadRiveFile();
  }

  @override
  void dispose() {
    _artBoard?.remove();
    super.dispose();
  }

  // loads a Rive file
  void _loadRiveFile() async {
    final bytes = await rootBundle.load(riveFileName);
    final file = RiveFile();

    if (file.import(bytes)) {
      // Select an animation by it's name
      if (this.mounted) setState(() => {_artBoard = file.mainArtboard..addController(SimpleAnimation(_animName))});
    }
  }

  /// Show the rive file, when loaded
  @override
  Widget build(BuildContext context) {
    return _artBoard != null ? Rive(artboard: _artBoard, fit: BoxFit.contain) : const SizedBox();
  }
}
