import 'package:flutter/cupertino.dart';
import 'package:telereso/telereso.dart';

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
