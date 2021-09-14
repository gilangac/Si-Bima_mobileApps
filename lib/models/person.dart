import 'package:si_bima/models/jail.dart';

class Person {
  int id;
  String name;
  int idJail;
  String? personCase;
  int idPk;
  int idType;
  String? dateDisposition;
  int numberTpp;
  String? dateTpp;
  String? dateSend;
  String? dateStart;
  String? dateEnd;
  String? status;
  String? description;
  String? createdAt;
  String? updatedAt;
  Jail jail;
  Jail type;
  Jail pk;

  Person({
    required this.id,
    required this.name,
    required this.idJail,
    this.personCase,
    required this.idPk,
    required this.idType,
    this.dateDisposition,
    required this.numberTpp,
    this.dateTpp,
    this.dateSend,
    this.dateStart,
    this.dateEnd,
    this.status,
    this.description,
    this.createdAt,
    this.updatedAt,
    required this.jail,
    required this.type,
    required this.pk,
  });

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        id: json["id"],
        name: json["name"],
        idJail: json["idJail"],
        personCase: json["case"],
        idPk: json["idPk"],
        idType: json["idType"],
        dateDisposition: json["date_disposition"],
        numberTpp: json["number_tpp"],
        dateTpp: json["date_tpp"],
        dateSend: json["date_send"],
        dateStart: json["date_start"],
        dateEnd: json["date_end"],
        status: json["status"],
        description: json["description"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        jail: Jail.fromJson(json["jail"]),
        type: Jail.fromJson(json["type"]),
        pk: Jail.fromJson(json["pk"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "idJail": idJail,
        "case": personCase,
        "idPk": idPk,
        "idType": idType,
        "date_disposition": dateDisposition,
        "number_tpp": numberTpp,
        "date_tpp": dateTpp,
        "date_send": dateSend,
        "date_start": dateStart,
        "date_end": dateEnd,
        "status": status,
        "description": description,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "jail": jail.toJson(),
        "type": type.toJson(),
        "pk": pk.toJson(),
      };
}
