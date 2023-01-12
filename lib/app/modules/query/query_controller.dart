import 'package:aid_brazil/app/ad/ad_controller.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/query_loading_page.dart';
import '../../models/api_response_model.dart';
import '../../services/notification_service.dart';
import '../../utils/global_resource.dart';
import '../calendar/calendar_controller.dart';
import 'query_model.dart';
import 'query_provider.dart';
import 'ui/query_options_page.dart';
import 'ui/query_result_page.dart';

class QueryController {
  static final QueryController _controller = QueryController._();

  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  final QueryProvider _queryProvider = QueryProvider();

  final CalendarController _calendarController = CalendarController();
  final BehaviorSubject<QuerySearchCreate> _querySearchCreate =
      BehaviorSubject<QuerySearchCreate>();

  final BehaviorSubject<ApiResponse<AidBrazil>> _aidBrazil =
      BehaviorSubject<ApiResponse<AidBrazil>>();
  factory QueryController() => _controller;

  QueryController._();
  ApiResponse<AidBrazil> get aidBrazil => _aidBrazil.stream.value;
  BuildContext get context => key.currentState!.context;
  Sink<ApiResponse<AidBrazil>> get inAidBrazilResponse => _aidBrazil.sink;

  Sink<QuerySearchCreate> get inQuerySearchCreate => _querySearchCreate.sink;

  Stream<ApiResponse<AidBrazil>> get outAidBrazilResponse => _aidBrazil.stream;
  Stream<QuerySearchCreate> get outQuerySearchCreate =>
      _querySearchCreate.stream;
  QuerySearchCreate get querySearchCreate => _querySearchCreate.stream.value;
  DateTime getPaymentDate(QueryResult query) {
    return _calendarController.getCurrentDay(
        _calendarController.getDaysInYear(int.parse(query.nis.split('').last)));
  }

  Future<void> initQuerySearch() async {
    final instance = await SharedPreferences.getInstance();
    final nis = instance.getString('nis');
    bool? save = instance.getBool('save');
    if (save == null) {
      instance.setBool('save', false);
      save = instance.getBool('save');
    }
    QuerySearchCreate create = QuerySearchCreate(save!);
    if (nis != null) create.search.text = nis;
    inQuerySearchCreate.add(create);
  }

  Future<void> onSearchQuery(context) async {
    try {
      if (querySearchCreate.search.text.length < 8) {
        NotificationService.negative('Verifique o NIS informado');
        return;
      }
      final response =
          await push(QueryLoadingPage(querySearchCreate.search.value.text));
      if (response.hasData) {
        final query = QueryResult.fromAid(response.data);
        query.paymentDate = getPaymentDate(query);
        setNis(querySearchCreate, query.nis);
        push(context, QueryResultPage(query));
      } else {
        await _onErrorQuery(context);
      }
    } catch (e) {
      await _onErrorQuery(context);
    }
  }

  void setNis(QuerySearchCreate querySearchCreate, String nis) {
    SharedPreferences.getInstance()
        .then((v) => v.setString('nis', querySearchCreate.save ? nis : empty));
  }

  Future<void> _onErrorQuery(context) async {
    await AdController.checkAndshowQueryAd();
    push(
        context,
        const QueryOptionsPage(
            'Infelizmente, não encontramos seu benefício em nossa base de dados.',
            'Não se preocupe, confira as alternativas abaixo para consultar seu benefício.'));
  }
}
