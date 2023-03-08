import 'dart:convert';

import 'package:aid_brazil/app/client/api_constans.dart';
import 'package:aid_brazil/app/client/api_endpoints.dart';
import 'package:aid_brazil/app/models/api_response_model.dart';
import 'package:aid_brazil/app/modules/query/query_model.dart';
import 'package:http/http.dart';

class QueryProvider {
  Future<ApiResponse<AidBrazil>> getBenefit(String nis) async {
    return await getBenefitBackup(nis);

    try {
      final res = await get(
          Uri.parse(ApiConstants.baseUrl + ApiEndpoints.benefit.replaceFirst(':nis', nis)),
          headers: {
            "Connection": "Keep-Alive",
          }).timeout(const Duration(seconds: 5), onTimeout: () {
        throw Error();
      });
      if (res.statusCode == 200) {
        List<AidBrazil> aids =
            jsonDecode(res.body).map<AidBrazil>((e) => AidBrazil.fromJson(e)).toList();
        aids.sort((a, b) => a.mesDisponibilizacao!.compareTo(b.mesDisponibilizacao!));
        if (aids.isNotEmpty) {
          return ApiResponse.complete(aids.last);
        } else {
          return await getBenefitBackup(nis);
        }
      } else {
        return await getBenefitBackup(nis);
      }
    } catch (e) {
      return await getBenefitBackup(nis);
    }
  }

  Future<ApiResponse<AidBrazil>> getBenefitBackup(String nis) async {
    try {
      final res = await get(
          Uri.parse(
              'https://api.portaldatransparencia.gov.br/api-de-dados/auxilio-emergencial-por-cpf-ou-nis?codigoBeneficiario=$nis&pagina=1'),
          headers: {
            "chave-api-dados": "ea95534f2276bec0a97d361a73757181",
          }).timeout(const Duration(seconds: 8), onTimeout: () {
        throw Error();
      });
      if (res.statusCode == 200) {
        List<AidBrazil> aids =
            jsonDecode(res.body).map<AidBrazil>((e) => AidBrazil.fromJson(e)).toList();
        aids.sort((a, b) => a.mesDisponibilizacao!.compareTo(b.mesDisponibilizacao!));
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
