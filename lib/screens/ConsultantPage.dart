import 'package:HomeTreatment/model/ConsultantModel.dart';
import 'package:HomeTreatment/provider/auth.dart';
import 'package:HomeTreatment/widgets/AppBarWidget.dart';
import 'package:HomeTreatment/widgets/ConsultantCard.dart';
import 'package:HomeTreatment/widgets/ProgessBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConsultantPage extends StatefulWidget {
  @override
  _ConsultantPageState createState() => _ConsultantPageState();
}

class _ConsultantPageState extends State<ConsultantPage> {
  List<ConsultantModel> li = [];

  void getConsultantList() async {
    print("kfndsknfjknk");
    List<ConsultantModel> temp;
    temp = await Provider.of<Auth>(context).getAllConsultants();
    setState(() {
      li = temp;
    });
  }

  void initState() {
    super.initState();
  }

  bool loaded = false;
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (loaded == false) {
      print("hello world");
      getConsultantList();
    }
    loaded = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget.myAppBar(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: li.length == 0
          ? ProgessBar()
          : Container(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ConsultantCard(
                      li[index].name, li[index].email, li[index].specilization);
                },
                itemCount: li.length,
              ),
            ),
    );
  }
}
