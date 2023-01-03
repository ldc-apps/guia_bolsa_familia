import 'package:aid_brazil/app/client/api_constans.dart';
import 'package:aid_brazil/app/client/api_endpoints.dart';
import 'package:aid_brazil/app/models/api_response_model.dart';
import 'package:aid_brazil/app/modules/query/query_model.dart';
import 'package:dio/dio.dart';

class QueryProvider {
  Future<ApiResponse<AidBrazil>> getBenefit(String nis) async {
    try {
      final res = await Dio(
      ).get(
        ApiConstants.baseUrl + ApiEndpoints.benefit.replaceFirst(':nis', nis),
      );
      if (res.statusCode == 200) {
        return ApiResponse.complete(AidBrazil.fromJson(res.data.first));
      } else {
        return ApiResponse.error(DioError(
            error: res.data.toString(), requestOptions: res.requestOptions));
      }
    } on DioError catch (e) {
      return ApiResponse.error(e);
    } catch (e) {
      return ApiResponse.error(DioError(
          requestOptions: RequestOptions(
              path: ApiConstants.baseUrl + ApiEndpoints.benefit)));
    }
  }
}
