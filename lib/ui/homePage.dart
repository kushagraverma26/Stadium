import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:stadium/api/gamesApi.dart';
import 'package:stadium/api/merchandiseApi.dart';
import 'package:stadium/api/userApi.dart';
import 'package:stadium/ui/profilePage.dart';

import '../database.dart';

import 'dart:async';

import 'gamesListPage.dart';
import 'libraryPage.dart';
import 'merchandiseListPage.dart';

class ShowUp extends StatefulWidget {
  final Widget child;
  final int delay;

  ShowUp({@required this.child, this.delay});

  @override
  _ShowUpState createState() => _ShowUpState();
}

class _ShowUpState extends State<ShowUp> with TickerProviderStateMixin {
  AnimationController _animController;
  Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    _animController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    final curve =
        CurvedAnimation(curve: Curves.decelerate, parent: _animController);
    _animOffset =
        Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero)
            .animate(curve);

    if (widget.delay == null) {
      _animController.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay), () {
        _animController.forward();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
      opacity: _animController,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  int delayAmount = 600;

  /* List<Image> items = [
    Image.asset(
      'assets/images/img1.jpg',
      height: 200,
    ),
    Image.asset(
      'assets/images/img2.jpg',
      height: 200,
    ),
    Image.asset(
      'assets/images/img3.jpg',
      height: 200,
    ),
    Image.asset(
      'assets/images/img4.jpg',
      height: 200,
    ),
    Image.asset(
      'assets/images/img5.jpg',
      height: 200,
    ),
    Image.asset(
      'assets/images/img6.jpg',
      height: 200,
    ),
  ]; */

  List<Widget> items = [
    Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
        height: 200,
        decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
                image: AssetImage('assets/images/img1.jpg'),
                fit: BoxFit.fill))),
    Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
        height: 200,
        decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
                image: AssetImage('assets/images/img2.jpg'),
                fit: BoxFit.fill))),
    Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
        height: 200,
        decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
                image: AssetImage('assets/images/img3.jpg'),
                fit: BoxFit.fill))),
    Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
        height: 200,
        decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
                image: AssetImage('assets/images/img4.jpg'),
                fit: BoxFit.fill))),
    Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
        height: 200,
        decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
                image: AssetImage('assets/images/img5.jpg'),
                fit: BoxFit.fill))),
    Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
        height: 200,
        decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
                image: AssetImage('assets/images/img6.jpg'),
                fit: BoxFit.fill))),
  ];

  String username = "User";

  getUsername() async {
    print(
        "----------------------------Trying to get Username-----------------");

    dynamic use = await DBProvider.db.getParameter('Username');
    //print(use.parameterValue);
    if (use != Null) {
      setState(() {
        username = use.parameterValue;
      });
    }

    print(
        "----------------------------Got Username successfully-----------------");
  }

  @override
  void initState() {
    getUsername();
    super.initState();
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  Widget _showHeading() {
    return ShowUp(
      delay: delayAmount,
      child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
          child: new Text(
            "Welcome to Stadium!",
            style: TextStyle(fontSize: 28, fontStyle: FontStyle.italic),
          )),
    );
  }

  void toast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.grey,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  routeToProfile() async {
    setState(() {
      _isLoading = true;
    });
    QueryResult result = await profileData();
    if (result.hasErrors) {
      print("Sorry bruh...");
      toast(result.errors[0].toString());
    } else {
      dynamic user = result.data.data;
      setState(() {
        _isLoading = false;
      });

      var route = new MaterialPageRoute(
        builder: (BuildContext context) => new ProfilePage(
          user: user,
        ),
      );
      Navigator.of(context).push(route);
    }
  }

  _routeToGames() async {
    setState(() {
      _isLoading = true;
    });
    QueryResult result = await allGames();
    if (result.hasErrors) {
      print("Sorry bruh...");
      toast(result.errors[0].toString());
    } else {
      dynamic games = result.data.data;
      setState(() {
        _isLoading = false;
      });

      var route = new MaterialPageRoute(
        builder: (BuildContext context) => new GamesListPage(
          games: games,
        ),
      );
      Navigator.of(context).push(route);
    }
  }

  _routeToAllMerchandise() async {
    setState(() {
      _isLoading = true;
    });
    QueryResult result = await allMerchandise();
    if (result.hasErrors) {
      print("Sorry bruh...");
      toast(result.errors[0].toString());
    } else {
      dynamic allMerchandise = result.data.data;
      setState(() {
        _isLoading = false;
      });

      var route = new MaterialPageRoute(
        builder: (BuildContext context) => new MerchandiseListPage(
          allMerchandise: allMerchandise,
        ),
      );
      Navigator.of(context).push(route);
    }
  }

  _routeToLibrary() async {
    setState(() {
      _isLoading = true;
    });
    QueryResult result = await getUserId();
    if (result.hasErrors) {
      print("Sorry bruh...");
      toast(result.errors[0].toString());
    } else {
      int id = int.parse(result.data.data['me']['id']);
      print(id);

      QueryResult library = await getLibrary(id);
      if (result.hasErrors) {
        print("Sorry bruh...");
        toast(library.errors[0].toString());
      } else {
        dynamic libraryData = library.data.data;
        setState(() {
          _isLoading = false;
        });
        print(libraryData);

        var route = new MaterialPageRoute(
          builder: (BuildContext context) => new LibraryPage(
            library: libraryData,
          ),
        );
        Navigator.of(context).push(route);
      }
    }
  }

  Widget _showBody() {
    return new Container(
        padding: EdgeInsets.zero,
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.zero,
                child: CarouselSlider(
                  items: items,
                  height: 200,

                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 2),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  pauseAutoPlayOnTouch: Duration(seconds: 10),
                  enlargeCenterPage: true,
                  //onPageChanged: callbackFunction,
                  scrollDirection: Axis.horizontal,
                )),
            _showHeading(),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(centerTitle: true, title: new Text("Home")),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Hello, $username',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      title: Text(
                        'My Profile',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onTap: () {
                        routeToProfile();
                      },
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.games,
                ),
                title: Text(
                  'Games',
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  _routeToGames();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.store,
                ),
                title: Text(
                  'Merchandise',
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  _routeToAllMerchandise();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.library_books,
                ),
                title: Text(
                  'Library',
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  _routeToLibrary();
                },
              ),
              Divider(
                height: 15,
                thickness: 3,
              ),
              ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            _showBody(),
            _showCircularProgress(),
          ],
        ));
  }
}
