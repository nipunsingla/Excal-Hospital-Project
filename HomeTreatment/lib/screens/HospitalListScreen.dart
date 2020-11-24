import 'package:HomeTreatment/model/hospitalModel.dart';
import 'package:HomeTreatment/provider/auth.dart';
import 'package:HomeTreatment/widgets/AppBarWidget.dart';
import 'package:HomeTreatment/widgets/Loader.dart';
import 'package:HomeTreatment/widgets/ProgessBar.dart';
import 'package:HomeTreatment/widgets/hospitalTile.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class HospitalListScreen extends StatefulWidget {
  @override
  _HospitalListScreenState createState() => _HospitalListScreenState();
}

class _HospitalListScreenState extends State<HospitalListScreen> {
  List<HospitalModel> _li = [];

  Future<void> getList() async {
    List<HospitalModel> _getList= await Provider.of<Auth>(context, listen: false).getHospitalList();
   setState((){
     
    _li =_getList;
   });
    print(_li);
  }

  @override
  void initState() {
    super.initState();
    print("hello");
    getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBarWidget.myAppBar(),
      body: _li.length == 0
          ? ProgessBar()
          : Container(
              child: new ListView.builder(
                itemCount: _li.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  print(_li[index].imageUrl);
                  return Container(
                    height: 200,
                    child: HospitalTile(_li[index]));
                },
              ),
            ),
    );
  }
}
