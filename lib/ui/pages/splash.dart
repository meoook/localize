import 'package:flutter/material.dart';
import 'package:localize/notifier/runner.dart';
import 'package:localize/ui/image/rive_image.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  final bool noConnection;

  const SplashScreen({Key key, this.noConnection = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF313131),
        padding: const EdgeInsets.all(32.0),
        child: GestureDetector(
          onTap: () => noConnection ? context.read<NotifierRunner>().reset() : null,
          child: Column(
            children: [
              Expanded(child: RiveImage(path: 'assets/rive/logo.riv', animation: 'aby')),
              Text(noConnection ? "Connection error" : "", style: Theme.of(context).textTheme.headline2),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}
