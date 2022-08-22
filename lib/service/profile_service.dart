import '../model/member_profile_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileService{

  Future<Member_Profile?> getMember_Profile() async {

    var member_num = 'A00014';
    var uri = Uri(
      scheme: 'https',
      host: 'beta-dtba.btla.net',
      path: '/api/member/profile',
      //fragment: 'baz',
      queryParameters: { 'membership_number': member_num },
    );


    var headersObj = {
      'Content-type': 'application/json',
      'instance-api-secrete': "k8wscw04kwwok4gcwsk488o4sog8o00gsgwsog0k",
      'instance-name': 'sibldtba459807',

    };

    var response = await http.get(uri, headers: headersObj);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      // Do whatever you want to do with json.
    }

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {

      final json = jsonDecode(response.body);
      Member_Profile member_Profile = Member_Profile.fromJson(json);
      return member_Profile;
    } else {
      throw Exception(
          'Failed to load ... status code:${response.statusCode}\n${response.body}');
    }
  }

}