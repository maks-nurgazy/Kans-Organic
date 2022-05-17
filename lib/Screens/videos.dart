import 'package:org_chemistry/Screens/video.dart';
import 'package:org_chemistry/config/colors.dart';
import 'package:org_chemistry/elements/screenArguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VideosScreen extends StatelessWidget {
  List<Widget> chaptersGenerator(dynamic data, context) {
    var list = <Widget>[];

    for (final chapter in data['chapters']) {
      list.add(Container(
        child: new Text(chapter['name'],
            style: TextStyle(
                fontSize: 18.0,
                color: DefaultColors.drawerTitle,
                fontWeight: FontWeight.w600)),
        padding: EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
      ));
      for (final videoData in chapter['videos']) {
        list.add(InkWell(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 1),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                Image(
                  width: 110.0,
                  image: NetworkImage("http://i3.ytimg.com/vi/" +
                      videoData['id'] +
                      "/mqdefault.jpg"),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    videoData['title'],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoScreen(data: {
                  'video': videoData,
                  'sugessions': chapter['videos']
                }),
              ),
            );
          },
        ));
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(args.data['name']),
            ),
            body: Container(
              margin: EdgeInsets.only(top: 6),
              child: new ListView(
                children: this.chaptersGenerator(args.data, context),
              ),
            )),
      ),
    );
  }
}
