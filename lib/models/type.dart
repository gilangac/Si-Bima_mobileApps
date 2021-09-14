class Type{
   int id;
    String name;
    String? createdAt;
    String? updatedAt;

     Type({
        required this.id,
        required this.name,
        this.createdAt,
        this.updatedAt,
    });

     factory Type.fromJson(Map<String, dynamic> json) => Type(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}