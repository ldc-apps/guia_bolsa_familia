import 'package:flutter/material.dart';

import 'ui/how_register_aprovacao_page.dart';
import 'ui/how_register_cadunico_page.dart';
import 'ui/how_register_doc_page.dart';
import 'ui/how_register_receive_page.dart';
import 'ui/how_register_right_page.dart';

class DoubtHowRegisterItem {
  final String title;
  final String subtitle;

  DoubtHowRegisterItem(this.title, this.subtitle);

  static List<DoubtHowRegisterItem> itens(_) => [
        DoubtHowRegisterItem(
          'É possível se cadastrar no Bolsa Família pela Internet?',
          'O Responsável Familiar pode fazer o pré-cadastro da família por meio do celular e tem até 120 dias para ir à unidade do CRAS fazer a entrega dos documentos e passar por uma entrevista social. O Responsável Familiar pode fazer o pré-cadastro da família por meio do celular e tem até 120 dias para ir à unidade do CRAS fazer a entrega dos documentos e passar por uma entrevista social.',
        ),
        DoubtHowRegisterItem(
          'O que é necessário para se inscrever no Bolsa Família?',
          'É preciso que todos os membros da família estejam inscritos no CadÚnico e mantenham as informações atualizadas a cada dois anos. O titular deve comparecer ao CRAS levando seu CPF, o Título de eleitor e comprovante de residência e ainda levar uma cópia de cada documento para cada membro da família.',
        ),
        DoubtHowRegisterItem(
          'Como saber se eu tenho direito ao Bolsa Família?',
          'Além de estarem enquadradas na situação de pobreza e extrema pobreza, é preciso que as famílias tenham gestantes, mães que amamentam ou pessoas de 0 a 21 anos incompletos (crianças, adolescentes e jovens adultos).',
        ),
        DoubtHowRegisterItem(
          'O que é o Cadastro Único?',
          'O Cadastro Único do Governo Federal, mais conhecido como CadÚnico, é o principal registro das famílias brasileiras de baixa renda e é muito importante para quem deseja receber benefícios e participar dos programas sociais disponibilizados.',
        ),
      ];

  static List<DoubtHowRegisterItem> itensRights(_) => [
        DoubtHowRegisterItem(
          'O que são famílias em situação de extrema pobreza?',
          'São famílias com renda familiar mensal por pessoa de até R\$ 105,00 (cento e cinco reais),',
        ),
        DoubtHowRegisterItem(
          'O que é necessário para se inscrever no Bolsa Família?',
          'São famílias com renda familiar mensal por pessoa entre R\$ 105,01 e R\$ 210,00 (cento e cinco reais e um centavo e duzentos e dez reais).',
        ),
        DoubtHowRegisterItem(
          'O que são famílias em regra de emancipação?',
          'São famílias cujo beneficiário consegue um emprego formal e a renda ultrapassa a linha de pobreza (R\$ 210 por pessoa). Este poderá continuar recebendo o Bolsa Família por até dois anos, desde que a renda familiar mensal não ultrapasse R\$ 252 por pessoa.',
        ),
      ];
}

class HowRegisterItem {
  final String title;
  final String subtitle;
  final Widget widget;

  HowRegisterItem(this.title, this.subtitle, this.widget);

  static List<HowRegisterItem> itens(_) => [
        HowRegisterItem(
          'Veja se você tem direito',
          'Confira as regras para receber o Bolsa Família',
          const HowRegisterRightPage(),
        ),
        HowRegisterItem(
          'Documentos\nNecessários',
          'Veja os documentos para receber o Bolsa Família',
          const HowRegisterDocPage(),
        ),
        HowRegisterItem(
          'Cadastro no CadÚnico',
          'Veja como se Cadastrar ou Atualizar o CadÚnico',
          const HowRegisterCadunicoPage(),
        ),
        HowRegisterItem(
          'Aprovação no Bolsa Família',
          'Como saber se você foi aprovado no Bolsa Família',
          const HowRegisterAprovacaoPage(),
        ),
        HowRegisterItem(
          'Recebe seu Bolsa Família',
          'Saiba como receber seu Bolsa Família',
          const HowRegisterReceivePage(),
        ),
      ];
}

class SearchNisStep {
  static List<SearchNisStep> get itensCPF => [
        SearchNisStep(1,
            'Acesse o site CNIS (Cadastro Nacional de Informações Sociais);'),
        SearchNisStep(2, 'Selecione a opção "Cidadão";',
            url: 'https://miro.medium.com/max/640/0*i1v1In2Tn4Stnwnl.jpg'),
        SearchNisStep(3,
            'No canto superior direito, toque no “MENU”, após isso clique em “Inscrição”, e por fim clique em “Filiado”;',
            url: 'https://miro.medium.com/max/640/0*i1v1In2Tn4Stnwnl.jpg'),
        SearchNisStep(4,
            'Preencha todos os campos solicitados, incluindo o número do CPF;',
            url: 'https://miro.medium.com/max/640/0*i1v1In2Tn4Stnwnl.jpg'),
        SearchNisStep(
            5, 'Uma mensagem com a informação do seu número NIT/PIS aparecerá.',
            url: 'https://miro.medium.com/max/640/0*i1v1In2Tn4Stnwnl.jpg'),
      ];
  static List<SearchNisStep> get itensNIS => [
        SearchNisStep(1, 'Acesse o site oficial Meu INSS;'),
        SearchNisStep(2, 'Em seguida, entre com o seu login e senha;',
            url: 'https://miro.medium.com/max/640/0*i1v1In2Tn4Stnwnl.jpg'),
        SearchNisStep(3,
            'Caso não possua cadastro, clique em “Entrar” e preencha seus dados cadastrais;',
            url: 'https://miro.medium.com/max/640/0*i1v1In2Tn4Stnwnl.jpg'),
        SearchNisStep(
            4, 'Após o preenchimento, autorize o uso dos seus dados pessoais;',
            url: 'https://miro.medium.com/max/640/0*i1v1In2Tn4Stnwnl.jpg'),
        SearchNisStep(5,
            'Confirme seus dados respondendo algumas perguntas feitas pelo sistema;',
            url: 'https://miro.medium.com/max/640/0*i1v1In2Tn4Stnwnl.jpg'),
        SearchNisStep(6,
            'Faça login novamente e acesse a opção “Meu Cadastro”, no canto superior esquerdo;',
            url: 'https://miro.medium.com/max/640/0*i1v1In2Tn4Stnwnl.jpg'),
        SearchNisStep(7,
            'E pronto! Nessa opção, você encontra os seus dados cadastrados, incluindo o número do NIS.',
            url: 'https://miro.medium.com/max/640/0*i1v1In2Tn4Stnwnl.jpg'),
      ];
  final int position;

  final String title;

  final String? url;

  SearchNisStep(this.position, this.title, {this.url});
}
