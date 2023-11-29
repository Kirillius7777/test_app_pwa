class MenuData {
  int? id;
  String? description;
  List<String>? image;
  List<String>? color;
  List<String>? size;
  int? bonus;

  MenuData(
      {this.id,
      this.description,
      this.image,
      this.color,
      this.size,
      this.bonus});

  MenuData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    image = json['image'].cast<String>();
    color = json["color"].cast<String>();
    size = json['size'].cast<String>();
    bonus = json['bonus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['image'] = this.image;
    data['color'] = this.color;
    data['size'] = this.size;
    data['bonus'] = this.bonus;
    return data;
  }
}
