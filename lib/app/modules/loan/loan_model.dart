import 'package:aid_brazil/app/modules/loan/ui/loan_approved_page.dart';
import 'package:aid_brazil/app/modules/loan/ui/loan_ask_page.dart';
import 'package:aid_brazil/app/modules/loan/ui/loan_how_work_page.dart';
import 'package:aid_brazil/app/modules/loan/ui/loan_rights_page.dart';
import 'package:aid_brazil/app/modules/loan/ui/loan_rules_page.dart';
import 'package:aid_brazil/app/modules/loan/ui/loan_where_page.dart';
import 'package:flutter/material.dart';

class DoubtLoanItem {
  final String title;
  final String subtitle;
  final List<String>? banks;

  DoubtLoanItem(this.title, this.subtitle, {this.banks});

  static List<DoubtLoanItem> itens(_) => [
        DoubtLoanItem(
          'Em que bancos posso pedir o empréstimo do Bolsa Família?',
          'O Ministério da Cidadania afirma que 12 bancos foram autorizados a oferecer o consignado do Bolsa Família. São eles:',
          banks: [
            'Caixa Econômica Federal',
            'Banco Agibank',
            'Banco Crefisa',
            'Banco Daycoval',
            'Banco Pan',
            'Banco Safra',
            'Capital Consig Sociedade de Crédito Direto',
            'Facta Financeira',
            'Pintos S/A Créditos',
            'QI Sociedade de Crédito Direto',
            'Valor Sociedade de Crédito Direto S/A',
            'Zema Financeira',
          ],
        ),
        DoubtLoanItem(
          'Qual o valor máximo do empréstimo?',
          'As instituições vão poder descontar no máximo 5% do valor permanente do Auxílio, que é R\$ 600. O desconto dá R\$ 30, o que significa que sobraria até R\$ 570 para cair na conta do beneficiário que tiver um empréstimo contratado.',
        ),
        DoubtLoanItem(
          'Qual o prazo máximo de pagamento?',
          'Até 6 meses (6 meses) para pagar.',
        ),
        DoubtLoanItem(
          'Quais cuidados tomar?',
          'As taxas de juros cobradas são altas. O beneficiário deve avaliar se vale e se o empréstimo não irá comprometer o sustento da família.\n\nLembre-se que o pagamento da dívida é descontado automaticamente do benefício, ou seja, não existe a opção de não pagar.',
        ),
      ];

  static List<DoubtLoanItem> itensRights(_) => [
        DoubtLoanItem(
          'O que são famílias em situação de extrema pobreza?',
          'São famílias com renda familiar mensal por pessoa de até R\$ 105,00 (cento e cinco reais),',
        ),
        DoubtLoanItem(
          'O que é necessário para se inscrever no Bolsa Família?',
          'São famílias com renda familiar mensal por pessoa entre R\$ 105,01 e R\$ 218,00 (cento e cinco reais e um centavo e duzentos e dezoito reais).',
        ),
        DoubtLoanItem(
          'O que são famílias em regra de emancipação?',
          'São famílias cujo beneficiário consegue um emprego formal e a renda ultrapassa a linha de pobreza (R\$ 218 por pessoa). Este poderá continuar recebendo o Bolsa Família por até dois anos, desde que a renda familiar mensal não ultrapasse R\$ 252 por pessoa.',
        ),
      ];
}

class LoanItem {
  final String title;
  final String subtitle;
  final Widget widget;

  LoanItem(this.title, this.subtitle, this.widget);

  static List<LoanItem> itens(_) => [
        LoanItem(
          'Como funciona o empréstimo do Bolsa Família',
          'Veja como funciona o empréstimo',
          const LoanHowWorkPage(),
        ),
        LoanItem(
          'Veja se você tem direito',
          'Saiba quem pode contratar o empréstimo.',
          const LoanRightsPage(),
        ),
        LoanItem(
          'Quais as regras para o empréstimo do Bolsa Família',
          'Entenda as regras do empréstimo',
          const LoanRulesPage(),
        ),
        LoanItem(
          'Como solicitar o empréstimo',
          'Saiba como solicitar o empréstimo',
          const LoanAskPage(),
        ),
        LoanItem(
          'Como saber se fui aprovado',
          'Saiba como ver o status da aprovação',
          const LoanApprovedPage(),
        ),
        LoanItem(
          'Como recebo e onde recebo o emprestimo',
          'Entenda como receber o empréstimo do Bolsa Família',
          const LoanWherePage(),
        ),
      ];
}

class SearchNisStep {
  static List<SearchNisStep> get itensCPF => [
        SearchNisStep(1, 'Acesse o site CNIS (Cadastro Nacional de Informações Sociais);'),
        SearchNisStep(2, 'Selecione a opção "Cidadão";',
            url: 'https://miro.medium.com/max/640/0*i1v1In2Tn4Stnwnl.jpg'),
        SearchNisStep(3,
            'No canto superior direito, toque no “MENU”, após isso clique em “Inscrição”, e por fim clique em “Filiado”;',
            url: 'https://miro.medium.com/max/640/0*i1v1In2Tn4Stnwnl.jpg'),
        SearchNisStep(4, 'Preencha todos os campos solicitados, incluindo o número do CPF;',
            url: 'https://miro.medium.com/max/640/0*i1v1In2Tn4Stnwnl.jpg'),
        SearchNisStep(5, 'Uma mensagem com a informação do seu número NIT/PIS aparecerá.',
            url: 'https://miro.medium.com/max/640/0*i1v1In2Tn4Stnwnl.jpg'),
      ];
  static List<SearchNisStep> get itensNIS => [
        SearchNisStep(1, 'Acesse o site oficial Meu INSS;'),
        SearchNisStep(2, 'Em seguida, entre com o seu login e senha;',
            url: 'https://miro.medium.com/max/640/0*i1v1In2Tn4Stnwnl.jpg'),
        SearchNisStep(
            3, 'Caso não possua cadastro, clique em “Entrar” e preencha seus dados cadastrais;',
            url: 'https://miro.medium.com/max/640/0*i1v1In2Tn4Stnwnl.jpg'),
        SearchNisStep(4, 'Após o preenchimento, autorize o uso dos seus dados pessoais;',
            url: 'https://miro.medium.com/max/640/0*i1v1In2Tn4Stnwnl.jpg'),
        SearchNisStep(5, 'Confirme seus dados respondendo algumas perguntas feitas pelo sistema;',
            url: 'https://miro.medium.com/max/640/0*i1v1In2Tn4Stnwnl.jpg'),
        SearchNisStep(
            6, 'Faça login novamente e acesse a opção “Meu Cadastro”, no canto superior esquerdo;',
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
