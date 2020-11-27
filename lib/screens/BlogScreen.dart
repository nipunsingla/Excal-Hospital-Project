import 'dart:io';

import 'package:HomeTreatment/model/ErrorModel.dart';
import 'package:HomeTreatment/provider/auth.dart';
import 'package:HomeTreatment/screens/MainScreen.dart';
import 'package:HomeTreatment/widgets/AppBarWidget.dart';
import 'package:HomeTreatment/widgets/InputTextFieldWidget.dart';
import 'package:HomeTreatment/widgets/blogComponent.dart';
import 'package:HomeTreatment/widgets/profileIcon.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class BlogScreen extends StatefulWidget {
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  File image;
  TextEditingController _titleController;
  TextEditingController _descController;
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
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text("Blogs"),
        actions: [
          InkWell(
            child: Icon(Icons.add),
            onTap: () {
              showDialog(
                
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Theme.of(context).backgroundColor,
                      content: Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Positioned(
                            right: -40.0,
                            top: -40.0,
                            child: InkResponse(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: CircleAvatar(
                                child: Icon(Icons.close),
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ),
                          Form(
                            child: SingleChildScrollView(
                                                          child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: InputTextFieldWidget("Title",_titleController,Icons.title,TextInputType.name)
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: InputTextFieldWidget("Description",_descController,Icons.description,TextInputType.name)
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: ProfileIcon(
                                        _cameraUpload, _galleryUpload, image),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RaisedButton(
                                      child: Text("Submitß"),
                                      onPressed: () async {
                                        ErrorModel lm =
                                            await Provider.of<Auth>(context,listen:false)
                                                .addBlogs(
                                                    _titleController.text,
                                                    _descController.text,
                                                    image.path);
                                        if (lm.status == false) {
                                          Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                lm.message,
                                                style: TextStyle(
                                                    color: Colors.amber),
                                              ),
                                            ),
                                          );
                                        } else {
                                          Navigator.of(context).pop();
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  MainScreen.routeName);
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            },
          )
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: BlogComponent(),
    );
  }
}
