import 'dart:convert';

import 'package:org_chemistry/Screens/topic.dart';
import 'package:org_chemistry/Screens/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../db/favoriteDatabase.dart';

class RemarksScreen extends StatefulWidget {
  RemarksScreen({Key key}) : super(key: key);

  @override
  _RemarksScreenState createState() => _RemarksScreenState();
}

class _RemarksScreenState extends State<RemarksScreen> {
  FavoriteDatabase db;
  List<Widget> topics = [];
  List<Widget> videos = [];
  bool isLoading = true;

  @override
  void initState() {
    db = FavoriteDatabase.get();
    db.init().then((value) async {
      var topicFavorites = List();
      for (dynamic favorite in await db.getAllTopicFavorites()) {
        if (favorite['isFavorite'] == 1) {
          topicFavorites.add(favorite['id']);
        }
      }

      var videoFavorites = List();
      for (dynamic favorite in await db.getAllVideoFavorites()) {
        if (favorite['isFavorite'] == 1) {
          videoFavorites.add(favorite['id']);
        }
      }

      topics.clear();
      for (dynamic topic in this.extractTopics(await this.getTopics())) {
        if (topicFavorites.contains(topic['id'])) {
          topics.add(Container(
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
              child: Ink(
                  decoration: new BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.05),
                      borderRadius:
                          new BorderRadius.all(Radius.circular(10.0))),
                  child: InkWell(
                    child: new ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        title: Container(
                          child: new Text(
                            topic["name"],
                            style: new TextStyle(
                                color: Color.fromRGBO(55, 100, 253, 1),
                                fontSize: 17.0),
                          ),
                          transform: Matrix4.translationValues(-5, 0, 0),
                        ),
                        leading: topic["suffix"] != null
                            ? new Container(
                                height: 40.0,
                                width: 40.0,
                                color: Colors.transparent,
                                child: new Container(
                                    decoration: new BoxDecoration(
                                        color: Color.fromRGBO(55, 137, 253, 1),
                                        borderRadius: new BorderRadius.all(
                                            Radius.circular(20.0))),
                                    child: new Center(
                                      child: new Text(
                                        topic["suffix"],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: (topic["suffix"].length > 2
                                              ? 15
                                              : 17),
                                        ),
                                      ),
                                    )),
                              )
                            : null,
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Color.fromRGBO(55, 137, 253, 1),
                        )),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TopicScreen(data: topic),
                        ),
                      );
                    },
                  ))));
        }
      }

      videos.clear();
      var extractedVideos = this.extractVideos(await this.getVideos());
      for (dynamic video in extractedVideos) {
        if (videoFavorites.contains(video['id'])) {
          videos.add(InkWell(
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
                        video['id'] +
                        "/mqdefault.jpg"),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      video['title'],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoScreen(
                      data: {'video': video, 'sugessions': extractedVideos}),
                ),
              );
            },
          ));
        }
      }

      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  dynamic getTopics() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/data/topics.json");
    return json.decode(data)['chapters'];
  }

  dynamic getVideos() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/data/video.json");
    return json.decode(data)['chapters'];
  }

  dynamic extractTopics(chapters) {
    var allChapters = [];
    for (dynamic chapter in chapters) {
      if (chapter['topic'] != null) {
        allChapters.add(chapter['topic']);
      } else if (chapter['chapters'] != null) {
        allChapters.addAll(this.extractTopics(chapter['chapters']));
      }
    }
    return allChapters;
  }

  dynamic extractVideos(chapters) {
    var allChapters = [];
    for (dynamic chapter in chapters) {
      if (chapter['videos'] != null) {
        allChapters.addAll(chapter['videos']);
      } else if (chapter['chapters'] != null) {
        allChapters.addAll(this.extractTopics(chapter['chapters']));
      }
    }
    return allChapters;
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    "Темалар",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Практикалык иштер",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
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
            title: Text("Эскертмелер"),
          ),
          body: TabBarView(
            children: [
              Container(
                margin: EdgeInsets.only(top: 6),
                child: isLoading
                    ? Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            vertical: height / 2 - 100,
                          ),
                          child: Column(children: [
                            CircularProgressIndicator(),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Сураныч, күтө туруңуз....",
                              style: TextStyle(color: Colors.blueAccent),
                            )
                          ]),
                        ),
                      )
                    : (this.topics.length == 0
                        ? Center(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                vertical: height / 2 - 150,
                              ),
                              child: Column(children: [
                                SvgPicture.asset(
                                  'assets/icons/book_content.svg',
                                  color: Color.fromRGBO(55, 137, 253, 1),
                                  semanticsLabel: 'Жылдызча темалар жок',
                                  width: 55,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Сизде жылдызча коюлган темалар жок :(",
                                  style: TextStyle(
                                      color: Colors.blueAccent, fontSize: 18),
                                )
                              ]),
                            ),
                          )
                        : ListView(
                            children: this.topics,
                          )),
              ),
              Container(
                margin: EdgeInsets.only(top: 6),
                child: isLoading
                    ? Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            vertical: height / 2 - 100,
                          ),
                          child: Column(children: [
                            CircularProgressIndicator(),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Сураныч, күтө туруңуз....",
                              style: TextStyle(color: Colors.blueAccent),
                            )
                          ]),
                        ),
                      )
                    : (this.topics.length == 0
                        ? Center(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                vertical: height / 2 - 150,
                              ),
                              child: Column(children: [
                                SvgPicture.asset(
                                  'assets/icons/symbol.svg',
                                  color: Color.fromRGBO(55, 137, 253, 1),
                                  semanticsLabel:
                                      'Жылдызча коюлган практикалык иштер жок',
                                  width: 60,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Сизде жылдызча коюлган практикалык иштер жок :(",
                                  style: TextStyle(
                                      color: Colors.blueAccent, fontSize: 18),
                                )
                              ]),
                            ),
                          )
                        : ListView(
                            children: this.videos,
                          )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
