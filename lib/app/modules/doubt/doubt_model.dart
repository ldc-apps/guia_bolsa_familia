import 'dart:convert';

class Doubt {
  static List<Doubt> itens = [
    Doubt(
      title: 'O que é?',
      description:
          'Trata-se de um Bolsa Família que tem como propósito atender às famílias brasileiras que passam por situação de pobreza e extrema pobreza em território nacional, a fim de que superem sua vulnerabilidade social e econômica',
    ),
    Doubt(
        title: 'Qual é o valor pago pelo programa?',
        description:
            'O valor pode variar, a depender da situação socioeconômica informada no Cadastro Único, isto é, o cadastro que informa todos os dados das famílias em situação de pobreza e extrema pobreza.'),
    Doubt(
        title: 'Quem pode ter direito ao benefício?',
        description:
            'Podem ter direito ao valor aquelas famílias cuja situação seja de pobreza ou extrema pobreza'),
    Doubt(
        title: 'Qual é a renda exigida para que você receba o benefício?',
        description:
            'No caso das famílias em extrema pobreza, a renda per capita deve ser inferior ou igual a R \$105,00. Já no caso das famílias que se encontram em situação de pobreza, o valor per capita precisa estar entre R\$100,01 a R\$218,00'),
    Doubt(
      title: 'Como saber se fui selecionado para receber o benefício?',
      description:
          'As pessoas que já estavam incluídas no programa Bolsa Família receberão automaticamente este novo benefício. Se for o caso de a família ainda não ser beneficiária, a CAIXA comunicará via correspondência. Ademais, é possível saber pelo telefone 111 e pelos aplicativos Bolsa Família CAIXA e CAIXA Tem.',
    ),
    Doubt(
      title: 'Em quais locais é possível fazer o cadastro?',
      description: 'Procure o CRAS mais próximo de você para fazer seu cadastro no CadÚnico',
    ),
    Doubt(
      title: 'Quais requisitos são exigidos para fazer o cadastro no programa?',
      description:
          'É necessário estar inscrito no CadÚnico e ter todos os dados atualizados há menos de dois anos. Além disso, é preciso estar inserido nos critérios relativos à renda exigidos pelo programa',
    ),
    Doubt(
      title: 'Existem outros tipos de benefícios que podem ser adicionados ao novo programa?',
      description:
          'Sim. São eles: Bolsa Família Esporte Escolar, Bolsa Família Criança Cidadã, Bolsa de Iniciação Científica Júnior, Bolsa Família Inclusão Produtiva Rural, Bolsa Família Inclusão Produtiva Urbana e Benefício Compensatório de Transição',
    ),
    Doubt(
      title: 'De que forma o pagamento do Bolsa Família é realizado?',
      description:
          'Por meio do saque com o devido cartão e também por intermédio das poupanças Social Digital e CAIXA Fácil',
    ),
    Doubt(
      title: 'O cartão antigo do Bolsa Família serve para este novo Bolsa Família?',
      description: 'Sim, é possível receber por meio do cartão do antigo programa Bolsa Família',
    ),
    Doubt(
      title: 'Como descobrir se minha parcela já está disponível para saque?',
      description:
          'Consulte pelos aplicativos CAIXA Tem, Bolsa Família ou também ligando para o número 111.',
    ),
    Doubt(
      title: 'Onde é possível fazer os saques do Bolsa Família?',
      description:
          'Terminais de autoatendimento CAIXA, nas unidades correspondentes CAIXA Aqui ou em lotéricas.',
    ),
    Doubt(
      title: 'De que forma posso cadastrar a senha do cartão do benefício? E recadastrar? ',
      description:
          'Você deve ligar para o número de atendimento 111. Ao ligar, é necessário ter o seu cartão do Programa, NIS, carteira de identidade e CPF. Tanto o cadastramento quanto o recadastramento podem ser feitos também em uma Agência da CAIXA',
    )
  ];
  final String title;

  final String description;

  Doubt({
    required this.title,
    required this.description,
  });

  factory Doubt.fromJson(String source) =>
      Doubt.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Doubt.fromMap(Map<String, dynamic> map) {
    return Doubt(
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }
}
