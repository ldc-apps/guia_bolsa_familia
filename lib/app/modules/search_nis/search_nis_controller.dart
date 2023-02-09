import 'package:aid_brazil/app/ad/ad_controller.dart';
import 'package:aid_brazil/app/components/query_loading_page.dart';
import 'package:aid_brazil/app/models/api_response_model.dart';
import 'package:aid_brazil/app/modules/calendar/calendar_controller.dart';
import 'package:aid_brazil/app/modules/query/query_model.dart';
import 'package:aid_brazil/app/modules/query/query_provider.dart';
import 'package:aid_brazil/app/modules/search_nis/search_nis_model.dart';
import 'package:aid_brazil/app/modules/search_nis/ui/search_nis_options_page.dart';
import 'package:aid_brazil/app/modules/search_nis/ui/search_nis_result_page.dart';
import 'package:aid_brazil/app/services/notification_service.dart';
import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NisController {
  static final NisController _controller = NisController._();

  NisController._();

  factory NisController() => _controller;

  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  BuildContext get context => key.currentState!.context;

  final QueryProvider _queryProvider = QueryProvider();
  final CalendarController _calendarController = CalendarController();

  final BehaviorSubject<NisSearchCreate> _nisSearchCreate =
      BehaviorSubject<NisSearchCreate>();
  Sink<NisSearchCreate> get inNisSearchCreate => _nisSearchCreate.sink;
  Stream<NisSearchCreate> get outNisSearchCreate => _nisSearchCreate.stream;
  NisSearchCreate get nisSearchCreate => _nisSearchCreate.stream.value;

  Future<void> initNisSearch() async {
    final instance = await SharedPreferences.getInstance();
    final nis = instance.getString('cpf');
    bool? save = instance.getBool('saveCPF');
    if (save == null) {
      instance.setBool('saveCPF', false);
      save = instance.getBool('saveCPF');
    }
    NisSearchCreate create = NisSearchCreate(save!);
    if (nis != null) create.search.text = nis;
    inNisSearchCreate.add(create);
  }

  final BehaviorSubject<ApiResponse<AidBrazil>> _aidBrazil =
      BehaviorSubject<ApiResponse<AidBrazil>>();
  Sink<ApiResponse<AidBrazil>> get inAidBrazilResponse => _aidBrazil.sink;
  Stream<ApiResponse<AidBrazil>> get outAidBrazilResponse => _aidBrazil.stream;
  ApiResponse<AidBrazil> get aidBrazil => _aidBrazil.stream.value;

  Future<void> onSearchNis(context) async {
    try {
      if (nisSearchCreate.search.text.length != 14) {
        NotificationService.negative('Verifique o CPF informado');
        return;
      }
      final response =
          await push(QueryLoadingPage(nisSearchCreate.search.unmasked));
      if (response.hasData) {
        final query = QueryResult.fromAid(response.data);
        query.paymentDate = getPaymentDate(query);
        setNis(nisSearchCreate, query.nis);
        await AdController.checkAndshowQueryAd();
        push(context, SearchNisResultPage(query));
      } else {
        await _onErrorQuery(context);
      }
    } catch (e) {
      await _onErrorQuery(context);
    }
  }

  DateTime getPaymentDate(QueryResult query) {
    return _calendarController.getCurrentDay(
        _calendarController.getDaysInYear(int.parse(query.nis.split('').last)));
  }

  Future<void> _onErrorQuery(context) async {
    await AdController.checkAndshowQueryAd();
    push(
        context,
        const SearchNisOptionsPage(
            'Infelizmente, não encontramos seu benefício em nossa base de dados.',
            'Não se preocupe, confira as alternativas abaixo para consultar seu benefício.'));
  }

  void setNis(NisSearchCreate nisSearchCreate, String cpf) {
    SharedPreferences.getInstance()
        .then((v) => v.setString('cpf', nisSearchCreate.save ? cpf : empty));
  }
}
