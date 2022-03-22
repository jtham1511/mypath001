import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/lat_lng.dart';

class FFAppState {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _togglefav = prefs
            .getStringList('ff_togglefav')
            ?.map((x) => x == 'true')
            ?.toList() ??
        _togglefav;
  }

  SharedPreferences prefs;

  List<bool> _togglefav = [];
  List<bool> get togglefav => _togglefav;
  set togglefav(List<bool> _value) {
    _togglefav = _value;
    prefs.setStringList(
        'ff_togglefav', _value.map((x) => x.toString()).toList());
  }

  void addToTogglefav(bool _value) {
    _togglefav.add(_value);
    prefs.setStringList(
        'ff_togglefav', _togglefav.map((x) => x.toString()).toList());
  }

  void removeFromTogglefav(bool _value) {
    _togglefav.remove(_value);
    prefs.setStringList(
        'ff_togglefav', _togglefav.map((x) => x.toString()).toList());
  }

  List<String> searchfield = [];
}

LatLng _latLngFromString(String val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}
