import 'dart:async';

class BandwidthBuffer<T> {
  final Duration duration;
  final void Function(List<T>) onReceive;

  late List<T> _list = <T>[];
  late Timer? _timer;

  BandwidthBuffer({required this.duration, required this.onReceive});

  void start() {
    _timer = Timer.periodic(duration, _onTimeToSend);
  }

  void stop() {
    _timer!.cancel();
    _timer = null;
  }

  void send(T t) {
    _list.add(t);
  }

  void _onTimeToSend(Timer t) {
    if (_list.isNotEmpty) {
      var list = _list;
      _list = <T>[];
      onReceive(list);
    }
  }
}
