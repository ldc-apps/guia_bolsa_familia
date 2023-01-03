import 'package:aid_brazil/app/modules/quiz/ui/quiz_error_page.dart';
import 'package:aid_brazil/app/modules/quiz/ui/quiz_page.dart';
import 'package:aid_brazil/app/modules/quiz/ui/quiz_warning_dialog.dart';
import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:flutter/cupertino.dart';

import 'ui/quiz_success_page.dart';

class Quiz {
  double percentage;
  String title;
  List<QuizOption> options;
  QuizOption? option;

  Quiz({
    required this.percentage,
    required this.title,
    required this.options,
  });

  static QuizPage atualizaouSeuCadastroNosUltimos2Anos(BuildContext context) {
    return QuizPage(
      Quiz(
        percentage: 35,
        title: 'Você atualizou seu Cadastro Único nos últimos 2 anos? ',
        options: [
          QuizOption(
            onTap: () => push(context, rendaMensalMaior210(context)),
            label: 'Sim',
          ),
          QuizOption(
            onTap: () => push(context, QuizError.precisaCadUnicoAtualizado()),
            label: 'Não',
          ),
        ],
      ),
    );
  }

  static QuizPage completou18Anos(BuildContext context, bool masculino) {
    return QuizPage(
      Quiz(
        percentage: 10,
        title: 'Você já completou 18 anos de idade?',
        options: [
          QuizOption(
            onTap: () => push(context, moraNoBrasil(context)),
            label: 'Sim',
          ),
          QuizOption(
            onTap: () => push(
                context,
                masculino
                    ? QuizError.idadeMinima()
                    : voceTemUmOuMaisFilhos(context)),
            label: 'Não',
          ),
        ],
      ),
    );
  }

  static QuizPage declarouImpostoAnoPassado(BuildContext context) {
    return QuizPage(
      Quiz(
        percentage: 45,
        title: 'Declarou imposto de renda no ano passado?',
        options: [
          QuizOption(
            onTap: () => push(context, rendaMaior28AnoPassado(context)),
            label: 'Sim',
          ),
          QuizOption(
            onTap: () => push(
              context,
              dependenteAlguemDeclarouImpostoAnoPassado(context),
            ),
            label: 'Não',
          ),
        ],
      ),
    );
  }

  static QuizPage dependenteAlguemDeclarouImpostoAnoPassado(
    BuildContext context,
  ) {
    return QuizPage(
      Quiz(
        percentage: 60,
        title:
            'Você é dependente de alguém que declarou imposto de renda no ano passado?',
        options: [
          QuizOption(
            onTap: () => push(context, QuizError.linhaExtremaPobreza()),
            label: 'Sim',
          ),
          QuizOption(
            onTap: () => push(context, voceEstagiandoAtualmente(context)),
            label: 'Não',
          ),
        ],
      ),
    );
  }

  static QuizPage estavaInscritoBolsaFamilia(BuildContext context) {
    return QuizPage(
      Quiz(
        percentage: 32,
        title: 'Você já estava inscrito(a) no Bolsa Família?',
        options: [
          QuizOption(
            onTap: () =>
                push(context, atualizaouSeuCadastroNosUltimos2Anos(context)),
            label: 'Sim',
          ),
          QuizOption(
            onTap: () => push(context, QuizError.precisaCadUnicoAtualizado()),
            label: 'Não',
          ),
        ],
      ),
    );
  }

  static QuizPage faixaEtariaFilhoMaisNovo(BuildContext context) {
    return QuizPage(
      Quiz(
        percentage: 18,
        title: 'Qual a faixa estária do seu filho mais novo?',
        options: [
          QuizOption(
            onTap: () => push(context, preNatalEmDia(context)),
            label: 'Em período de GESTAÇÃO',
          ),
          QuizOption(
            onTap: () => push(context, filhosPossuemVacinasAtrasadas(context)),
            label: 'De 0 a 6 anos',
          ),
          QuizOption(
            onTap: () => push(context, moraNoBrasil(context)),
            label: 'De 7 a 17 anos',
          ),
        ],
      ),
    );
  }

  static QuizPage filhosPossuemVacinasAtrasadas(BuildContext context) {
    return QuizPage(
      Quiz(
        percentage: 22,
        title: 'Seus filhos possuem  vacinas atrasadas?',
        options: [
          QuizOption(
            onTap: () => showDialogAndPush(
              context,
              QuizWarning.vacinasDependentesEmDia(),
              moraNoBrasil(context),
            ),
            label: 'Sim',
          ),
          QuizOption(
            onTap: () => push(context, moraNoBrasil(context)),
            label: 'Não',
          ),
        ],
      ),
    );
  }

