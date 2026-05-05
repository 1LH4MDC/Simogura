class KolamModel {
  final String? id;
  final String? lokasi;
  final int? createdBy;
  final DateTime? createdAt;

  KolamModel({
    this.id,
    this.lokasi,
    this.createdBy,
    this.createdAt,
  });

  factory KolamModel.fromJson(Map<String, dynamic> json) {
    return KolamModel(
      id: json['id'],
      lokasi: json['lokasi'],
      createdBy: json['created_by'],
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lokasi': lokasi,
      'created_by': createdBy,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
