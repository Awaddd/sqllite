class Cat {
  final int id;
  final String name;

  const Cat({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'Cat{id: $id, name: $name}';
  }
}