  static QuizPage initialize(BuildContext context) => qualSeuGenero(context);

  static QuizPage inscritoNoCadastroUnico(BuildContext context) {
    return QuizPage(
      Quiz(
        percentage: 30,
        title: 'Você está inscrito no Cadastro Único?',
        options: [
          QuizOption(
            onTap: () =>
                push(context, atualizaouSeuCadastroNosUltimos2Anos(context)),
            label: 'Sim',
          ),
          QuizOption(
            onTap: () => push(context, estavaInscritoBolsaFamilia(context)),
            label: 'Não',
          ),
        ],
      ),
    );
  }

  static QuizPage moraNoBrasil(BuildContext context) {
    return QuizPage(
      Quiz(
        percentage: 25,
        title: 'Você mora no Brasil?',
        options: [
          QuizOption(
            onTap: () => push(context, inscritoNoCadastroUnico(context)),
            label: 'Sim',
          ),
          QuizOption(
            onTap: () => push(context, QuizError.morarNoBrasil()),
            label: 'Não',
          ),
        ],
      ),
    );
  }

  static QuizPage preNatalEmDia(BuildContext context) {
    return QuizPage(
      Quiz(
        percentage: 20,
        title: 'Seu pré-natal está em dias?',
        options: [
          QuizOption(
            onTap: () => push(context, moraNoBrasil(context)),
            label: 'Sim',
          ),
          QuizOption(
            onTap: () => showDialogAndPush(
              context,
              QuizWarning.preNatalEmDias(),
              moraNoBrasil(context),
            ),
            label: 'Não',
          ),
        ],
      ),
    );
  }

  static QuizPage qualSeuGenero(BuildContext context) {
    return QuizPage(
      Quiz(
        percentage: 1,
        title: 'Qual o seu Genero?',
        options: [
          QuizOption(
            onTap: () => push(context, completou18Anos(context, false)),
            label: 'Feminino',
          ),
          QuizOption(
            onTap: () => push(context, completou18Anos(context, true)),
            label: 'Masculino',
          ),
        ],
      ),
    );
  }

  static QuizPage recebendoSeguroDesemprego(BuildContext context) {
    return QuizPage(
      Quiz(
        percentage: 80,
        title: 'Você está recebendo seguro desemprego?',
        options: [
          QuizOption(
            onTap: () => push(context, QuizError.beneficioNaoPodeSerLiberado()),
            label: 'Sim',
          ),
          QuizOption(
            onTap: () => push(context, trabalhandoAtualmente(context)),
            label: 'Não',
          ),
        ],
      ),
    );
  }

  static QuizPage rendaMaior28AnoPassado(BuildContext context) {
    return QuizPage(
      Quiz(
        percentage: 50,
        title: 'No ano passado, sua renda foi maior que R\$ 28.569,70?',
        options: [
          QuizOption(
            onTap: () => push(context, QuizError.rendaMaiorLimitePermitido()),
            label: 'Sim',
          ),
          QuizOption(
            onTap: () => push(
              context,
              dependenteAlguemDeclarouImpostoAnoPassado(context),
            ),
            label: 'Não',
          ),
        ],
      ),
    );
  }

  static QuizPage rendaMensalMaior210(BuildContext context) {
    return QuizPage(
      Quiz(
        percentage: 40,
        title: 'A renda mensal em sua casa, é maior que R\$210,00 por pessoa?',
        options: [
          QuizOption(
            onTap: () =>
                push(context, QuizError.rendaFamiliaNaoPodeUltrapassar210()),
            label: 'Sim',
          ),
          QuizOption(
            onTap: () => push(context, declarouImpostoAnoPassado(context)),
            label: 'Não',
          ),
        ],
      ),
    );
  }

  static QuizPage suaCarteiraEstaAssinada(BuildContext context) {
    return QuizPage(
      Quiz(
        percentage: 99,
        title: 'Sua carteira de trabalho está assinada?',
        options: [
          QuizOption(
            onTap: () => push(context, QuizError.voceJaTemUmEmprego()),
            label: 'Sim',
          ),
          QuizOption(
            onTap: () => push(context, const QuizSuccessPage()),
            label: 'Não',
          ),
        ],
      ),
    );
  }

  static QuizPage trabalhandoAtualmente(BuildContext context) {
    return QuizPage(
      Quiz(
        percentage: 90,
        title: 'Você está trabalhando atualmente?',
        options: [
          QuizOption(
            onTap: () => push(context, suaCarteiraEstaAssinada(context)),
            label: 'Sim',
          ),
          QuizOption(
            onTap: () => push(context, const QuizSuccessPage()),
            label: 'Não',
          ),
        ],
      ),
    );
  }

