abstract class ModelConnector<T> {
  T get value;

  set value(T value);

  factory ModelConnector.from({
    required T Function() get,
    required void Function(T) set,
  }) => DefaultModelConnector<T>(
    get: get,
    set: set,
  );
}

class DefaultModelConnector<T> implements ModelConnector<T> {
  final T Function() _get;
  final void Function(T) _set;

  DefaultModelConnector({
    required T Function() get,
    required void Function(T) set,
  })  : _get = get,
        _set = set;

  @override
  T get value => _get();

  @override
  set value(T value) => _set(value);
}
