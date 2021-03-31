class CanPassAccount {
  CanPassAccount({
    this.id,
    this.name,
    this.email,
    this.path,
    this.resourceUrl,
    this.canAccounts,
  });

  final String id;
  final String name;
  final String email;
  final String path;
  final String resourceUrl;
  final List<String> canAccounts;

  CanPassAccount copyWith({
    String id,
    String name,
    String email,
    String path,
    String resourceUrl,
    List<String> canAccounts,
  }) =>
      CanPassAccount(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        path: path ?? this.path,
        resourceUrl: resourceUrl ?? this.resourceUrl,
        canAccounts: canAccounts ?? this.canAccounts,
      );

  factory CanPassAccount.fromJson(Map<String, dynamic> json) => CanPassAccount(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    path: json["path"],
    resourceUrl: json["resourceUrl"],
    canAccounts: List<String>.from(json["canAccounts"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "path": path,
    "resourceUrl": resourceUrl,
    "canAccounts": List<dynamic>.from(canAccounts.map((x) => x)),
  };
}
