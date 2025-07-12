class CategoryLocal {
  final int id;
  final String name;
  final String emoji;

  CategoryLocal._({required this.id, required this.name, required this.emoji});

  factory CategoryLocal.buildWith(int id, String name, String emoji) =>
      CategoryLocal._(id: id, name: name, emoji: emoji);
}
