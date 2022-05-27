import 'dart:convert';
import 'dart:io';

import 'package:chat_udemy/src/models/response_api.dart';
import 'package:chat_udemy/src/utils/api.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
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

  Future<ResponseApi> registerUsersWithImage(User user, File image) async {
    FormData form = FormData({
      'image': MultipartFile(image, filename: basename(image.path)),
      'user': json.encode(user)
    });
    print('Image $image');
    print('user $user');
    print('Isi form: $form');

    Response response = await post('$userUrl/registerWithImage', form);
    if (response.body == null) {
      Get.snackbar('Terjadi Kesalahan', 'Terjadi kesalah dalam registrasi');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
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
