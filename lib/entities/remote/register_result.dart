class RegisteredResult {
  final String? uid;
  final bool isRegistered;
  final String? errorMessage;

  RegisteredResult({
    this.uid,
    required this.isRegistered,
    this.errorMessage,
  });
}
