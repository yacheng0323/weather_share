class DeleteArticleResult {
  final bool isSuccess;
  final String? errorMessage;

  DeleteArticleResult({
    required this.isSuccess,
    this.errorMessage,
  });
}
