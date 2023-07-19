class Dog {
  final int id;
  final String name;

  Dog({required this.id, required this.name});

  factory Dog.fromLocalDatabase(Map<String, dynamic> map) {
    return Dog(
      id: (map['id'] ?? 0) as int,
      name: (map['name'] ?? '') as String,
    );
  }
}
