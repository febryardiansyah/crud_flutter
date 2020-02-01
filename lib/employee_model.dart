class EmployeeModel {
//deklarasi variable
  String id;
  String employeeName;
  String employeeSalary;
  String employeeAge;
  String profileImage;


  //konstruktor
  EmployeeModel({this.id, this.employeeName, this.employeeSalary,
      this.employeeAge, this.profileImage});

  //FUNGSI INI UNTUK MENGUBAH FORMAT DATA DARI JSON KE FORMAT YANG SESUAI DENGAN EMPLOYEE MODEL
  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
      id: json['id'],
      employeeName: json['employee_name'],
      employeeSalary: json['employee_salary'],
      employeeAge: json['employee_age'],
      profileImage: json['profile_image']
  );

}