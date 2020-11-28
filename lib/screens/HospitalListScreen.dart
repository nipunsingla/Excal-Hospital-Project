import 'package:HomeTreatment/model/hospitalModel.dart';
import 'package:HomeTreatment/provider/auth.dart';
import 'package:HomeTreatment/widgets/ProgessBar.dart';
import 'package:HomeTreatment/widgets/hospitalTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

import 'package:provider/provider.dart';

class HospitalListScreen extends StatefulWidget {
  @override
  _HospitalListScreenState createState() => _HospitalListScreenState();
}

class _HospitalListScreenState extends State<HospitalListScreen> {
  List<HospitalModel> _li = [];
  SearchBar searchBar;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void onSubmitted(String value) {
    setState(() => _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text('You wrote $value!'))));
  }

  _HospitalListScreenState() {
    searchBar = new SearchBar(
      inBar: false,
      buildDefaultAppBar: buildAppBar,
      setState: setState,
      onSubmitted: onSubmitted,
      onCleared: () {
        print("cleared");
      },
      onClosed: () {
        print("closed");
      },
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
      title: new Text('Search Hospitals'),
      actions: [
        searchBar.getSearchAction(context),
      ],
    );
  }

  Future<void> getList() async {
    List<HospitalModel> _getList =
        await Provider.of<Auth>(context, listen: false).getAllHospitalList();
    setState(() {
      _li = _getList;
    });
  }

  @protected
  @mustCallSuper
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  bool _isload = false;
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isload == false) {
      getList();
    }
    _isload = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar.build(context),
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      body: _li.length == 0
          ? ProgessBar()
          : Container(
              height: 650,
              child: new ListView.builder(
                itemCount: _li.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Container(
                    height: MediaQuery.of(context).size.height / 4,
                    child: HospitalTile(_li[index]),
                  );
                },
              ),
            ),
    );
  }
}
