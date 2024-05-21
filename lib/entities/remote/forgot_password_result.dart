class ForgotPasswordResult {
  final bool isSuccess;
  final String? errorMessage;

  ForgotPasswordResult({
    required this.isSuccess,
    this.errorMessage,
  });
}
