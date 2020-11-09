class TaskModel {
  final int id;
  final String desc;
  final bool done;

  TaskModel({this.id, this.desc, this.done});

  factory TaskModel.fromjson(Map<String, dynamic> json) => TaskModel(
        desc: json["desc"],
        done: json["done"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "desc": desc,
        "done": done,
      };
}
