import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SkinDiseasesIcon extends StatelessWidget {
  final Function _cameraUpload;
  final Function _galleryUpload;
  final File _image;
  SkinDiseasesIcon(this._cameraUpload, this._galleryUpload, this._image);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            backgroundColor: Colors.black,
            builder: (context) {
              return Container(
                margin:EdgeInsets.only(bottom:300),
                height: 40,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Container(
                          child: ListView(
                        children: <Widget>[
                          Center(
                            child: InkWell(
                                onTap: _cameraUpload,
                                child: Icon(Icons.camera,color:Colors.white,size:40)),
                          ),
                        ],
                      )),
                    ),
                    Flexible(
                      child: Container(
                          child: ListView(
                        children: <Widget>[
                          Center(
                            child: InkWell(
                              onTap: _galleryUpload,
                              child: Icon(Icons.photo,color:Colors.white,size:40),
                            ),
                          ),
                        ],
                      )),
                    )
                  ],
                ),
              );
            });
      },
      child: Stack(children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 3,
          child: Container(
              width: 90,
              height: 90,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: _image == null
                  ? Image.network(
                      'https://devshift.biz/wp-content/uploads/2017/04/profile-icon-png-898.png')
                  : Image.file(_image)),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Icon(Icons.edit),
        ),
      ]),
    );
  }
}
