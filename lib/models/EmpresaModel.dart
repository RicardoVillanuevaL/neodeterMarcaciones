import 'dart:convert';

EmpresaModel empresaModelFromJson(String str) => EmpresaModel.fromJson(json.decode(str));

String empresaModelToJson(EmpresaModel data) => json.encode(data.toJson());

class EmpresaModel {
    EmpresaModel({
        this.empresaRuc,
        this.empresaRazonSocial,
    });

    String empresaRuc;
    String empresaRazonSocial;

    factory EmpresaModel.fromJson(Map<String, dynamic> json) => EmpresaModel(
        empresaRuc: json["empresa_ruc"],
        empresaRazonSocial: json["empresa_razonSocial"],
    );

    Map<String, dynamic> toJson() => {
        "empresa_ruc": empresaRuc,
        "empresa_razonSocial": empresaRazonSocial,
    };
}
