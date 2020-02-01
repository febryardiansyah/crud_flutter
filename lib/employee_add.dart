import 'package:flutter/material.dart';
import 'package:crud/main.dart';
import 'package:provider/provider.dart';
import 'package:crud/employee_provider.dart';

class EmployeeAdd extends StatefulWidget {
  @override
  _EmployeeAddState createState() => _EmployeeAddState();
}

class _EmployeeAddState extends State<EmployeeAdd> {
final TextEditingController _name = TextEditingController();
final TextEditingController _salary = TextEditingController();
final TextEditingController _age = TextEditingController();

FocusNode salaryNode;
FocusNode ageNode;

bool _isLoading = false;

final snackbarKey = GlobalKey<ScaffoldState>();

void submit(BuildContext context){
  if (!_isLoading){
    setState(() {
      _isLoading = true;
    });
  }
  Provider.of<EmployeeProvider>(context, listen: false).storeEmploye(_name.text, _salary.text, _age.text).then((res){
    if(res){
      Navigator.pop(context);
    }else{
      var snackbar = SnackBar(content: Text('Opps, hubungi admin lur !!'),);
      snackbarKey.currentState.showSnackBar(snackbar);
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: snackbarKey,
      appBar: AppBar(
        title: Text('Add Employee'),
        actions: <Widget>[
          FlatButton(
            child: _isLoading?CircularProgressIndicator(
             valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ):Icon(Icons.save,color: Colors.white,),
            onPressed: (){
              submit(context);
            },
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onSubmitted: (_){
                  FocusScope.of(context).requestFocus(salaryNode);
                },
                controller: _name,
                decoration: InputDecoration(
                  hintText: 'Nama Lengkap',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.purple
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.purple
                    )
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _salary,
                focusNode: salaryNode,
                onSubmitted: (_){
                  FocusScope.of(context).requestFocus(ageNode);
                },
                decoration: InputDecoration(
                  hintText: 'Gaji',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.purple
                    )
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _age,
                focusNode: ageNode,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.purple
                    )
                  ),
                  hintText: 'Umur',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
