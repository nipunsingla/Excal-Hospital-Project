import 'package:HomeTreatment/model/SymptomsMode.dart';
import 'package:HomeTreatment/provider/auth.dart';
import 'package:HomeTreatment/widgets/AppBarWidget.dart';
import 'package:HomeTreatment/widgets/ProgessBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class SymptomsChecker extends StatefulWidget {
  @override
  _SymptomsCheckerState createState() => _SymptomsCheckerState();
}
class _SymptomsCheckerState extends State<SymptomsChecker> {

  List<SymptomsModel> li = [];
  bool flag=false;
  @override
  void initState() {
    super.initState();
    getSymtpomsList();
  }


  void getSymtpomsList() async {
    List<SymptomsModel> temp =
        await Provider.of<Auth>(context,listen: false).getListOfSymptoms();

   setState((){
     flag=true;
     li=temp;
     print(li);
   }); 
    print(li);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget.myAppBar(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: !flag
          ? ProgessBar()
          : Container(
              child:Text("hello")
            ),
    );
  }
}
