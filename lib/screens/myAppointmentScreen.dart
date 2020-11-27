import 'package:HomeTreatment/model/MyAppointmentModel.dart';
import 'package:HomeTreatment/provider/auth.dart';
import 'package:HomeTreatment/widgets/AppBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAppointmentScreen extends StatefulWidget {
  static const routeName = '/my-appointment-screen';

  @override
  _MyAppointmentScreenState createState() => _MyAppointmentScreenState();
}

class _MyAppointmentScreenState extends State<MyAppointmentScreen> {
  List<MyAppointmentModel> li = [];

  void getMyAppointmentList() async {
    li= await Provider.of<Auth>(context).getMyAppointmentList();
  }

  @override
  void initState() {
    super.initState();
  }

  bool _isloading = false;
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isloading == false) {
      getMyAppointmentList();
    }
    setState(() {
      
      _isloading=true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget.myAppBar(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                tileColor: Colors.white,
                title: Text(li[index].hospitalName,style:TextStyle(color: Theme.of(context).backgroundColor)),
                subtitle: Text(li[index].startTime),
                trailing: li[index].status ? Chip( backgroundColor: Colors.grey.shade400,  avatar: CircleAvatar(backgroundColor: Theme.of(context).primaryColor,), label: Text("Offline")) : Chip( backgroundColor: Colors.grey.shade400,  avatar: CircleAvatar(backgroundColor: Colors.green.shade700,), label: Text("Online")),
              ),
            );
          },
          itemCount: li.length,
        ),
      ),
    );
  }
}
