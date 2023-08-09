import 'package:attendx/constants/api_constants.dart';
import 'package:attendx/models/attendance_report_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceService{

  static Future<bool> addAttendance(
      {
        required String device_name,
        required String device_addr,
        required String attendance_type,
        required String activity,
      }) async {
    try {
      var data = {
        "device_name": device_name,
        "device_addr": device_addr,
        "attendance_type": attendance_type,
        "activity": activity,
      };

      Dio dio = Dio();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString("access_token") ?? "";
      dio.options.headers['Authorization'] = 'Bearer $accessToken';

      String endpoint = ApiConstants.api_endpont;

      await dio.post("${endpoint}users/attendance/add/", data: data);

      return true;
    } on DioException catch (e) {
      print(e.toString());
      return false;
    } catch (e) {
      print(e.toString());
      // throw Exception(e.toString());
      return false;
    }
  }

  static Future<AttendanceReportModel> getUserAttendances() async {
    try {
      Dio dio = Dio();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString("access_token") ?? "";
      dio.options.headers['Authorization'] = 'Bearer $accessToken';

      String endpoint = ApiConstants.api_endpont;

      Response response = await dio.get("${endpoint}users/attendance/list/");
      // print(data);
      return AttendanceReportModel.fromJson(response.data);
    } on DioException catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

}