import 'package:flutter/material.dart';
import 'package:stadium/config/config.dart';
import 'package:stadium/model/parameterModel.dart';

import '../database.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({this.user});

  final dynamic user;
  @override
  State<StatefulWidget> createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  saveUsername() async {
    print(
        "----------------------------Trying to save Username-----------------");
    Parameter userameParameter = new Parameter();
    userameParameter.parameterName = 'Username';
    userameParameter.parameterValue = widget.user['me']['Customer']['username'];
    print(userameParameter.parameterValue);
    print(
        "----------------------------Trying to store username-----------------");

    await DBProvider.db.newParameter(userameParameter);

    print(
        "----------------------------Username Stored successfully-----------------");

    print(
        "----------------------------Saved Username successfully-----------------");
  }

  @override
  void initState() {
    saveUsername();
    super.initState();
  }

  Widget _showImage() {
    return Center(
      child: new Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
          width: 190.0,
          height: 190.0,
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                  fit: BoxFit.fill,
                  image: widget.user["me"]["avatar"] == null
                      ? new NetworkImage("https://i.imgur.com/BoN9kdC.png")
                      : new NetworkImage(serverUrl +
                          widget.user["me"]["avatar"][0]["url"].toString())))),
      //image: new NetworkImage("https://i.imgur.com/BoN9kdC.png")))),
    );
  }

  Widget _showUsername() {
    return Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
        child: new Text(
          widget.user['me']['Customer']['username'],
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ));
  }

  Widget _showGender() {
    return Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          children: <Widget>[
            new Text(
              "Gender: ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            new Text(
              widget.user['me']['gender'] == 1
                  ? "Male"
                  : widget.user['me']['gender'] == 0 ? "Female" : "Other",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ));
  }

  Widget _showPhone() {
    return Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          children: <Widget>[
            new Text(
              "Phone: ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            new Text(
              widget.user['me']['phoneNo'],
              style: TextStyle(fontSize: 20),
            ),
          ],
        ));
  }

  Widget _showJoined() {
    return Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          children: <Widget>[
            new Text(
              "Member Since: ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            new Text(
              widget.user['me']['joined'],
              style: TextStyle(fontSize: 20),
            ),
          ],
        ));
  }

  Widget _showAbout() {
    return Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Wrap(
          direction: Axis.horizontal,
          children: <Widget>[
            new Text(
              "About: ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            new Text(
              widget.user['me']['about'] == null
                  ? "Tell us something about yourself!"
                  : widget.user['me']['about'],
              style: TextStyle(fontSize: 20),
            ),
          ],
        ));
  }

  Widget _showDob() {
    return Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          children: <Widget>[
            new Text(
              "Date of Birth: ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            new Text(
              widget.user['me']['DOB'],
              style: TextStyle(fontSize: 20),
            ),
          ],
        ));
  }

  Widget _showDivider() {
    return Divider(
      thickness: 3,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("My Profile"),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          _showImage(),
          _showUsername(),
          _showDivider(),
          _showGender(),
          _showDivider(),
          _showDob(),
          _showDivider(),
          _showPhone(),
          _showDivider(),
          _showJoined(),
          _showDivider(),
          _showAbout(),
        ],
      ),
    );
  }
}
