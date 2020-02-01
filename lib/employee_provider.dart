import 'dart:convert';

import 'package:crud/employee_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class EmployeeProvider extends ChangeNotifier {
  //deklarasi variable list dengan valuenya EmployeeModel dan kosong
  List<EmployeeModel>_data = [];

  //getter dari _data
  List<EmployeeModel> get dataEmployee => _data;

  //fungsi melakukan request data ke server/APi/get
  Future<List<EmployeeModel>> getEmployee() async{
    final url = 'http://employee-crud-flutter.daengweb.id/index.php';
    final response = await http.get(url);

    //jika status berhasil / 200
    if(response.statusCode == 200){
      //MAKA KITA FORMAT DATANYA MENJADI MAP DENGNA KEY STRING DAN VALUE DYNAMIC
      final result = json.decode(response.body)['data'].cast<Map<String, dynamic>>();

      //KEMUDIAN MAPPING DATANYA UNTUK KEMUDIAN DIUBAH FORMATNYA SESUAI DENGAN EMPLOYEEMODEL DAN DIPASSING KE DALAM VARIABLE _DATA
      _data = result.map<EmployeeModel>((json)=> EmployeeModel.fromJson(json)).toList();

      return _data;
    }else{
      throw Exception;
    }
  }
  //post
  Future<bool> storeEmploye(String nama, String salary, String age)async{
    final url = 'http://employee-crud-flutter.daengweb.id/add.php';

    final response = await http.post(url, body: {
      'employee_name' : nama,
      'employee_salary': salary,
      'employee_age' : age
    });

    final result = json.decode(response.body);
    if(response.statusCode == 200 && result['status'] == 'success'){
      notifyListeners();
      return true;
    }
    return false;
  }
}
