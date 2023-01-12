import 'package:flutter/cupertino.dart';

class QuerySearchCreate {
  TextEditingController search = TextEditingController();
  // mask: '00000000000'
  bool save;

  QuerySearchCreate(this.save);

  Map<String, String> toQueryParams() =>
      {'user': '33labs', 'client': search.value.text};
}

class AidBrazil {
  int? id;
  DateTime? mesDisponibilizacao;
  Beneficiario? beneficiario;
  Beneficiario? responsavelAuxilioEmergencial;
  Municipio? municipio;
  String? situacaoAuxilioEmergencial;
  String? enquadramentoAuxilioEmergencial;
  double? valor;
  String? numeroParcela;

  AidBrazil(
      {this.id,
      this.mesDisponibilizacao,
      this.beneficiario,
      this.responsavelAuxilioEmergencial,
      this.municipio,
      this.situacaoAuxilioEmergencial,
      this.enquadramentoAuxilioEmergencial,
      this.valor,
      this.numeroParcela});

  AidBrazil.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    final numbersFromDates = json['mesDisponibilizacao'].toString().split('/');
    mesDisponibilizacao = DateTime(
        int.parse(numbersFromDates.last), int.parse(numbersFromDates.first));
    beneficiario = json['beneficiario'] != null
        ? Beneficiario.fromJson(json['beneficiario'])
        : null;
    responsavelAuxilioEmergencial =
        json['responsavelAuxilioEmergencial'] != null
            ? Beneficiario.fromJson(json['responsavelAuxilioEmergencial'])
            : null;
    municipio = json['municipio'] != null
        ? Municipio.fromJson(json['municipio'])
        : null;
    situacaoAuxilioEmergencial = json['situacaoAuxilioEmergencial'];
    enquadramentoAuxilioEmergencial = json['enquadramentoAuxilioEmergencial'];
    valor = json['valor'];
    numeroParcela = json['numeroParcela'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['mesDisponibilizacao'] = mesDisponibilizacao;
    if (beneficiario != null) {
      data['beneficiario'] = beneficiario!.toJson();
    }
    if (responsavelAuxilioEmergencial != null) {
      data['responsavelAuxilioEmergencial'] =
          responsavelAuxilioEmergencial!.toJson();
    }
    if (municipio != null) {
      data['municipio'] = municipio!.toJson();
    }
    data['situacaoAuxilioEmergencial'] = situacaoAuxilioEmergencial;
    data['enquadramentoAuxilioEmergencial'] = enquadramentoAuxilioEmergencial;
    data['valor'] = valor;
    data['numeroParcela'] = numeroParcela;
    return data;
  }
}

class Beneficiario {
  String? cpfFormatado;
  String? nis;
  String? nome;

  Beneficiario({this.cpfFormatado, this.nis, this.nome});

  Beneficiario.fromJson(Map<String, dynamic> json) {
    cpfFormatado = json['cpfFormatado'];
    nis = json['nis'];
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cpfFormatado'] = cpfFormatado;
    data['nis'] = nis;
    data['nome'] = nome;
    return data;
  }
}

class Municipio {
  String? codigoIBGE;
  String? nomeIBGE;
  String? codigoRegiao;
  String? nomeRegiao;
  String? pais;
  Uf? uf;

  Municipio(
      {this.codigoIBGE,
      this.nomeIBGE,
      this.codigoRegiao,
      this.nomeRegiao,
      this.pais,
      this.uf});

  Municipio.fromJson(Map<String, dynamic> json) {
    codigoIBGE = json['codigoIBGE'];
    nomeIBGE = json['nomeIBGE'];
    codigoRegiao = json['codigoRegiao'];
    nomeRegiao = json['nomeRegiao'];
    pais = json['pais'];
    uf = json['uf'] != null ? Uf.fromJson(json['uf']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['codigoIBGE'] = codigoIBGE;
    data['nomeIBGE'] = nomeIBGE;
    data['codigoRegiao'] = codigoRegiao;
    data['nomeRegiao'] = nomeRegiao;
    data['pais'] = pais;
    if (uf != null) {
      data['uf'] = uf!.toJson();
    }
    return data;
  }
}

class Uf {
  String? sigla;
  String? nome;

  Uf({this.sigla, this.nome});

  Uf.fromJson(Map<String, dynamic> json) {
    sigla = json['sigla'];
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sigla'] = sigla;
    data['nome'] = nome;
    return data;
  }
}

class QueryResult {
  String name = 'Indisponível';
  String nis = '-';
  late String value = 'Indisponível';
  late DateTime paymentDate;
  late String locale = 'Não encontrada';
  late String message = 'Nenhuma observação';

  QueryResult.fromAid(AidBrazil aid) {
    if (aid.beneficiario?.nome != null) {
      name = aid.beneficiario!.nome!;
    }
    if (name == '-' && aid.responsavelAuxilioEmergencial?.nome != null) {
      name = aid.responsavelAuxilioEmergencial!.nome!;
    }
    if (aid.beneficiario?.nis != null) {
      nis = aid.beneficiario!.nis!;
    }
    if (nis == '-' && aid.responsavelAuxilioEmergencial?.nis != null) {
      nis = aid.responsavelAuxilioEmergencial!.nis!;
    }
    value = "R\$ ${aid.valor!}";
    paymentDate = aid.mesDisponibilizacao!;
    locale = '${aid.municipio!.nomeIBGE}-${aid.municipio!.uf!.nome}';
    message = aid.situacaoAuxilioEmergencial!;
    if (message.isEmpty) message = 'Nenhuma observação';
  }
}
