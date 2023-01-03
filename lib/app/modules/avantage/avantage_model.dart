import 'dart:convert';

import 'package:aid_brazil/app/utils/global_resource.dart';

class Avantage {
  static List<Avantage> itens = [
    Avantage(
      title: 'Benefício Primeira Infância (BPI):',
      subtitle: empty,
      description:
          'Pago por criança, no valor de R\$ 130, para famílias que possuam em sua composição crianças com idade até 36 meses incompletos.',
    ),
    Avantage(
      title: 'Benefício Composição Familiar (BCF):',
      subtitle: empty,
      description:
          'Pago por pessoa, no valor de R\$ 65, para famílias que possuam em sua composição: a) gestantes; b) nutrizes; e/ou c) pessoas com idade entre 3 e 21 anos incompletos. A família apenas receberá esse benefício relativo aos seus integrantes com idade entre 18 e 21 anos incompletos se estiverem matriculados ou concluído a educação básica. Para as gestantes, o benefício será encerrado após a geração da 9ª parcela. Para a concessão do BCF às nutrizes, é preciso que a família atualize no Cadastro Único a informação do nascimento da nova criança antes de ela ter completado 7 meses de vida. O pagamento do benefício se encerra após a sexta parcela.',
    ),
    Avantage(
      title: 'Benefício de Superação da Extrema Pobreza (BSP):',
      subtitle: empty,
      description:
          'Valor calculado de forma que a renda per capita da família supere o valor da linha de extrema pobreza, fixada em R\$ 105 mensais por pessoa. No caso de a família receber BPI e/ou BCF, esses valores serão somados à renda familiar quando for calculado o valor do BSP da família. O valor mínimo pago a cada membro da família é de R\$ 25. Famílias unipessoais em situação de extrema pobreza também são elegíveis ao BSP.',
    ),
  ];
  static List<Avantage> itens2 = [
    Avantage(
      title: 'Bolsa de Iniciação Científica Júnior',
      subtitle: empty,
      description:
          'Concedido a estudantes, integrantes de famílias beneficiárias do Bolsa Família, que tenham se destacado em competições acadêmicas e científicas de abrangência nacional. Os valores são: 12 parcelas mensais de R\$ 100 para o estudante e parcela única de R\$ 1 mil por família.',
    ),
    Avantage(
      title: 'Esporte escolar',
      subtitle: empty,
      description:
          'Bolsa Família financeiro concedido a estudantes de 12 a 17 anos incompletos, integrantes de famílias beneficiárias do Programa Bolsa Família, que se destaquem nos Jogos Escolares Brasileiros. O valor do benefício é de 12 parcelas mensais de R\$ 100 para o estudante e parcela única de R\$ 1 mil por família.',
    ),
    Avantage(
      title: 'Inclusão Produtiva Rural',
      subtitle: empty,
      description:
          'Benefício pago em parcelas mensais de R\$ 200 a famílias atendidas pelo Programa Bolsa Família que possuam em sua composição agricultores familiares. A comprovação de enquadramento como agricultor familiar ocorrerá pela Declaração de Aptidão ao Programa Nacional de Fortalecimento da Agricultura Familiar. Não é permitido o pagamento de mais de um Bolsa Família por pessoa e por família.',
    ),
    Avantage(
      title: 'Inclusão Produtiva Urbana',
      subtitle: empty,
      description:
          'Benefício de R\$ 200 por mês pago a beneficiários do Bolsa Família que comprovarem vínculo de emprego com carteira assinada. O recebimento é limitado a um Bolsa Família por família ou por pessoa.',
    ),
    Avantage(
      title: 'Benefício Compensatório de Transição (BComp)',
      subtitle: empty,
      description:
          'É um valor complementado na parcela mensal do Bolsa Família, pago no limite de um benefício por família e concedido de forma automática, apenas para famílias que tiveram perdas financeiras na transição entre o Bolsa Família para o Bolsa Família. Após concedido, será mantido nos meses de pagamentos seguintes até que o valor recebido pela sua família no Bolsa Família seja igual ao valor recebido no Bolsa Família, ou até que sua família não se enquadre mais nos critérios de elegibilidade.',
    ),
  ];
  final String title;

  final String subtitle;

  final String description;

  Avantage({
    required this.title,
    required this.subtitle,
    required this.description,
  });

  factory Avantage.fromJson(String source) =>
      Avantage.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Avantage.fromMap(Map<String, dynamic> map) {
    return Avantage(
      title: map['title'] as String,
      subtitle: map['subtitle'] as String,
      description: map['description'] as String,
    );
  }
}
