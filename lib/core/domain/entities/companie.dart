class Companie {
  final String id;
  final String name;

  Companie({required this.id, required this.name});

  factory Companie.fromMap(Map map) {
    return Companie(id: map['id'], name: map['name']);
  }
}
