import 'package:HomeTreatment/model/blogModel.dart';
import 'package:HomeTreatment/provider/auth.dart';
import 'package:HomeTreatment/widgets/ProgessBar.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogComponent extends StatefulWidget {
  @override
  _BlogComponentState createState() => _BlogComponentState();
}

class _BlogComponentState extends State<BlogComponent> {
  List<BlogModel> li = [];
  Future<void> getAllBlogs() async {
    print("hello");
    List<BlogModel> _getBlogs =
        await Provider.of<Auth>(context, listen: false).getBlogs();
    setState(() {
      li = _getBlogs;
    });
  }

  @override
  void initState() {
    super.initState();
    getAllBlogs();
  }

  @override
  Widget build(BuildContext context) {
    return li.length == 0
        ? ProgessBar()
        : SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 500,
                    child: ListView.builder(
                      itemCount: li.length,
                      itemBuilder: (context, index) {
                        print(li[index]);
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                              elevation: 4,
                              child: Column(
                                children: <Widget>[
                                  Chip(
                                    avatar: CircleAvatar(
                                      child: Icon(Icons.local_hospital),
                                      backgroundColor: Colors.grey.shade400,
                                      foregroundColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                    label: Text(
                                        li[index].userName == null
                                            ? ""
                                            : li[index].userName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(li[index].imageUrl,
                                        fit: BoxFit.contain),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(li[index].description,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .primaryColor))),
                                  ),
                                  Row(children: <Widget>[
                                    Expanded(
                                        child:  FavoriteButton(

                                          iconSize: 50,
                                          iconColor: Theme.of(context).primaryColor,
            valueChanged: () {
            },
          ),
                                      
                                        flex: 3),
                                    Expanded(
                                        child: Icon(Icons.edit, size: 30,color:Colors.grey.shade600,
                                      ),
                                        flex: 3),
                                    Expanded(
                                        child: Icon(Icons.delete, size: 30,color:Colors.grey.shade600,
                                      ),
                                        flex: 3)
                                  ])
                                ],
                              )),
                        );
                      },
                    ),
                  )
                ]),
          );
  }
}
