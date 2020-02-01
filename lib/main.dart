import 'package:crud/employee_add.dart';
import 'package:crud/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:crud/employee_model.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_)=>EmployeeProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Employee(),
      ),
    );
  }
}
class Employee extends StatelessWidget {
  final data = [
    EmployeeModel(
      id: "1",
      employeeName: "Tiger Nixon",
      employeeSalary: "320800",
      employeeAge: "61",
      profileImage: "",
    ),
    EmployeeModel(
      id: "2",
      employeeName: "Anugrah Sandi",
      employeeSalary: "40000",
      employeeAge: "25",
      profileImage: "",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CRUD'),),
      body: RefreshIndicator(
        onRefresh: () => Provider.of<EmployeeProvider>(context,listen: false).getEmployee(),
        color: Colors.purple,
        child: Container(
          margin: EdgeInsets.all(10),
          child: FutureBuilder(
            future: Provider.of<EmployeeProvider>(context, listen: false).getEmployee(),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Consumer<EmployeeProvider>(
                builder: (context, data,_){
                  return ListView.builder(
                      itemCount: data.dataEmployee.length,
                      itemBuilder: (context, i){
                        return Card(
                          elevation: 8,
                          child: ListTile(
                            leading: Text(data.dataEmployee[i].id),
                            title: Text(
                              data.dataEmployee[i].employeeName,
                            ),
                            subtitle: Text(
                              'Umur\t : \t '+data.dataEmployee[i].employeeAge,
                            ),
                            trailing: Text(
                              '\$${data.dataEmployee[i].employeeSalary}',
                            ),
                          ),
                        );
                      }
                  );
                  },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        child: Text('+'),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context)=>EmployeeAdd()
          ));
        },
      ),
    );
  }
}


