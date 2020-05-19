class AuthorizeTransactionAction {
  final String authorizationContent;

  AuthorizeTransactionAction(this.authorizationContent);

  Map<String, dynamic> toJson() =>
      {'authorizationContent': authorizationContent};
}

class ProvisionAction {
  Map<String, dynamic> toJson() => {};
}
