import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
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

  Future<Stream> createWithImage(User user, File image) async {
    Uri url = Uri.http('192.168.43.12:3003', 'api/users/registerWithImage');
    final request = http.MultipartRequest('POST', url);
    request.files.add(http.MultipartFile(
        'image', http.ByteStream(image.openRead().cast()), await image.length(),
        filename: basename(image.path)));

    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  Future<ResponseApi> registerUsersWithImage(User user, File image) async {
    FormData form = FormData({
      'image': MultipartFile(image, filename: basename(image.path)),
      'user': json.encode(user)
    });

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
