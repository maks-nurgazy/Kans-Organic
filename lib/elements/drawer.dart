import 'package:org_chemistry/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert';
import 'package:org_chemistry/elements/screenArguments.dart';
import 'package:rate_my_app/rate_my_app.dart';

class DefaultDrawer {
  static Drawer getDrawer(context, RateMyApp rateMyApp) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                    image: AssetImage("assets/images/drawer2.png"),
                    fit: BoxFit.cover)),
            child: null,
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/icons/book_content.svg',
              color: DefaultColors.drawerIcon,
              semanticsLabel: 'Contents',
              width: 25,
            ),
            title: Align(
              child: new Text(
                'Contents',
                style:
                    TextStyle(fontSize: 16.0, color: DefaultColors.drawerTitle),
              ),
              alignment: Alignment(-1.15, 0),
            ),
            onTap: () async {
              String data = await DefaultAssetBundle.of(context)
                  .loadString("assets/data/topics.json");
              final chapter = json.decode(data);

              Navigator.pushNamed(
                context,
                '/category',
                arguments: ScreenArguments(chapter),
              );
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/icons/person.svg',
              color: DefaultColors.drawerIcon,
              semanticsLabel: 'About',
              width: 23,
            ),
            title: Align(
              child: new Text(
                "About",
                style:
                    TextStyle(fontSize: 16.0, color: DefaultColors.drawerTitle),
              ),
              alignment: Alignment(-1.15, 0),
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          Divider(
            color: DefaultColors.divider,
          ),
          ListTile(
            title: new Text(
              "Communicate",
              style:
                  TextStyle(fontSize: 16.0, color: DefaultColors.drawerHeading),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/icons/rate.svg',
              color: DefaultColors.drawerIcon,
              semanticsLabel: 'Rate Us',
              width: 23,
            ),
            title: Align(
              child: new Text(
                "Rate Us",
                style:
                    TextStyle(fontSize: 16.0, color: DefaultColors.drawerTitle),
              ),
              alignment: Alignment(-1.15, 0),
            ),
            onTap: () {
              rateMyApp.showRateDialog(context).then((_) => {});
            },
          ),
        ],
      ),
    );
  }
}
