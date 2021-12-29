import 'package:albandar_project1/podos/submembers.dart';
import 'package:http/http.dart'as http;

class MyApi{

  // GET USER DETAILS FOR LOGIN
  static Future<http.Response> getUserdetailsforLogin({required String memberno})async{

    http.Response response=await http.get(Uri.parse("http://15.185.46.105:5000/api/member/$memberno"))
        .timeout(const Duration(seconds: 10));

    return response;
  }

  // GET SUB MEMBER DETAILS FROM PRIMARY MEMBER NO
  static Future<SubMemberDetails> getSubMemberdetails({required String memberno})async{

    http.Response response=await http.get(Uri.parse("http://15.185.46.105:5000/api/member/submember/$memberno"))
        .timeout(const Duration(seconds: 10));

    SubMemberDetails subMemberDetails=subMemberDetailsFromJson(response.body);

    return subMemberDetails;
  }

}