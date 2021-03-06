import 'package:flutter/foundation.dart';

class NotificationPending with ChangeNotifier, DiagnosticableTreeMixin {
  bool _pending = false;

  bool get pending => this._pending;

  void togglePending(bool change) {
    _pending = change;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('pending', value: _pending));
  }
}
