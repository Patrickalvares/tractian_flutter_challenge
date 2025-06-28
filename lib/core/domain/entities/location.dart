class Location {
  final String id;
  final String name;
  final String? parentId;

  Location({required this.id, required this.name, required this.parentId});

  factory Location.fromMap(Map map) {
    return Location(id: map['id'], name: map['name'], parentId: map['parentId']);
  }
}
