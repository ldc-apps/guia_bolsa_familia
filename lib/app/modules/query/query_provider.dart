import 'dart:convert';

import 'package:aid_brazil/app/client/api_constans.dart';
import 'package:aid_brazil/app/client/api_endpoints.dart';
import 'package:aid_brazil/app/models/api_response_model.dart';
import 'package:aid_brazil/app/modules/query/query_model.dart';
import 'package:http/http.dart';

class QueryProvider {
  Future<ApiResponse<AidBrazil>> getBenefit(String nis) async {
    try {
      final res = await get(
          Uri.parse(ApiConstants.baseUrl +
              ApiEndpoints.benefit.replaceFirst(':nis', nis)),
          headers: {
            "Connection": "Keep-Alive",
          });
      if (res.statusCode == 200) {
        List<AidBrazil> aids = jsonDecode(res.body)
            .map<AidBrazil>((e) => AidBrazil.fromJson(e))
            .toList();
        aids.sort(
            (a, b) => a.mesDisponibilizacao!.compareTo(b.mesDisponibilizacao!));
        if (aids.isNotEmpty) {
          return ApiResponse.complete(aids.last);
        } else {
          return ApiResponse.error(RequestError(
            'Não há dados disponíveis',
          ));
        }
      } else {
        return ApiResponse.error(RequestError(
          'Erro ao realizar requisição',
        ));
      }
    } catch (e) {
      return ApiResponse.error(RequestError('Erro desconhecido'));
    }
  }
}
