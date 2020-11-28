import 'package:HomeTreatment/model/SymptomsMode.dart';
import 'package:HomeTreatment/screens/BlogScreen.dart';
import 'package:HomeTreatment/screens/ConsultantPage.dart';
import 'package:HomeTreatment/screens/HospitalListScreen.dart';
import 'package:HomeTreatment/screens/MorePage.dart';
import 'package:HomeTreatment/screens/SymptomsChecker.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main-screen';
  final BuildContext menuScreenContext;
  MainScreen({Key key, this.menuScreenContext}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PersistentTabController _controller;
  bool _hideNavBar;
  List<SymptomsModel> li = [];

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  List<Widget> _buildScreens() {
    return [
      HospitalListScreen(),
      SymptomsChecker(),
      BlogScreen(),
      ConsultantPage(),
      MorePage()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: "Home",
        activeColor: Theme.of(context).primaryColor,
        inactiveColor: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.search),
        title: ("Symptoms"),
        activeColor: Theme.of(context).primaryColor,
        inactiveColor: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.list, color: Colors.white),
        title: ("Blogs"),
        activeColor: Theme.of(context).primaryColor,
        inactiveColor: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.message),
        title: ("Consultants"),
        activeColor: Theme.of(context).primaryColor,
        inactiveColor: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.more),
        title: ("More"),
        activeColor: Theme.of(context).primaryColor,
        inactiveColor: Colors.white,
      ),
    ];
  }

  var _selectedPage = 0;
  void _navigate(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('This is the Drawer'),
            ],
          ),
        ),
      ),
      body: _buildScreens()[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _navigate,
        backgroundColor: Theme.of(context).backgroundColor,
        type: BottomNavigationBarType.shifting,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.red,
        currentIndex: _selectedPage,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).backgroundColor,
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).backgroundColor,
            icon: Icon(Icons.search),
            label: "Symptoms",
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).backgroundColor,
            icon: Icon(Icons.list),
            label: "Blogs",
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).backgroundColor,
            icon: Icon(Icons.message),
            label: "Consultants",
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).backgroundColor,
            icon: Icon(Icons.more),
            label: "More",
          ),
        ],
      ),
    );
  }
}
/*
body: PersistentTabView(
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Theme.of(context).backgroundColor,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: false,
        hideNavigationBarWhenKeyboardShows: true,
        hideNavigationBar: _hideNavBar,
        margin: EdgeInsets.all(10.0),
        popActionScreens: PopActionScreensType.once,
        bottomScreenMargin: 0.0,

        // onWillPop: () async {
        //   await showDialog(
        //     context: context,
        //     useSafeArea: true,
        //     builder: (context) => Container(
        //       height: 50.0,
        //       width: 50.0,
        //       color: Colors.white,
        //       child: RaisedButton(
        //         child: Text("Close"),
        //         onPressed: () {
        //           Navigator.pop(context);
        //         },
        //       ),
        //     ),
        //   );
        //   return false;
        // },
        decoration: NavBarDecoration(
          colorBehindNavBar: Colors.indigo,
          borderRadius: BorderRadius.circular(20.0),
        ),
        popAllScreensOnTapOfSelectedTab: true,
        itemAnimationProperties: ItemAnimationProperties(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style15, // Choose the nav bar style with this property
      ),
*/
/*
body: _buildScreens()[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _navigate,
        backgroundColor: Theme.of(context).backgroundColor,
        type: BottomNavigationBarType.shifting,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.red,
        currentIndex: _selectedPage,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).backgroundColor,
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).backgroundColor,
            icon: Icon(Icons.search),
            label: "Symptoms",
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).backgroundColor,
            icon: Icon(Icons.list),
            label: "Blogs",
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).backgroundColor,
            icon: Icon(Icons.message),
            label: "Consultants",
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).backgroundColor,
            icon: Icon(Icons.more),
            label: "More",
          ),
        ],
      ),
*/
