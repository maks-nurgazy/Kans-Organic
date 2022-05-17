import 'dart:convert';

import 'package:org_chemistry/Screens/topic.dart';
import 'package:org_chemistry/Screens/video.dart';
import 'package:org_chemistry/config/colors.dart';
import 'package:org_chemistry/elements/emptyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isSearching = false;
  bool isSearched = false;
  bool isInitializing = true;
  List<dynamic> reservedTopics = [];
  List<dynamic> reservedVideos = [];
  List<Widget> results = [];

  void initData() async {
    this.reservedTopics = this.extractTopics(await this.getTopics());
    this.reservedVideos = this.extractVideos(await this.getVideos());

    setState(() {
      this.isInitializing = false;
    });
  }

  bool contains(videos, video) {
    for (dynamic video_ in videos) {
      if (video_['id'] == video['id']) {
        return true;
      }
    }
    return false;
  }

  dynamic extractVideoSiblings(chapters, video) {
    var allVideos = [];
    for (dynamic chapter in chapters) {
      if (chapter['videos'] != null &&
          this.contains(chapter['videos'], video)) {
        for (dynamic video_ in chapter['videos']) {
          if (video_['id'] != video['id']) {
            allVideos.add(video_);
          }
        }
      } else if (chapter['chapters'] != null) {
        allVideos.addAll(this.extractVideoSiblings(chapter['chapters'], video));
      }
    }
    return allVideos;
  }

  void search(query) {
    setState(() {
      this.isSearching = true;
      this.isSearched = false;

      results.clear();
    });
    if (query.length <= 2) {
      this.isSearching = false;
      this.isSearched = true;
      return;
    }

    for (dynamic topic in reservedTopics) {
      if (topic['name'].toLowerCase().contains(query.toLowerCase())) {
        results.add(Container(
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
            child: Ink(
                decoration: new BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.05),
                    borderRadius: new BorderRadius.all(Radius.circular(10.0))),
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

    if (results.length > 0) {
      results.insert(
          0,
          Container(
            child: new Text("Темалар",
                style: TextStyle(
                    fontSize: 18.0, color: DefaultColors.drawerTitle)),
            padding: EdgeInsets.only(top: 10, bottom: 15, left: 20, right: 20),
          ));
    }

    int toBeInserted = results.length;
    for (dynamic video in reservedVideos) {
      if (video['title'].toLowerCase().contains(query.toLowerCase())) {
        results.add(InkWell(
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
          onTap: () {
            this.getVideos().then((tmpVideos) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VideoScreen(data: {
                            'video': video,
                            'sugessions':
                                this.extractVideoSiblings(tmpVideos, video)
                          })));
            });
          },
        ));
      }
    }

    if (toBeInserted < results.length) {
      results.insert(
          toBeInserted,
          Container(
            child: new Text("Терминдер",
                style: TextStyle(fontSize: 18.0, color: Colors.red)),
            padding: EdgeInsets.only(top: 10, bottom: 15, left: 20, right: 20),
          ));
    }

    setState(() {
      this.isSearching = false;
      this.isSearched = true;
    });
  }

  @override
  void initState() {
    initData();
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
    return Scaffold(
      appBar: EmptyAppBar(),
      body: Container(
        child: Column(
          children: <Widget>[
            Hero(
                tag: 'searchBar',
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Material(
                    color: Colors.transparent,
                    child: TextFormField(
                      cursorColor: Color.fromRGBO(70, 70, 70, 1),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Color.fromRGBO(70, 70, 70, 1),
                            size: 30,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        filled: true,
                        fillColor: Color.fromRGBO(235, 235, 235, 1),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.only(
                            top: 12, bottom: 0, left: 0, right: 10),
                        hintText: 'Издөө',
                        hintStyle:
                            TextStyle(color: Color.fromRGBO(70, 70, 70, 1)),
                      ),
                      autofocus: true,
                      style: TextStyle(
                          fontSize: 22.0, color: Color.fromRGBO(50, 50, 50, 1)),
                      enabled: true,
                      onChanged: (text) {
                        search(text);
                      },
                    ),
                  ),
                )),
            Expanded(
              child: Container(
                child: (this.isInitializing
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : (isSearched && this.results.length == 0)
                        ? Center(
                            child: ListView(
                              shrinkWrap: true,
                              children: <Widget>[
                                Column(children: [
                                  Icon(
                                    Icons.search,
                                    color: Color.fromRGBO(90, 90, 90, 1),
                                    size: 55,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Табылган жок :(",
                                    style: TextStyle(
                                        color: Color.fromRGBO(90, 90, 90, 1),
                                        fontSize: 20),
                                  )
                                ])
                              ],
                            ),
                          )
                        : (this.results.length == 0)
                            ? Center(
                                child: ListView(
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    Column(children: [
                                      Icon(
                                        Icons.search,
                                        color: Color.fromRGBO(90, 90, 90, 1),
                                        size: 55,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Сөздөрдү жазыңыз...",
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(90, 90, 90, 1),
                                            fontSize: 20),
                                      )
                                    ])
                                  ],
                                ),
                              )
                            : (isSearching)
                                ? Center(
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: <Widget>[
                                        Column(children: [
                                          CircularProgressIndicator(
                                              valueColor:
                                                  new AlwaysStoppedAnimation<
                                                          Color>(
                                                      Color.fromRGBO(
                                                          90, 90, 90, 1))),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Сураныч, күтө туруңуз...",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    90, 90, 90, 1),
                                                fontSize: 20),
                                          )
                                        ])
                                      ],
                                    ),
                                  )
                                : ListView(
                                    children: this.results,
                                  )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
