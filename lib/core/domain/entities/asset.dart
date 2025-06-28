class Asset {
  final String id;
  final String locationId;
  final String name;
  final String? parentId;
  final String? sensorType;
  final String? status;

  Asset({
    required this.id,
    required this.locationId,
    required this.name,
    required this.parentId,
    required this.sensorType,
    required this.status,
  });

  factory Asset.fromMap(Map map) {
    return Asset(
      id: map['id'],
      locationId: map['locationId'],
      name: map['name'],
      parentId: map['parentId'],
      sensorType: map['sensorType'],
      status: map['status'],
    );
  }
}
