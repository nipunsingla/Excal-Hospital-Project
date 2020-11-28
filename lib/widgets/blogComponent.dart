import 'package:HomeTreatment/model/ErrorModel.dart';
import 'package:HomeTreatment/model/blogModel.dart';
import 'package:HomeTreatment/provider/auth.dart';
import 'package:HomeTreatment/screens/MainScreen.dart';
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

  List<bool> temp = new List(10);

  Future<void> getAllBlogs() async {
    print("hello");
    List<BlogModel> _getBlogs =
        await Provider.of<Auth>(context, listen: false).getBlogs();
    setState(() {
      li = _getBlogs;
      temp = new List(li.length);
      for (int i = 0; i < temp.length; i++) {
        temp[i] = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  bool loaded = false;

  void didChangeDependencies() {
    super.didChangeDependencies();
    if (loaded == false) {
      getAllBlogs();
    }
    setState(() {
      loaded = true;
    });
  }

  Future<void> deleteBlogs(String id) async {
    print("hello");
    ErrorModel lm =
        await Provider.of<Auth>(context, listen: false).deleteBlogs(id);
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
                  height: 600,
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
                                label: FittedBox(
                                  child: Text(
                                    li[index].userName == null
                                        ? ""
                                        : li[index].title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(
                                  li[index].imageUrl,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        temp[index]
                                            ? li[index].description
                                            : (200>li[index].description.length?li[index]
                                                .description:li[index].description
                                                .substring(0, 200)),
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            temp[index] = !temp[index];
                                          });
                                        },
                                        child: Text(
                                          temp[index]
                                              ? "Read Less"
                                              : "Read More ...",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              decoration:
                                                  TextDecoration.underline,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                      child: FavoriteButton(
                                        iconSize: 50,
                                        iconColor:
                                            Theme.of(context).primaryColor,
                                        valueChanged: () {},
                                      ),
                                      flex: 3),
                                  Expanded(
                                      child: InkWell(
                                        onTap: () async {
                                          ErrorModel lm = await Provider.of<
                                                  Auth>(context, listen: false)
                                              .deleteBlogs(li[index].blogID);
                                          print(lm);
                                          if (lm.status) {
                                            getAllBlogs();
                                          } else {
                                            print(lm.message);
                                            Scaffold.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  lm.message,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          size: 30,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                      flex: 3),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
  }
}
