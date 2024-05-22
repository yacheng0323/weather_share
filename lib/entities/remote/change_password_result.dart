class ChangePasswordResult {
  final bool isChanged;
  final String? errorMessage;

  ChangePasswordResult({
    required this.isChanged,
    this.errorMessage,
  });
}
