import 'package:extended_masked_text/extended_masked_text.dart';

class QuerySearchCreate {
  MaskedTextController search = MaskedTextController(mask: '00000000000');
  bool save;

  QuerySearchCreate(this.save);

  Map<String, String> toQueryParams() =>
      {'user': '33labs', 'client': search.unmasked};
}

class AidBrazil {
  String? cpfBeneficiario;
  String? cpfRresponsavel;
  String? enquadramento;
  String? ibge;
  DateTime? mes;
  String? nisBeneficiario;
  String? nisResponsavel;
  String? nomeBeneficiario;
  String? nomeMunicipio;
  String? nomeResponsavel;
  String? obs;
  String? parcela;
  String? uf;
  String? valorBeneficio;

  AidBrazil.fromJson(Map<String, dynamic> json) {
    cpfBeneficiario = json['CPFBENEFICIARIO'];
    cpfRresponsavel = json['CPFRESPONSAVEL'];
    enquadramento = json['ENQUADRAMENTO'];
    ibge = json['IBGE'];
    final month = json['MES'].toString();
    mes = DateTime(
        int.parse(month.substring(0, 4)), int.parse(month.substring(3, 6)));
    nisBeneficiario = json['NISBENEFICIARIO'];
    nisResponsavel = json['NISRESPONSAVEL'];
    nomeBeneficiario = json['NOMEBENEFICIARIO'];
    nomeMunicipio = json['NOMEMUNICIPIO'];
    nomeResponsavel = json['NOMERESPONSAVEL'];
    obs = json['OBSERVACAO'];
    parcela = json['PARCELA'];
    uf = json['UF'];
    valorBeneficio = json['VALORBENEFICIO'];
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
    if (aid.nomeBeneficiario != null) {
      name = aid.nomeBeneficiario!;
    }
    if (name == '-' && aid.nomeResponsavel != null) {
      name = aid.nomeResponsavel!;
    }
    if (aid.nisBeneficiario != null) {
      nis = aid.nisBeneficiario!;
    }
    if (nis == '-' && aid.nisResponsavel != null) {
      nis = aid.nisResponsavel!;
    }
    value = "R\$ ${aid.valorBeneficio!}";
    value = value.split('"').first;
    paymentDate = aid.mes!;
    locale = '${aid.nomeMunicipio}-${aid.uf}';
    message = aid.obs!;
    if (message.isEmpty) message = 'Nenhuma observação';
  }
}
