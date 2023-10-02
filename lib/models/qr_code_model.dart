import 'dart:convert';
import 'dart:typed_data';
import 'package:get_storage/get_storage.dart';
import 'package:collection/collection.dart';

class QrCodeModel {
  String? codeData;
  String? color;
  String? id;
  String? ssid;
  String? encryption;
  String? password;
  Uint8List? qrImage;
  int? createdOn;

  QrCodeModel({
    this.ssid,
    this.password,
    this.codeData,
    this.encryption,
    this.id,
    this.qrImage,
    this.createdOn,
    this.color,
  });

  factory QrCodeModel.fromMap(Map<String, dynamic> data) => QrCodeModel(
        codeData: data['code_data'],
        id: data['id'],
        color: data['color'],
        ssid: data['ssid'],
        password: data['password'],
        encryption: data['encryption'],
        createdOn: data['createdOn'],
        qrImage: data['qrImage'] != null ? base64Decode(data['qrImage']) : null,
      );

  Map<String, dynamic> toMap() => {
        'code_data': codeData,
        'id': id,
        'color': color,
        'ssid': ssid,
        'password': password,
        'encryption': encryption,
        'createdOn': createdOn,
        'qrImage': qrImage != null ? base64Encode(qrImage!) : null,
      };

  factory QrCodeModel.fromJson(String data) {
    return QrCodeModel.fromMap(json.decode(data));
  }

  String toJson() {
    return json.encode(toMap());
  }

  QrCodeModel copyWith({
    String? codeData,
    String? id,
    String? color,
    String? ssid,
    String? encryption,
    String? password,
    Uint8List? qrImage,
    int? createdOn,
  }) {
    return QrCodeModel(
      codeData: codeData ?? this.codeData,
      ssid: ssid ?? this.ssid,
      password: password ?? this.password,
      id: id ?? this.id,
      encryption: encryption ?? this.encryption,
      color: color ?? this.color,
      createdOn: createdOn ?? this.createdOn,
      qrImage: qrImage ?? this.qrImage,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! QrCodeModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      codeData.hashCode ^
      id.hashCode ^
      createdOn.hashCode ^
      ssid.hashCode ^
      password.hashCode ^
      encryption.hashCode ^
      qrImage.hashCode ^
      color.hashCode;
}
