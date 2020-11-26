import 'package:HomeTreatment/widgets/AppBarWidget.dart';
import 'package:HomeTreatment/widgets/blogComponent.dart';
import 'package:flutter/material.dart';

class BlogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget.myAppBar(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: BlogComponent(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
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
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(
                                child: Text("Submitß"),
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}

