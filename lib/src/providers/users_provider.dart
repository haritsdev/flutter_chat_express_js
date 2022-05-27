import 'package:chat_udemy/src/models/response_api.dart';
import 'package:chat_udemy/src/utils/api.dart';
import 'package:get/get.dart';

import '../models/user.dart';

class UsersProvider extends GetConnect {
  String url = Environtment.API_CHAT;
  String userUrl = Environtment.API_CHAT + '/users';

  Future<Response> create(User user) async {
    Response response = await post(
      '$userUrl/create',
      user.toJson(),
    );

    return response;
  }

  Future<ResponseApi> login(String email, String password) async {
    Response response = await post(
        '$userUrl/login', {'email': email, 'password': password},
        headers: {'Content-Type': 'application/json'});

    if (response.body == null) {
      Get.snackbar('Error', 'Login gagal');
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }
}
