class RecentCh {
  int _time;
  String _message;
  bool _read;

  RecentCh(this._time, this._message, this._read);

  bool get read => _read;

  String get message => _message;

  int get time => _time;
}
