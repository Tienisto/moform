import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
mixin FirstFrameCallback<T extends StatefulWidget> on State<T> {
  bool _firstFrame = true;

  /// Calls the [callback] ONLY on the first frame **after** [initState].
  /// Should be called inside the [build] method.
  void onFirstFrame(void Function() callback) {
    if (_firstFrame) {
      callback();
      _firstFrame = false;
    }
  }
}
