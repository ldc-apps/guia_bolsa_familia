import 'package:aid_brazil/app/enums/ad_banner_enum.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rxdart/rxdart.dart';

class AdBannerStorage {
  static BehaviorSubject<BannerAd?> attendanceHomeStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> attendancePhoneCaixaStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> avantagesStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> calendarPaymentDayStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> calendarSelectNisStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> doubtsStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> homeStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> howRegisterAprovacaoStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> howRegisterCadunicoStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> howRegisterDocStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> howRegisterHomeStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> howRegisterReceiveStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> howRegisterRightStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> howWorkAvailableStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> howWorkBenefitStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> howWorkHomeStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> howWorkHowGetStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> howWorkWhatIsStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> howWorkWhatValuesPaidStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> loanApprovedStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> loanAskStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> loanHomeStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> loanHowWorkStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> loanRightsStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> loanRulesStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> loanWhereStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> newsStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> queryOptionsStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> queryResultStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> querySearchStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> quizErrorStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> quizHomeStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> quizStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> quizSuccessStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> rightsStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> searchNisCardStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> searchNisCpfStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> searchNisHomeStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> searchNisInssStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> searchNisPhoneStream =
      BehaviorSubject<BannerAd?>.seeded(null);
  static BehaviorSubject<BannerAd?> noFoundStream =
      BehaviorSubject<BannerAd?>.seeded(null);

  static BehaviorSubject<BannerAd?> stream(AdBannerEnum enumer) {
    switch (enumer) {
      case AdBannerEnum.attendanceHome:
        return attendanceHomeStream;
      case AdBannerEnum.attendancePhoneCaixa:
        return attendancePhoneCaixaStream;
      case AdBannerEnum.avantages:
        return avantagesStream;
      case AdBannerEnum.calendarPaymentDay:
        return calendarPaymentDayStream;
      case AdBannerEnum.calendarSelectNis:
        return calendarSelectNisStream;
      case AdBannerEnum.doubts:
        return doubtsStream;
      case AdBannerEnum.home:
        return homeStream;
      case AdBannerEnum.howRegisterAprovacao:
        return howRegisterAprovacaoStream;
      case AdBannerEnum.howRegisterCadunico:
        return howRegisterCadunicoStream;
      case AdBannerEnum.howRegisterDoc:
        return howRegisterDocStream;
      case AdBannerEnum.howRegisterHome:
        return howRegisterHomeStream;
      case AdBannerEnum.howRegisterReceive:
        return howRegisterReceiveStream;
      case AdBannerEnum.howRegisterRight:
        return howRegisterRightStream;
      case AdBannerEnum.howWorkAvailable:
        return howWorkAvailableStream;
      case AdBannerEnum.howWorkBenefit:
        return howWorkBenefitStream;
      case AdBannerEnum.howWorkHome:
        return howWorkHomeStream;
      case AdBannerEnum.howWorkHowGet:
        return howWorkHowGetStream;
      case AdBannerEnum.howWorkWhatIsPage:
        return howWorkWhatIsStream;
      case AdBannerEnum.howWorkWhatValuesPaid:
        return howWorkWhatValuesPaidStream;
      case AdBannerEnum.loanApproved:
        return loanApprovedStream;
      case AdBannerEnum.loanAsk:
        return loanAskStream;
      case AdBannerEnum.loanHome:
        return loanHomeStream;
      case AdBannerEnum.loanHowWork:
        return loanHowWorkStream;
      case AdBannerEnum.loanRights:
        return loanRightsStream;
      case AdBannerEnum.loanRules:
        return loanRulesStream;
      case AdBannerEnum.loanWhere:
        return loanWhereStream;
      case AdBannerEnum.news:
        return newsStream;
      case AdBannerEnum.queryOptions:
        return queryOptionsStream;
      case AdBannerEnum.queryResult:
        return queryResultStream;
      case AdBannerEnum.querySearch:
        return querySearchStream;
      case AdBannerEnum.quizError:
        return quizErrorStream;
      case AdBannerEnum.quizHome:
        return quizHomeStream;
      case AdBannerEnum.quiz:
        return quizStream;
      case AdBannerEnum.quizSuccess:
        return quizSuccessStream;
      case AdBannerEnum.rights:
        return rightsStream;
      case AdBannerEnum.searchNisCard:
        return searchNisCardStream;
      case AdBannerEnum.searchNisCpf:
        return searchNisCpfStream;
      case AdBannerEnum.searchNisHome:
        return searchNisHomeStream;
      case AdBannerEnum.searchNisInss:
        return searchNisInssStream;
      case AdBannerEnum.searchNisPhone:
        return searchNisPhoneStream;
      default:
        return noFoundStream;
    }
  }
}
