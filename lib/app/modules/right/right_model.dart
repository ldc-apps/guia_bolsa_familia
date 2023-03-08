import 'dart:convert';

import '../../utils/global_resource.dart';

class Right {
  static List<String> topics = [
    '''
    Têm direito ao Bolsa Família as famílias em situação de pobreza (renda por pessoa de até R\$ 218 por mês) e extrema pobreza (renda por pessoa de até R\$ 105 por mês), que tiverem em sua composição gestantes ou pessoas com idade de até 21 anos incompletos, e que já fazem parte do Bolsa Família ou do Cadastro Único. O benefício chega hoje a 23% dos lares brasileiros.
    ''',
    '''
    Todas as famílias que já eram atendidas pelo Bolsa Família foram automaticamente migradas para o Bolsa Família. Já as famílias inscritas no Cadastro Único, e que não faziam parte do Bolsa Família, entrarão em uma lista de reserva, por enquanto.
    ''',
    '''
    Novas inscrições podem ser realizadas no Centro de Referência da Assistência Social (CRAs) mais próximo de você, mas sem uma garantia de aprovação.
    ''',
  ];
  static List<Right> itens = [
    Right(
      title: 'Famílias com crianças de 0 a 36 meses incompletos',
      subtitle: empty,
      description: empty,
    ),
    Right(
      title: 'Famílias com gestantes ou com integrantes de três a 21 anos incompletos.',
      subtitle: 'Integrantes de 18 a 21 anos precisam estar matriculados no ensino básico.',
      description: empty,
    ),
    Right(
      title: 'Renda per capita mensal.',
      subtitle:
          'Renda familiar mensal calculada após o acréscimo dos benefícios financeiros anteriores, igual ou inferior ao valor da linha de extrema pobreza',
      description: empty,
    ),
    Right(
      title: 'Jogos Escolares Brasileiros',
      subtitle:
          'Estudantes (entre 12 e 18 anos incompletos) de famílias beneficiárias do Bolsa Família que se destacarem nos Jogos Escolares Brasileiros',
      description: empty,
    ),
    Right(
      title: 'Competições acadêmicas e científicas nacionais',
      subtitle:
          'Estudantes de famílias beneficiárias do Bolsa Família que se destacarem em competições acadêmicas e científicas nacionais',
      description: empty,
    ),
    Right(
      title: 'Vagas indisponível em creches',
      subtitle:
          'Responsável de família beneficiária do Bolsa Família, com criança de 0 a 48 meses incompletos, que tenha conseguido fonte de renda mas não encontre vaga em creches públicas ou privadas conveniadas',
      description: empty,
    ),
    Right(
      title: 'Agricultores familiares inscritos no Cadastro Único',
      subtitle: empty,
      description: empty,
    ),
    Right(
      title: 'Emprego formal',
      subtitle: 'Beneficiários do Programa Bolsa Família que comprovarem vínculo de emprego formal',
      description: empty,
    ),
    Right(
      title: 'Redução no valor do Bolsa Família',
      subtitle:
          'Famílias beneficiárias do Bolsa Família que tiverem redução no valor recebido após o enquadramento no Bolsa Família',
      description: empty,
    ),
  ];
  final String title;

  final String subtitle;

  final String description;

  Right({
    required this.title,
    required this.subtitle,
    required this.description,
  });

  factory Right.fromJson(String source) =>
      Right.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Right.fromMap(Map<String, dynamic> map) {
    return Right(
      title: map['title'] as String,
      subtitle: map['subtitle'] as String,
      description: map['description'] as String,
    );
  }
}
