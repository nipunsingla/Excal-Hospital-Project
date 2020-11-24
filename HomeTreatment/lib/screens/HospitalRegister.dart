import 'dart:io';
import 'package:HomeTreatment/provider/auth.dart';
import 'package:HomeTreatment/screens/MainScreen.dart';
import 'package:HomeTreatment/widgets/AppBarWidget.dart';
import 'package:HomeTreatment/widgets/ProgessBar.dart';
import 'package:HomeTreatment/widgets/profileIcon.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/rendering.dart';
import '../widgets/InputTextFieldWidget.dart';

class HospitalRegister extends StatefulWidget {
  static const routeName = '/sign-up';

  @override
  _HospitalRegisterState createState() => _HospitalRegisterState();
}

class _HospitalRegisterState extends State<HospitalRegister> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  void _onLoading() {
    setState(() {
      _loading = !_loading;
    });
  }

  final TextEditingController _nameController = new TextEditingController();

  final TextEditingController _meetLinkController = new TextEditingController();

  final TextEditingController _hospitalUrl = new TextEditingController();

  final TextEditingController _stateController = new TextEditingController();

  final TextEditingController _cityController = new TextEditingController();

  final TextEditingController _descController = new TextEditingController();
  final picker = ImagePicker();
  File image;
  void _galleryUpload() async {
    final imagefile =
        await ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: 300);
    print(imagefile);
    if (imagefile != null) {
      setState(() {
        image = File(imagefile.path);
      });
    }
  }

  void _showTimePickerStart() async {
    TimeOfDay s = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });
    if (s != null) {
      setState(() {
        _startTime = s;
        print(s);
      });
    }
  }

  void _showTimePickerEnd() async {
    TimeOfDay s = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });
    if (s != null) {
      setState(() {
        _startTime = s;
        print(s);
      });
    }
  }

  void _cameraUpload() async {
    final imagefile =
        await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 300);
    print(imagefile);
    if (imagefile != null) {
      setState(() {
        image = File(imagefile.path);
      });
    }
  }

  TimeOfDay _startTime;
  TimeOfDay _endTime;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBarWidget.myAppBar(),
        backgroundColor: Theme.of(context).backgroundColor,
        body: _loading
            ? ProgessBar()
            : Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                            child: Text(
                          "Add Hospital",
                          style: Theme.of(context).textTheme.headline4,
                        )),
                      ),
                      ProfileIcon(_cameraUpload, _galleryUpload, image),
                      InputTextFieldWidget("Name", _nameController,
                          Icons.perm_identity, TextInputType.name),
                      InputTextFieldWidget("Meeting Link", _meetLinkController,
                          Icons.video_call, TextInputType.url),
                      InputTextFieldWidget("State", _stateController,
                          Icons.location_city, TextInputType.name),
                      InputTextFieldWidget("City", _cityController,
                          Icons.location_city, TextInputType.name),
                      InputTextFieldWidget("Website", _hospitalUrl, Icons.web,
                          TextInputType.name),
                      InputTextFieldWidget("Description", _descController,
                          Icons.details, TextInputType.name),
                      Row(children: <Widget>[
                        Expanded(
                            child: InkWell(
                              onTap: _showTimePickerStart,
                              child: Column(children: [
                                Icon(Icons.more_time,
                                    size: 40, color: Colors.white),
                                Text('Opening',
                                    style:
                                        Theme.of(context).textTheme.subtitle1)
                              ]),
                            ),
                            flex: 5),
                        Expanded(
                            child: InkWell(
                              onTap: _showTimePickerEnd,
                              child: Column(children: [
                                Icon(Icons.more_time,
                                    size: 40, color: Colors.white),
                                Text('Closing',
                                    style:
                                        Theme.of(context).textTheme.subtitle1)
                              ]),
                            ),
                            flex: 5),
                      ]),
                    ],
                  ),
                ),
              ),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            onPressed: () async {
              print("hello");
              if (_formKey.currentState.validate()) {
                print(_nameController.text +
                    " " +
                    _stateController.text +
                    " " +
                    _cityController.text +
                    " " +
                    _meetLinkController.text +
                    " " +
                    _hospitalUrl.text +
                    " " +
                    _descController.text);
                print(image);
                final now = new DateTime.now();
                DateTime t1 = DateTime(now.year, now.month, now.day,
                    _startTime.hour, _startTime.minute);
                String strTime = (DateFormat("hh:mm:ss").format(t1));
                String endTime = (DateFormat("hh:mm:ss").format(t1));
                t1 = DateTime(now.year, now.month, now.day, _endTime.hour,
                    _endTime.minute);
                print(DateFormat("hh:mm:ss").format(t1));

                await Provider.of<Auth>(context, listen: false)
                    .registerHospital(
                        _nameController.text,
                        _cityController.text,
                        _stateController.text,
                        _descController.text,
                        _meetLinkController.text,
                        strTime,
                        endTime,
                        image.path,
                        _hospitalUrl.text);
              } else {
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('Eroooorr')));
              }
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(Icons.login),
          );
        }),
      ),
    );
  }
}
