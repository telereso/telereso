import 'package:flutter/cupertino.dart';
import 'package:telereso/telereso.dart';

/// State to be used if you like to catch realtime changes ,
/// Recommended in Development mode and on the main home page only
abstract class RemoteState<T extends StatefulWidget> extends State<T> {
  Function _remoteChangeListener = () {};

  @override
  void initState() {
    _remoteChangeListener = () {
      Future.delayed(Duration(milliseconds: 10), () {
        setState(() {});
      });
    };
    Telereso.instance.addRemoteChangeListener(_remoteChangeListener);
    super.initState();
  }

  @override
  void dispose() {
    Telereso.instance.removeRemoteChangeListener(_remoteChangeListener);
    super.dispose();
  }
}
