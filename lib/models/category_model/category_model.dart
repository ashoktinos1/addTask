class CategoryModel {
  String? name;
  String? id;
  String? image;
  String? description;
  CategoryModel({this.description, this.id, this.image, this.name});
  factory CategoryModel.fromjson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json["name"],
      id: json["id"],
      description: json["description"],
      image: json["image"],
    );
  }

  Map<String, dynamic> tojson() {
    return {
      "name": name,
      "id": id,
      "description": description,
      "image": image,
    };
  }
}
