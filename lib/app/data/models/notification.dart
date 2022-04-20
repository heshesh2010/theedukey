class Notification {
  int? id;
  String? target;
  int? targetId;
  String? title;
  String? text;
  int? status;
  String? createdAt;
  String? updatedAt;

  Notification(
      {this.id,
        this.target,
        this.targetId,
        this.title,
        this.text,
        this.status,
        this.createdAt,
        this.updatedAt});

  factory Notification.fromMap(Map<String, dynamic> json) => Notification(
    id: json["id"],
    target: json["target"],
    targetId: json["target_id"],
    title: json["title"],
    text: json["text"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "target": target,
    "target_id": targetId,
    "title": title,
    "text": text,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

