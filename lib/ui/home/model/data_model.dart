class DataModel {
  String? name;
  String? phone;
  bool? isDeleted;
  String? key;

  DataModel({this.name, this.phone, this.isDeleted, this.key});

  toJson() {
    return {"name": name, "phone": phone, "isDeleted": isDeleted};
  }

  factory DataModel.fromSnapshot({data, id}) {
    return DataModel(
        name: data["name"] ?? "",
        phone: data["phone"] ?? "",
        isDeleted: data["isDeleted"] ?? false,
        key: id);
  }
}
