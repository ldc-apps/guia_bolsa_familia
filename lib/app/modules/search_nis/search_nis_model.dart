import 'package:aid_brazil/app/modules/search_nis/ui/search_nis_card_page.dart';
import 'package:aid_brazil/app/modules/search_nis/ui/search_nis_cpf_page.dart';
import 'package:aid_brazil/app/modules/search_nis/ui/search_nis_inss_page.dart';
import 'package:aid_brazil/app/modules/search_nis/ui/search_nis_phone_page.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';

class SearchNisItem {
  final String title;
  final String subtitle;
  final Widget widget;

  SearchNisItem(this.title, this.subtitle, this.widget);

  static List<SearchNisItem> itens(_) => [
        SearchNisItem(
          'Consultar pelo CPF',
          'Aprenda como consultar seu NIS através do seu CPF',
          const SearchNisCpfPage(),
        ),
        SearchNisItem(
          'Consultar pelo SITE MEU INSS',
          'Veja como saber seu NIS\npelo INSS',
          const SearchNisInssPage(),
        ),
        SearchNisItem(
          'Consultar pelo CARTÃO CIDADÃO',
          'Veja seu NIS pelo cartão cidadão.',
          const SearchNisCardPage(),
        ),
        SearchNisItem(
          'Consultar pelo TELEFONE',
          'Consulte seu NIS por ligação',
          const SearchNisPhonePage(),
        ),
      ];
}

class DoubtSearchNisItem {
  final String title;
  final String subtitle;

  DoubtSearchNisItem(this.title, this.subtitle);

  static List<DoubtSearchNisItem> itens(_) => [
        DoubtSearchNisItem(
          'PIS e NIS é a mesma coisa?',
          'Eles possuem a mesma numeração, mas possuem diferenças na forma que são gerados. O PIS é gerado no primeiro emprego para quem trabalha de carteira assinada. Já o NIS é gerado pelo CNIS (Cadastro Nacional de Informações Sociais).',
        ),
        DoubtSearchNisItem(
          'Qual jeito mais rápido de consultar PIS pelo CPF',
          'O meio mais fácil é através da consulta online, utilizando aplicativos, tais como: FGTS, Caixa Trabalhador, Carteira de Trabalho Digital, Meu INSS, dentre outros. Quem não possui acesso à internet pode consultar o PIS por meio do telefone do INSS, no número 135.',
        ),
        DoubtSearchNisItem(
          'Como faço para saber meu NIS?',
          'O número do PIS pode ser localizado em documentos físicos como carteira de trabalho e cartão cidadão. Também é possível que a consulta seja feita de diversas formas pelo número do CPF como, por exemplo, acessando os apps FGTS, carteira de trabalho digital, caixa trabalhador, dentre outros.',
        ),
        DoubtSearchNisItem(
          'Qual a diferença entre PIS e PASEP',
          'A diferença é que o PIS é para trabalhadores de empresas privadas e o PASEP é para Servidores públicos.',
        ),
      ];
}

class SearchNisStep {
  final int position;
  final String title;
  final String? url;

  SearchNisStep(this.position, this.title, {this.url});

  static List<SearchNisStep> get itensCPF => [
        SearchNisStep(1,
            'Acesse o site CNIS (Cadastro Nacional de Informações Sociais);'),
        SearchNisStep(2, 'Selecione a opção "Cidadão";',
            url:
                'https://ldcapps.com/wp-content/uploads/2022/11/consultar-nis-pelo-cpf-step-2.png'),
        SearchNisStep(3,
            'No canto superior direito, toque no “MENU”, após isso clique em “Inscrição”, e por fim clique em “Filiado”;',
            url:
                'https://ldcapps.com/wp-content/uploads/2022/11/consultar-nis-pelo-cpf-step-3.png'),
        SearchNisStep(4,
            'Preencha todos os campos solicitados, incluindo o número do CPF;',
            url:
                'https://ldcapps.com/wp-content/uploads/2022/11/consultar-nis-pelo-cpf-step-4.png'),
        SearchNisStep(
            5, 'Uma mensagem com a informação do seu número NIT/PIS aparecerá.',
            url:
                'https://ldcapps.com/wp-content/uploads/2022/11/consultar-nis-pelo-cpf-step-5.png'),
      ];

  static List<SearchNisStep> get itensNIS => [
        SearchNisStep(1, 'Acesse o site oficial Meu INSS;'),
        SearchNisStep(
          2,
          'Em seguida, entre com o seu login e senha;',
          url:
              'https://ldcapps.com/wp-content/uploads/2022/11/consultar-nis-pelo-site-meu-inss-step-2.png',
        ),
        SearchNisStep(
          3,
          'Caso não possua cadastro, clique em “Entrar” e preencha seus dados cadastrais;',
        ),
        SearchNisStep(
          4,
          'Após o preenchimento, autorize o uso dos seus dados pessoais;',
        ),
        SearchNisStep(
          5,
          'Confirme seus dados respondendo algumas perguntas feitas pelo sistema;',
        ),
        SearchNisStep(
          6,
          'Faça login novamente e acesse a opção “Meu Cadastro”, no canto superior esquerdo;',
          url:
              'https://ldcapps.com/wp-content/uploads/2022/11/consultar-nis-pelo-site-meu-inss-step-6.png',
        ),
        SearchNisStep(
          7,
          'E pronto! Nessa opção, você encontra os seus dados cadastrados, incluindo o número do NIS.',
          url:
              'https://ldcapps.com/wp-content/uploads/2022/11/consultar-nis-pelo-site-meu-inss-step-7.png',
        ),
      ];
}

class NisSearchCreate {
  MaskedTextController search = MaskedTextController(mask: '000.000.000-00');
  // mask: '00000000000'
  bool save;

  NisSearchCreate(this.save);

  Map<String, String> toQueryParams() =>
      {'user': '33labs', 'client': search.value.text};
}