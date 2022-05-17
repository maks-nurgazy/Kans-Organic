import 'dart:convert';
import 'package:org_chemistry/config/colors.dart';
import 'package:org_chemistry/Screens/remarks.dart';
import 'package:org_chemistry/elements/screenArguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mime_type/mime_type.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'dart:io'
    show
        HttpRequest,
        HttpResponse,
        HttpServer,
        HttpStatus,
        InternetAddress,
        Platform;
import 'package:flutter/services.dart' show rootBundle;

import 'package:share/share.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String icon;
  final String route;
  final Orientation orientation;
  final int index;

  CardWidget(this.title, this.icon, this.route, this.orientation, this.index);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          margin: EdgeInsets.only(
              left: (this.orientation == Orientation.portrait
                  ? (this.index % 2 == 0 ? 3 : 8)
                  : ([2, 5].contains(this.index)
                      ? 3
                      : (this.index % 3 == 0 ? 3 : 8))),
              right: (this.orientation == Orientation.portrait
                  ? (this.index % 2 == 0 ? 8 : 3)
                  : ([2, 5].contains(this.index)
                      ? 3
                      : (this.index % 3 == 0 ? 8 : 3))),
              top: 0,
              bottom: 6),
          padding: const EdgeInsets.only(
              top: 15.0, bottom: 5.0, left: 10, right: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromRGBO(55, 137, 253, 1),
              width: 1.0,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 1),
                blurRadius: 5.0, // has the effect of softening the shadow
                spreadRadius: -3.0, // has the effect of extending the shadow
                offset: Offset(
                  0.0, // horizontal, move right 10
                  0.0, // vertical, move down 10
                ),
              )
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SvgPicture.asset(
                  'assets/icons/' + this.icon + '.svg',
                  color: Color.fromRGBO(55, 137, 253, 1),
                  semanticsLabel: this.title,
                  width: this.index == 2
                      ? 45
                      : this.index == 4
                          ? 55
                          : 50,
                ),
                Container(
                  margin: EdgeInsets.only(top: this.index == 2 ? 10.0 : 13.0),
                  child: Text(
                    this.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromRGBO(55, 137, 253, 1),
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        onTap: () async {
          switch (this.index) {
            case 1:
              {
                String data = await DefaultAssetBundle.of(context)
                    .loadString("assets/data/topics.json");
                final chapter = json.decode(data);
                chapter['type'] = 'solutions';
                Navigator.pushNamed(
                  context,
                  '/category',
                  arguments: ScreenArguments(chapter),
                );
              }
              break;

            case 2:
              {
                String data = await DefaultAssetBundle.of(context)
                    .loadString("assets/data/solutions.json");
                final chapter = json.decode(data);

                Navigator.pushNamed(
                  context,
                  '/category',
                  arguments: ScreenArguments(chapter,
                      color: Colors.white,
                      backgroundColor: Color.fromRGBO(33, 150, 243, 0.6),
                      type: 'solutions'),
                );
              }
              break;

            case 3:
              {
                String data = await DefaultAssetBundle.of(context)
                    .loadString("assets/data/video.json");
                final chapter = json.decode(data);

                Navigator.pushNamed(
                  context,
                  '/videos',
                  arguments: ScreenArguments(chapter),
                );
              }
              break;
            case 4:
              {
                String data = await DefaultAssetBundle.of(context)
                    .loadString("assets/data/quizzes.json");
                final chapter = json.decode(data);

                Navigator.pushNamed(
                  context,
                  '/category',
                  arguments: ScreenArguments(chapter,
                      color: Color.fromRGBO(55, 100, 253, 1), type: 'quizzes'),
                );
              }
              break;

            case 5:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RemarksScreen()),
              );
              break;
            case 6:
              if (Platform.isAndroid) {
                Share.share(
                    'Download Integral org_chemistry App free at http://play.google.com/store/apps/details?id=com.aiu.integral.org_chemistry',
                    subject: 'App Sharing');
              } else if (Platform.isIOS) {
                Share.share(
                    'Download Integral org_chemistry App free at https://apps.apple.com/us/app/keynote/id361285480',
                    subject: 'App Sharing');
              }
              break;

            default:
              {}
          }
        });
  }
}

