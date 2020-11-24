import 'package:HomeTreatment/model/hospitalModel.dart';
import 'package:HomeTreatment/provider/auth.dart';
import 'package:HomeTreatment/widgets/AppBarWidget.dart';
import 'package:HomeTreatment/widgets/Loader.dart';
import 'package:HomeTreatment/widgets/ProgessBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HospitalListScreen extends StatefulWidget {
  @override
  _HospitalListScreenState createState() => _HospitalListScreenState();
}

class _HospitalListScreenState extends State<HospitalListScreen> {
  @override
  Widget build(BuildContext context) {
    List<HospitalModel> _li;
    void getList() async {
      _li = await Provider.of<Auth>(context, listen: false).getHospitalList();
    }

    void initState() {
      getList();
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBarWidget.myAppBar(),
      body: Loader.isLoading
          ? ProgessBar()
          : Container(
              child: Text('Helloo'),
            ),
    );
  }
}
