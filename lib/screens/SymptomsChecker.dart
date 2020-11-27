import 'dart:io';
import 'package:HomeTreatment/model/SymptomsMode.dart';
import 'package:HomeTreatment/provider/auth.dart';
import 'package:HomeTreatment/widgets/AppBarWidget.dart';
import 'package:HomeTreatment/widgets/ProgessBar.dart';
import 'package:HomeTreatment/widgets/skinDiseases.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SymptomsChecker extends StatefulWidget {
  @override
  _SymptomsCheckerState createState() => _SymptomsCheckerState();
}

class _SymptomsCheckerState extends State<SymptomsChecker> {
  List<SymptomsModel> li = [];
  List<bool> flag;
  List<String> dis = [];
  @override
  void initState() {
    super.initState();
  }

  bool loaded = false;
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (loaded == false) {
      getSymtpomsList();
    }
    loaded = true;
  }

  void getSymtpomsList() async {
    List<SymptomsModel> temp =
        await Provider.of<Auth>(context, listen: false).getListOfSymptoms();

    setState(() {
      li = temp;
      flag = new List(li.length);
      for (int i = 0; i < flag.length; i++) {
        flag[i] = false;
      }
      print(li);
    });
    print(li);
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget.myAppBar(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: li.length == 0
          ? ProgessBar()
          : Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Symptoms"),
                  Container(
                    height: 100,
                    child: ListView.builder(
                      itemCount: li.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        print("dnks");
                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: InkWell(
                            splashColor: Theme.of(context).backgroundColor,
                            onTap: () {
                              setState(() {
                                flag[index] = !flag[index];
                              });
                            },
                            child: Chip(
                                elevation: 3,
                                avatar: CircleAvatar(
                                    backgroundColor: !flag[index]
                                        ? Colors.grey.shade800
                                        : Theme.of(context).primaryColor,
                                    child: Icon(Icons
                                        .subdirectory_arrow_right_outlined)),
                                label: Text(li[index].name)),
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: SkinDiseasesIcon(
                              _cameraUpload, _galleryUpload, image),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: RaisedButton(
                              color: Theme.of(context).primaryColor,
                              elevation: 4,
                              child: Text(
                                "Check Symptoms",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                List<int> temp = [];
                                for (int i = 0; i < flag.length; i++) {
                                  if (flag[i]) {
                                    temp.add(li[i].id);
                                  }
                                }
                                print(temp);
                                var x = await Provider.of<Auth>(context,
                                        listen: false)
                                    .getListOfIssues(temp);
                                print(x);
                                if (x != null && x.length > 0) {
                                  setState(() {
                                    dis = x;
                                  });
                                }
                              }),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("List of Diseases",
                        style: TextStyle(color: Colors.white, fontSize: 30)),
                  ),
                  dis.length == 0
                      ? SizedBox()
                      : Container(
                          height: 300,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              print(dis[index]);
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: InkWell(
                                    onTap: () async {
                                      String url =
                                          'http://www.google.com/search?q=${dis[index]}';
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                    child: Text(
                                      dis[index],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: dis.length,
                          ),
                        )
                ],
              ),
            ),
    );
  }
}
