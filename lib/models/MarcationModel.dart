import 'dart:convert';

MarcationModel marcationModelFromJson(String str) =>
    MarcationModel.fromJson(json.decode(str));

String marcationModelToJson(MarcationModel data) => json.encode(data.toJson());

class MarcationModel {
  String marcadoIdTelefono;
  String marcadoDni;
  String marcadoLatitud;
  String marcadoLongitud;
  String marcadoDataQr;
  String marcadoFechaHora;
  String marcadoTipo;
  String marcadoMotivo;
  double marcadoTemperatura;
  String marcadoTiempo;
  MarcationModel(
      {this.marcadoIdTelefono,
      this.marcadoDni,
      this.marcadoLatitud,
      this.marcadoLongitud,
      this.marcadoDataQr,
      this.marcadoFechaHora,
      this.marcadoTipo,
      this.marcadoMotivo,
      this.marcadoTemperatura,
      this.marcadoTiempo});

  factory MarcationModel.fromJson(Map<String, dynamic> json) => MarcationModel(
        marcadoIdTelefono: json["idTelefono"],
        marcadoDni: json["dni"],
        marcadoLatitud: json["latitud"],
        marcadoLongitud: json["longitud"],
        marcadoDataQr: json["dataQr"],
        marcadoFechaHora: json["fechahora"],
        marcadoTipo: json["tipo"],
        marcadoMotivo: json["motivo"],
        marcadoTemperatura: json["temperatura"].toDouble(),
        marcadoTiempo: json["tiempo"],
      );

  Map<String, dynamic> toJson() => {
        "idTelefono": marcadoIdTelefono,
        "dni": marcadoDni,
        "latitud": marcadoLatitud,
        "longitud": marcadoLongitud,
        "dataQr": marcadoDataQr,
        "fechahora": marcadoFechaHora,
        "tipo": marcadoTipo,
        "motivo": marcadoMotivo,
        "temperatura": marcadoTemperatura,
        "tiempo": marcadoTiempo
      };
}
