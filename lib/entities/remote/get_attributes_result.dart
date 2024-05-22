class GetAttributesResult<T> {
  final T? data;
  final String? error;

  GetAttributesResult({this.data, this.error});

  bool get isSuccess => data != null && error == null;
  bool get isError => error != null;
}
