import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_card.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
          return Scaffold( body: BusinessCard(), appBar: AppBar(title: Text('Business Card'),),);
        },),);
      }, child: Text('Add')),
    );
  }
}