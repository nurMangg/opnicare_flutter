import 'package:http/http.dart'
as http;
import 'package:opnicare_app/Dashboard/Layanan/Model/ModelDokter.dart';
import 'package:opnicare_app/Dashboard/Layanan/Model/ModelRiwayatPendaftaran.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {

  String serverUrl = "http://192.168.1.62:8000/api";
  var status;

  var token;
  String ? csrfToken;

  Future < void > getCsrfToken() async {
    try {
      final response = await http.get(Uri.parse('$serverUrl/csrf-token'));
      if (response.statusCode == 200) {
        // Token CSRF yang diterima dari server
        csrfToken = json.decode(response.body)['csrf_token'];

        print('CSRF Token: $csrfToken');
      } else {
        print('Gagal mendapatkan token CSRF');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future < bool > loginData(String email, String password) async {
    String myUrl = "$serverUrl/login";
    await getCsrfToken();

    try {
      final response = await http.post(
        Uri.parse(myUrl),
        headers: {
          'Accept': 'application/json',
          'X-CSRF-TOKEN': csrfToken ?? ''
        },
        body: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        status = data.containsKey('error');

        if (status) {
          print('Error: ${data["error"]}');
          return false; // Login gagal
        } else if (data["token"] != null) {
          print('Token: ${data["token"]}');
          _save(data["token"]);
          _save_noRM(data["no_rm"]);
          return true; // Login berhasil
        } else {
          print('Token is null');
          return false; // Login gagal karena token tidak tersedia
        }
      } else {
        print('Failed to connect to the server');
        return false; // Login gagal karena respons tidak 200
      }
    } catch (e) {
      print('Exception: $e');
      return false; // Login gagal karena ada exception
    }
  }

  // registerData(String name, String email, String password) async {

  //   String myUrl = "$serverUrl/register1";
  //   final response = await http.post(Uri.parse(myUrl),
  //     headers: {
  //       'Accept': 'application/json'
  //     },
  //     body: {
  //       "name": "$name",
  //       "email": "$email",
  //       "password": "$password"
  //     });
  //   status = response.body.contains('error');

  //   var data = json.decode(response.body);

  //   if (status) {
  //     print('data : ${data["error"]}');
  //   } else {
  //     print('data : ${data["token"]}');
  //     _save(data["token"]);
  //   }

  // }


  Future < Map < String, dynamic > ? > getDataUser() async {

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/user/";
    http.Response response = await http.get(Uri.parse(myUrl),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $value'
      });
    return json.decode(response.body);
  }

  // void addData(String name , String price) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final key = 'token';
  //   final value = prefs.get(key ) ?? 0;

  //   String myUrl = "$serverUrl/products";
  //   http.post(myUrl,
  //       headers: {
  //         'Accept':'application/json',
  //         'Authorization' : 'Bearer $value'
  //       },
  //       body: {
  //         "name": "$name",
  //         "price" : "$price"
  //       }).then((response){
  //     print('Response status : ${response.statusCode}');
  //     print('Response body : ${response.body}');
  //   });
  // }


  // void editData(int id,String name , String price) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final key = 'token';
  //   final value = prefs.get(key ) ?? 0;

  //   String myUrl = "http://flutterapitutorial.codeforiraq.org/api/products/$id";
  //   http.put(myUrl,
  //       headers: {
  //         'Accept':'application/json',
  //         'Authorization' : 'Bearer $value'
  //       },
  //       body: {
  //         "name": "$name",
  //         "price" : "$price"
  //       }).then((response){
  //     print('Response status : ${response.statusCode}');
  //     print('Response body : ${response.body}');
  //   });
  // }




  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

  _save_noRM(String no_rm) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'no_rm';
    final value = no_rm;
    prefs.setString(key, value);
  }


  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    print('read : $value');
  }

  Future < int > sendDateToServer(DateTime date, String dokter, String pasien, String keluhan) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    final String route = "$serverUrl/send-data-pendaftaran"; // Ganti dengan URL server Anda
    final response = await http.post(
      Uri.parse(route),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $value'

      },
      body: json.encode({
        'date': date.toIso8601String(), // Mengirimkan tanggal dalam format ISO 8601
        'dokter_id': dokter,
        'pasien_id': pasien,
        'keluhan': keluhan
      }),
    );

    return response.statusCode;
  }



  Future < List < RiwayatPendaftaran > ? > getRiwayatPendaftaran() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final noRm = prefs.getString('no_rm') ?? '';

    final String route = "$serverUrl/get-riwayat-pendaftaran/$noRm";
    final response = await http.get(
      Uri.parse(route),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List < dynamic > jsonData = json.decode(response.body);
      return jsonData
        .map((item) => RiwayatPendaftaran.fromJson(item))
        .toList();
    } else {
      // Handle the case where the response is not successful
      return null;
    }
  }

  Future < List < Dokter > ? > getDataDokter() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final noRm = prefs.getString('no_rm') ?? '';

    try {
      final String route = '${serverUrl}masters/dokters/api/getDokter';
      final response = await http.get(
        Uri.parse(route),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        final List<Dokter> dokters = jsonData.map((item) => Dokter.fromJson(item)).toList();
        return dokters;
      } else {
        print('Error: Gagal mengambil data');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }


}