  static QuizPage voceEstagiandoAtualmente(BuildContext context) {
    return QuizPage(
      Quiz(
        percentage: 70,
        title: 'Você está estagiando atualmente?',
        options: [
          QuizOption(
            onTap: () => push(context, QuizError.estagiariosNaoParticipam()),
            label: 'Sim',
          ),
          QuizOption(
            onTap: () => push(context, recebendoSeguroDesemprego(context)),
            label: 'Não',
          ),
        ],
      ),
    );
  }

  static QuizPage voceTemUmOuMaisFilhos(BuildContext context) {
    return QuizPage(
      Quiz(
        percentage: 15,
        title: 'Você tem um o mais filhos?',
        options: [
          QuizOption(
            onTap: () => push(context, faixaEtariaFilhoMaisNovo(context)),
            label: 'Sim',
          ),
          QuizOption(
            onTap: () => push(context, QuizError.idadeMinima()),
            label: 'Não',
          ),
        ],
      ),
    );
  }
}

class QuizError {
  final String title;
  final String subtitle;
  QuizError({required this.title, required this.subtitle});

  static QuizErrorPage beneficioNaoPodeSerLiberado() => QuizErrorPage(
        QuizError(
          title: 'Seu benefício não pode ser liberado.',
          subtitle:
              'Enquanto você estiver recebendo Seguro Desemprego, o Bolsa Família não pode ser concedido a você.',
        ),
      );

  static QuizErrorPage estagiariosNaoParticipam() => QuizErrorPage(
        QuizError(
          title: 'Estagiários não participam do Bolsa Família',
          subtitle:
              'Pessoas estagiando em instituições públicas, privadas e até mesmo bolsistas.',
        ),
      );

  static QuizErrorPage idadeMinima() => QuizErrorPage(
        QuizError(
          title: 'Você ainda não atingiu a idade para participar... 🔞',
          subtitle:
              'Para participar do programa Bolsa Família você precisa ser maior de 18 anos, ou ser Mulher gestante, ou mãe.',
        ),
      );

  static QuizErrorPage linhaExtremaPobreza() => QuizErrorPage(
        QuizError(
          title:
              'Você precisa estar na linha da extrema pobreza para participar.',
          subtitle: '',
        ),
      );

  static QuizErrorPage morarNoBrasil() => QuizErrorPage(
        QuizError(
          title: 'Você precisa morar no Brasil para participar... ',
          subtitle:
              'Para participar do programa Bolsa Família você estar morando dentro do país.',
        ),
      );

  static QuizErrorPage precisaCadUnicoAtualizado() => QuizErrorPage(
        QuizError(
          title: 'Pra participar você precisa ter seu CádÚnico atualizado.',
          subtitle:
              'Procure um CRAS para atualizar as informações do seu cadastro.',
        ),
      );

  static QuizErrorPage rendaFamiliaNaoPodeUltrapassar210() => QuizErrorPage(
        QuizError(
          title:
              'A sua renda famíliar não pode ultrapassar R\$210,00 por pessa,',
          subtitle: '',
        ),
      );

  static QuizErrorPage rendaMaiorLimitePermitido() => QuizErrorPage(
        QuizError(
          title: 'Parece que sua renda foi maior que o limite permitido.',
          subtitle: '',
        ),
      );

  static QuizErrorPage voceJaTemUmEmprego() => QuizErrorPage(
        QuizError(
          title: 'Ops, parece que você já tem um emprego.',
          subtitle:
              'Para participar do programa Bolsa Família você precisa estar desempregado.',
        ),
      );
}

class QuizOption {
  Function onTap;
  String label;

  QuizOption({
    required this.onTap,
    required this.label,
  });
}

class QuizWarning {
  final String description;
  QuizWarning({required this.description});

  static QuizWarningDialog preNatalEmDias() => QuizWarningDialog(
        QuizWarning(
          description:
              'Para participar do programa Bolsa Família, seu pré-natal precisa estar em dias. Dirija-se ao posto de saúde mais próximo, e regulariza sua situação. ',
        ),
      );
  static QuizWarningDialog vacinasDependentesEmDia() => QuizWarningDialog(
        QuizWarning(
          description:
              'Para participar do programa Bolsa Família, as vacinas de seus dependentes precisam estar em dias. Dirija-se ao posto de saúde mais próximo, e regulariza sua situação.',
        ),
      );
}
