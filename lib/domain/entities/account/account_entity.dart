class AccountEntity {
  final int id;
  final int userId;
  final String name;
  final String balance;
  final String currency;
  final String createdAt;
  final String updatedAt;

  AccountEntity({
    required this.id,
    required this.userId,
    required this.name,
    required this.balance,
    required this.currency,
    required this.createdAt,
    required this.updatedAt,
  });
}