class MainScreen extends StatefulWidget {
  final RateMyApp rateMyApp;
  MainScreen({Key key, this.rateMyApp}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isSplashScreen = true;
  double pixelRatio = 0;

  _sendNotFound(HttpResponse response) {
    response.statusCode = HttpStatus.notFound;
    response.write('Not found');
    response.close();
  }

  _handleGet(HttpRequest request) async {
    rootBundle.load('assets' + request.uri.path).then((value) {
      String mimeType = mime(request.uri.path);
      if (mimeType == null) mimeType = 'text/plain; charset=UTF-8';
      request.response.statusCode = HttpStatus.ok;
      request.response.headers.set('Content-Type', mimeType);
      request.response.headers.add("Access-Control-Allow-Origin", "*");
      request.response.headers.add("Access-Control-Allow-Methods", "*");
      request.response.headers.add("Access-Control-Allow-Headers", "*");

      String s = new String.fromCharCodes(value.buffer.asUint8List());
      request.response.write(s);
      request.response.close();
    }).catchError((_) {
      _sendNotFound(request.response);
    });
  }

  void server() async {
    var server = await HttpServer.bind(
      InternetAddress.loopbackIPv4,
      64033,
    );

    await for (HttpRequest request in server) {
      switch (request.method) {
        case 'GET':
          _handleGet(request);
          break;

        default:
          request.response.statusCode = HttpStatus.methodNotAllowed;
          request.response.close();
      }
//
//      request.response.headers.add('Access-Control-Allow-Origin', '*');
//      request.response.headers.add('Access-Control-Allow-Methods', 'POST, OPTIONS');
//      request.response.headers.add('Access-Control-Allow-Headers', 'Origin, X-Requested-with, Content-Type, Accept');
//      request.response.statusCode = HttpStatus.ok;

    }
  }

  @override
  void initState() {
    server();
    super.initState();
    new Future.delayed(const Duration(milliseconds: 4000), () {
      setState(() {
        this.isSplashScreen = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (this.pixelRatio == 0) {
      this.pixelRatio = MediaQuery.of(context).devicePixelRatio;
    }
    return isSplashScreen
        ? Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff00466c), Color(0xff71a5c2)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                  width: 350,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/cover.png"),
                          fit: BoxFit.contain))),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('ОРГАНИКАЛЫК ХИМИЯ'),
            ),
            body: OrientationBuilder(builder: (context, orientation) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Hero(
                            tag: 'searchBar',
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 8),
                              child: Material(
                                  color: Colors.transparent,
                                  child: GestureDetector(
                                    child: TextFormField(
                                      cursorColor:
                                          Color.fromRGBO(70, 70, 70, 1),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        prefixIcon: Icon(
                                          Icons.search,
                                          color: Color.fromRGBO(70, 70, 70, 1),
                                          size: 25,
                                        ),
                                        filled: true,
                                        fillColor:
                                            Color.fromRGBO(235, 235, 235, 1),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        disabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        contentPadding: const EdgeInsets.only(
                                            top: 12,
                                            bottom: 0,
                                            left: 0,
                                            right: 10),
                                        hintText: 'Издөө...',
                                        hintStyle: TextStyle(
                                            color:
                                                Color.fromRGBO(70, 70, 70, 1)),
                                      ),
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          color: Color.fromRGBO(50, 50, 50, 1)),
                                      enabled: false,
                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/search',
                                      );
                                    },
                                    behavior: HitTestBehavior.translucent,
                                  )),
                            )),
                      ]),
                    ),
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              orientation == Orientation.portrait ? 2 : 3,
                          childAspectRatio:
                              orientation == Orientation.portrait ? 1.55 : 1.9),
                      delegate: SliverChildListDelegate([
                        CardWidget('Темалар', 'integral', '', orientation, 1),
                        CardWidget('Лабораториялык иштер', 'solution', '',
                            orientation, 2),
                        CardWidget('Терминдер', 'symbol', '', orientation, 3),
                        CardWidget('Сынактар', 'quizzes', '', orientation, 4),
                        CardWidget('Эскертмелер', 'star', '', orientation, 5),
                        CardWidget(
                            'Шарттуу белгилер', 'share', '', orientation, 6),
                      ]),
                    ),
                  ],
                ),
              );
            }),
            drawer: Drawer(
              // Add a ListView to the drawer. This ensures the user can scroll
              // through the options in the drawer if there isn't enough vertical
              // space to fit everything.
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                            image: AssetImage("assets/images/drawer3.png"),
                            fit: BoxFit.cover),
                        border: null),
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
                        'Контенттер',
                        style: TextStyle(
                            fontSize: 16.0, color: DefaultColors.drawerTitle),
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
                        "Китеп жөнүндө",
                        style: TextStyle(
                            fontSize: 16.0, color: DefaultColors.drawerTitle),
                      ),
                      alignment: Alignment(-1.15, 0),
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/about',
                      );
                    },
                  ),
                  Divider(
                    color: DefaultColors.divider,
                  ),
                  ListTile(
                    title: new Text(
                      "**********",
                      style: TextStyle(
                          fontSize: 16.0, color: DefaultColors.drawerHeading),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 20),
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
                        "Бизге баа бер",
                        style: TextStyle(
                            fontSize: 16.0, color: DefaultColors.drawerTitle),
                      ),
                      alignment: Alignment(-1.15, 0),
                    ),
                    onTap: () {
                      this
                          .widget
                          .rateMyApp
                          .showRateDialog(context)
                          .then((_) => {});
                    },
                  ),
                ],
              ),
            ),
          );
  }
}
