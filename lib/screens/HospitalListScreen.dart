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
    if(value==''){
      setState(() {
          
      });
    }
    else{
      print(value);
    List<HospitalModel> _lm=[];
      for(int i=0;i<_li.length;i++){
        if(_li[i].name.contains(t.text) || _li[i].city.contains(t.text) || _li[i].state.contains(t.text)){
          _lm.add(_li[i]);
        }
      }
      if(_lm.length==0){
      setState(() {
        
      });
      }
      else
      setState((){
        print(_lm);
        _li=_lm;
      });
    }
  }
  TextEditingController t=new TextEditingController();
  _HospitalListScreenState() {
    searchBar = new SearchBar(

        buildDefaultAppBar: buildAppBar,
        setState: setState,
        controller: t,
        onSubmitted: onSubmitted,
        hintText: t.text,
        onCleared: () {
          print("cleared");
        },
        onClosed: () {
          print("closed");
        });
  }

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text('Search Hospitals '),
        actions: [searchBar.getSearchAction(context)]);
  }

  Future<void> getList() async {
    List<HospitalModel> _getList =
        await Provider.of<Auth>(context, listen: false).getAllHospitalList();
    setState(() {
      _li = _getList;
    });
    print(_li);
  }

 

  @override
  void initState() {
    print(DateTime.now());
    super.initState();
  }
  bool _isload=false;
  void didChangeDependencies(){
    super.didChangeDependencies();
    if(_isload==false){
        getList();
  
    }
    _isload=true;
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
              height: 520,
              child: new ListView.builder(
                itemCount: _li.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  print(_li[index].imageUrl);
                  return Container(
                      height: 200, child: HospitalTile(_li[index]));
                },
              ),  
            ),
    );
  }
}
