import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart'
as http;
import 'package:opnicare_app/Dashboard/Layanan/Model/ModelDokter.dart';
import 'package:opnicare_app/Dashboard/Layanan/Model/ModelKamar.dart';
import 'package:opnicare_app/Dashboard/Layanan/Model/ModelKeranjang.dart';
import 'package:opnicare_app/Dashboard/Layanan/Model/ModelMedis.dart';
import 'package:opnicare_app/Dashboard/Layanan/Model/ModelRiwayatPendaftaran.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {

  String serverUrl="http://192.168.1.62:8000/api";
  var status;

  var token;
  String ? csrfToken;

  Future < void>getCsrfToken() async {
    try {
      final response=await http.get(Uri.parse('$serverUrl/csrf-token'));

      if (response.statusCode==200) {
        csrfToken=json.decode(response.body)['csrf_token'];

        print('CSRF Token: $csrfToken');
      }

      else {
        print('Gagal mendapatkan token CSRF');
      }
    }

    catch (e) {
      print('Error: $e');
    }
  }

  Future < bool>loginData(String email, String password) async {
    String myUrl="$serverUrl/login";
    await getCsrfToken();

    try {

      final response=await http.post(Uri.parse(myUrl),
        headers: {
          'Accept': 'application/json',
          'X-CSRF-TOKEN': csrfToken ?? ''
        }

        ,
        body: {
          "email": email,
          "password": password,
        }

        ,
      );

      if (response.statusCode==200) {
        var data=json.decode(response.body);
        status=data.containsKey('error');

        if (status) {
          print('Error: ${data["error"]}');
          return false;
        }

        else if (data["token"] !=null) {
          print('Token: ${data["token"]}');
          _save(data["token"]);
          _save_noRM(data["no_rm"]);
          _save_nama(data["nama"]);
          return true; 
        }

        else {
          print('Token is null');
          return false; 
        }
      }

      else {
        print('Failed to connect to the server');
        return false; 
      }
    }

    catch (e) {
      print('Exception: $e');
      return false; 
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


  Future < Map < String,
  dynamic>?>getDataUser() async {

    final prefs=await SharedPreferences.getInstance();
    final key='token';
    final value=prefs.get(key) ?? 0;

    String myUrl="$serverUrl/user/";

    http.Response response=await http.get(Uri.parse(myUrl),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $value'
      }

    );
    return json.decode(response.body);
  }

  _save(String token) async {
    final prefs=await SharedPreferences.getInstance();
    final key='token';
    final value=token;
    prefs.setString(key, value);
  }

  _save_noRM(String no_rm) async {
    final prefs=await SharedPreferences.getInstance();
    final key='no_rm';
    final value=no_rm;
    prefs.setString(key, value);
  }

    _save_nama(String nama) async {
    final prefs=await SharedPreferences.getInstance();
    final key='nama';
    final value=nama;
    prefs.setString(key, value);
  }


  read() async {
    final prefs=await SharedPreferences.getInstance();
    final key='token';
    final value=prefs.get(key) ?? 0;
    print('read : $value');
  }

  Future < int>sendDateToServer(String date, String dokter, String pasien, String keluhan) async {
    final prefs=await SharedPreferences.getInstance();
    final key='token';
    final value=prefs.get(key) ?? 0;

    final String route="$serverUrl/send-data-pendaftaran"; // Ganti dengan URL server Anda

    final response=await http.post(Uri.parse(route),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $value'

      },
      body: json.encode( {
          'date': date, 
          'dokter_id': dokter,
          'pasien_id': pasien,
          'keluhan': keluhan
        }

      ),

    );
      print(date + " " + dokter + " " + pasien);

    return response.statusCode;
  }



  Future < List < RiwayatPendaftaran>?>getRiwayatPendaftaran() async {
    final prefs=await SharedPreferences.getInstance();
    final token=prefs.getString('token') ?? '';
    final noRm=prefs.getString('no_rm') ?? '';

    final String route="$serverUrl/get-riwayat-pendaftaran/$noRm";

    final response=await http.get(Uri.parse(route),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      }

      ,
    );

    if (response.statusCode==200) {
      final List < dynamic>jsonData=json.decode(response.body);
      return jsonData .map((item)=> RiwayatPendaftaran.fromJson(item)) .toList();
    }

    else {
      // Handle the case where the response is not successful
      return null;
    }
  }

  Future < List < Dokter>?>getDataDokter() async {
    final prefs=await SharedPreferences.getInstance();
    final token=prefs.getString('token') ?? '';
    final noRm=prefs.getString('no_rm') ?? '';

    try {
      final String route='${serverUrl}/getDokter';

      final response=await http.get(Uri.parse(route),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        }

        ,
      );
      print(response.statusCode);

      if (response.statusCode==200) {
        final List<dynamic>jsonData=json.decode(response.body);
        final List<Dokter>dokters=jsonData.map((item)=> Dokter.fromJson(item)).toList();
        return dokters;
      }

      else if (response.statusCode==419) {
        await refreshToken();
        return await getDataDokter();
      }

      else {
        print('Error: Gagal mengambil data');
        return null;
      }
    }

    catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future < List < Obat>?>getDataObat() async {
    final prefs=await SharedPreferences.getInstance();
    final token=prefs.getString('token') ?? '';
    final noRm=prefs.getString('no_rm') ?? '';

    try {
      final String route='${serverUrl}/getObat';

      final response=await http.get(Uri.parse(route),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        }

        ,
      );
      print(response.statusCode);

      if (response.statusCode==200) {
        final List<dynamic>jsonData=json.decode(response.body);
        final List<Obat>obats=jsonData.map((item)=> Obat.fromJson(item)).toList();
        return obats;
      }

      else if (response.statusCode==419) {
        await refreshToken();
        return await getDataObat();
      }

      else {
        print('Error: Gagal mengambil data');
        return null;
      }
    }

    catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future < List < Kamar>?>getDataKamar() async {
    final prefs=await SharedPreferences.getInstance();
    final token=prefs.getString('token') ?? '';
    final noRm=prefs.getString('no_rm') ?? '';

    try {
      final String route='${serverUrl}/getKamar';

      final response=await http.get(Uri.parse(route),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        }

        ,
      );
      print(response.statusCode);

      if (response.statusCode==200) {
        final List<dynamic>jsonData=json.decode(response.body);
        final List<Kamar>kamars=jsonData.map((item)=> Kamar.fromJson(item)).toList();
        return kamars;
      }

      else if (response.statusCode==419) {
        await refreshToken();
        return await getDataKamar();
      }

      else {
        print('Error: Gagal mengambil data');
        return null;
      }
    }

    catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<void>refreshToken() async {
    final prefs=await SharedPreferences.getInstance();
    final token=prefs.getString('token') ?? '';

    final String route="$serverUrl/token/refresh";

    final response=await http.post(Uri.parse(route),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      }

      ,
    );

    if (response.statusCode==200) {
      final jsonData=json.decode(response.body);
      _save(jsonData['token']);
      print('Refresh token berhasil');
    }

    else {
      print('Error: Gagal refresh token');
    }
  }


  Future<void>logout() async {
    final prefs=await SharedPreferences.getInstance();
    final token=prefs.getString('token') ?? '';

    final String route="$serverUrl/logout";

    final response=await http.post(Uri.parse(route),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      }

      ,
    );

    if (response.statusCode==200) {
      final jsonData=json.decode(response.body);
      await prefs.remove('token');
      print('Logout berhasil');
    }

    else {
      print('Error: Gagal logout');
    }
  }


  Future<int>sendKritikSaran(String keluhan, File image) async {
    final prefs=await SharedPreferences.getInstance();
    final token=prefs.getString('token') ?? '';

    final String route="$serverUrl/send-keluhan";
    final request=http.MultipartRequest('POST', Uri.parse(route)) ..headers['Authorization']='Bearer $token'
    ..fields['keluhan']=keluhan ..files.add(await http.MultipartFile.fromPath('foto',
        image.path,
      ));

    request.headers['Accept']='application/json';

    final response=await request.send();
    print(response.statusCode);

    if (response.statusCode==422) {
      final responseBody=await response.stream.bytesToString();
      final errorMessage='Terjadi kesalahan: $responseBody';
      print(errorMessage);
      return 422;
    }

    else if (response.statusCode==500) {
      print('Terjadi kesalahan server');
      return 500;
    }

    else {
      print('Berhasil mengirim laporan');
      return response.statusCode;
    }
  }


  Future<int>tambahKeranjang(String productId, int quantity) async {
    final prefs=await SharedPreferences.getInstance();
    final token=prefs.getString('token') ?? '';
    final noRm=prefs.getString('no_rm') ?? '';


    final String route="$serverUrl/tambah-obat";

    final response=await http.post(Uri.parse(route),
      headers: {
        'Authorization': 'Bearer ${token}',
        'Content-Type': 'application/json',
      }

      ,
      body: json.encode( {
          'pasienId': noRm,
          'obatId': productId,
          'jumlah': quantity,
        }

      ),
    );

    if (response.statusCode==200) {
      print('Product added to cart');
      return response.statusCode;
    }

    else {
      print('Failed to add product to cart');
      return response.statusCode;
    }
  }

  Future<List<Keranjang>?>getDataKeranjang() async {
    final prefs=await SharedPreferences.getInstance();
    final token=prefs.getString('token') ?? '';
    final noRm=prefs.getString('no_rm') ?? '';

    final String route='$serverUrl/get-data-keranjang/$noRm';

    final response=await http.get(Uri.parse(route),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      }

      ,
    );

    print(response.statusCode);

    if (response.statusCode==200) {
      final List<dynamic>jsonData=json.decode(response.body);
      return jsonData .map((item)=> Keranjang.fromJson(item)) .toList();
    }

    else {
      print('Error: Failed to fetch data');
      return null;
    }
  }

  Future<int>transaksiObat(List<Map<String,dynamic>>obat, double total) async {
    final prefs=await SharedPreferences.getInstance();
    final token=prefs.getString('token') ?? '';
    final noRm=prefs.getString('no_rm') ?? '';


    final String route="$serverUrl/transaksi-obat";

    final response=await http.post(Uri.parse(route),
      headers: {
        'Authorization': 'Bearer ${token}',
        'Content-Type': 'application/json',
      }

      ,
      body: json.encode( {
          'pasienId': noRm,
          'obat': obat,
          'total': total,
        }

      ),
    );
    print("transaksiObat : ${response.statusCode}");
    if (response.statusCode==200) {
      print('Transaksi Obat success');
      return response.statusCode;
    }

    else {
      print('Failed to transaksi obat');
      return response.statusCode;
    }
  }


}