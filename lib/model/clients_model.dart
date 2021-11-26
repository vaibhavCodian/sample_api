// To parse this JSON data, do
//
//     final clientModel = clientModelFromJson(jsonString);

import 'dart:convert';

ClientModel clientModelFromJson(String str) => ClientModel.fromJson(json.decode(str));

String clientModelToJson(ClientModel data) => json.encode(data.toJson());

class ClientModel {
  ClientModel({
    required this.clients,
  });

  List<Client> clients;

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
    clients: List<Client>.from(json["clients"].map((x) => Client.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "clients": List<dynamic>.from(clients.map((x) => x.toJson())),
  };
}

class Client {
  Client({
    required this.name,
    required this.id,
    required this.company,
    required this.orderId,
    required this.invoicepaid,
    required this.invoicePending,
  });

  String name;
  String id;
  String company;
  String orderId;
  String invoicepaid;
  String invoicePending;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    name: json["name"],
    id: json["id"],
    company: json["company"],
    orderId: json["orderId"],
    invoicepaid: json["invoicepaid"],
    invoicePending: json["invoicePending"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "company": company,
    "orderId": orderId,
    "invoicepaid": invoicepaid,
    "invoicePending": invoicePending,
  };
}
