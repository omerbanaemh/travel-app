class GovernorateModel {
  final int id;
  final String governorateName;
  final String image;
  final String description;
  final String? location;
  final String? administrativeDivision;
  final String? historyAndCulture;
  final String? economy;
  final String? traditionalDress;
  final String? traditionalDressImage;

  GovernorateModel({
    required this.id,
    required this.governorateName,
    required this.image,
    required this.description,
    this.location,
    this.administrativeDivision,
    this.historyAndCulture,
    this.economy,
    this.traditionalDress,
    this.traditionalDressImage,
  });

  factory GovernorateModel.fromJson(Map<String, dynamic> json) {
    return GovernorateModel(
      id: json['id'],
      governorateName: json['governorate_name'],
      image: json['image'],
      description: json['description'],
      location: json['location'],
      administrativeDivision: json['administrative_division'],
      historyAndCulture: json['history_and_culture'],
      economy: json['economy'],
      traditionalDress: json['traditional_dress'],
      traditionalDressImage: json['traditional_dress_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'governorate_name': governorateName,
      'image': image,
      'description': description,
      'location': location,
      'administrative_division': administrativeDivision,
      'history_and_culture': historyAndCulture,
      'economy': economy,
      'traditional_dress': traditionalDress,
      'traditional_dress_image': traditionalDressImage,
    };
  }
}