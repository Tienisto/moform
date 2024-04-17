import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

@internal
mixin FirstFrameCallback<T extends StatefulWidget> on State<T> {
  bool _firstFrame = true;

  /// Calls the [callback] ONLY the first frame AFTER [initState].
  /// Should be called in [build] method.
  void onFirstFrame(void Function() callback) {
    if (_firstFrame) {
      callback();
      _firstFrame = false;
    }
  }
}
