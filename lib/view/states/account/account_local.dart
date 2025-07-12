class AccountLocal {
  final int id;
  final String emoji;
  final String name;
  final double balance;
  final String currency;

  AccountLocal._({
    required this.id,
    required this.emoji,
    required this.name,
    required this.balance,
    required this.currency,
  });

  factory AccountLocal.buildWith(
    int id,
    String name,
    double balance,
    String currency,
  ) => AccountLocal._(
    id: id,
    emoji: '💰',
    name: name,
    balance: balance,
    currency: currency,
  );
}
