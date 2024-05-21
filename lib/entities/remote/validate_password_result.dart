class ValidatePasswordResult {
  final bool isValidate;
  final String? errorMessage;

  ValidatePasswordResult({
    required this.isValidate,
    this.errorMessage,
  });
}
