class AuthorizeTransactionAction {
  final String authorizationContent;

  AuthorizeTransactionAction(this.authorizationContent);

  Map<String, dynamic> toJson() =>
      {'authorizationContent': authorizationContent};
}

class QueryProvisionStateAction {}

class IsProvisionedAction {
  final bool isProvisioned;

  IsProvisionedAction(this.isProvisioned);
}

class ProvisionAction {
  final String name;
  final String email;
  final String track2;
  final String issuerId;
  final String documentId;
  final String phoneNumber;
  final String derivationKey;

  ProvisionAction(this.name, this.email, this.track2, this.issuerId,
      this.documentId, this.phoneNumber, this.derivationKey);

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'track2': track2,
        'issuerId': issuerId,
        'documentId': documentId,
        'phoneNumber': phoneNumber,
        'derivationKey': derivationKey
      };
}
