import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class RiveImage extends StatefulWidget {
  final String path;
  final String animation;

  const RiveImage({Key key, this.path, this.animation}) : super(key: key);

  @override
  _RiveImageState createState() => _RiveImageState();
}

class _RiveImageState extends State<RiveImage> {
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
    final bytes = await rootBundle.load(widget.path); // 'assets/rive/logo.riv'
    final file = RiveFile();

    if (file.import(bytes)) {
      // Select an animation by it's name
      if (this.mounted)
        setState(() => {
              if (widget.animation != null)
                {_artBoard = file.mainArtboard..addController(SimpleAnimation(widget.animation))}
              else
                {_artBoard = file.mainArtboard}
            });
    }
  }

  /// Show the rive file, when loaded
  @override
  Widget build(BuildContext context) {
    return _artBoard != null ? Rive(artboard: _artBoard, fit: BoxFit.contain) : const SizedBox();
  }
}
