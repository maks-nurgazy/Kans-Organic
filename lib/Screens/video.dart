import 'package:org_chemistry/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:org_chemistry/elements/emptyAppBar.dart';
import 'package:flutter_youtube_view/flutter_youtube_view.dart';
import '../db/favoriteDatabase.dart';

class VideoScreen extends StatefulWidget {
  VideoScreen({Key key, this.data}) : super(key: key);

  final dynamic data;

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen>
    implements YouTubePlayerListener {
  FlutterYoutubeViewController _controller;
  bool isFavorited = false;
  FavoriteDatabase db;

  @override
  void onCurrentSecond(double second) {}

  @override
  void onError(String error) {
    print("onError error = $error");
  }

  @override
  void onReady() {
    print("onReady");
  }

  @override
  void onStateChange(String state) {
    print("onStateChange state = $state");
    setState(() {});
  }

  @override
  void onVideoDuration(double duration) {
    print("onVideoDuration duration = $duration");
  }

  void _onYoutubeCreated(FlutterYoutubeViewController controller) {
    this._controller = controller;
  }

  List<Widget> listViewGenerator(
      dynamic video, List<dynamic> videoList, context) {
    var list = <Widget>[
      Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Color.fromRGBO(70, 70, 70, 1),
                size: 30,
              ),
              onPressed: () async {
                await this._controller.pause();
                Navigator.pop(context);
              },
            ),
            Expanded(
                child: SizedBox(
              child: Text(
                video['title'],
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5,
                  fontSize: 20,
                ),
              ),
            )),
            IconButton(
              icon: Icon(
                Icons.star,
                color: isFavorited ? Colors.red : Color.fromRGBO(70, 70, 70, 1),
                size: 20,
              ),
              onPressed: () async {
                await db.updateVideoFavorite(
                    VideoFavorite(video['id'], !isFavorited));
                db.isVideoFavorite(video['id']).then((value) {
                  setState(() {
                    isFavorited = value;
                  });
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.share,
                color: Color.fromRGBO(70, 70, 70, 1),
                size: 20,
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
      Divider(
        color: Color.fromRGBO(55, 55, 55, 0.05),
        height: 1,
      ),
      Container(
        child: new Text("Sugessions",
            style:
                TextStyle(fontSize: 18.0, color: DefaultColors.drawerHeading)),
        padding: EdgeInsets.only(top: 10, bottom: 15, left: 20, right: 20),
      )
    ];

    for (final videoData in videoList) {
      if (videoData != video) {
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
          onTap: () async {
            await this._controller.pause();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoScreen(
                    data: {'video': videoData, 'sugessions': videoList}),
              ),
            );
          },
        ));
      }
    }
    return list;
  }

  @override
  void initState() {
    db = FavoriteDatabase.get();
    db.init().then((value) {
      db.isVideoFavorite(this.widget.data['video']['id']).then((value) {
        setState(() {
          isFavorited = value;
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: EmptyAppBar(),
        body: OrientationBuilder(builder: (context, orientation) {
          var list = <Widget>[];

          if (orientation == Orientation.portrait) {
            list.add(AspectRatio(
              aspectRatio: 16 / 9,
              child: FlutterYoutubeView(
                onViewCreated: _onYoutubeCreated,
                listener: this,
                params: YoutubeParam(
                    videoId: this.widget.data['video']['id'],
                    showUI: true,
                    startSeconds: 0,
                    showYoutube: false,
                    showFullScreen: true,
                    autoPlay: true),
              ),
            ));
            list.add(Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 6),
                child: new ListView(
                  children: this.listViewGenerator(
                      widget.data['video'], widget.data['sugessions'], context),
                ),
              ),
            ));
          } else {
            double screenHeight = MediaQuery.of(context).size.height - 25;
            list.add(Container(
              height: screenHeight,
              child: FlutterYoutubeView(
                onViewCreated: _onYoutubeCreated,
                listener: this,
                params: YoutubeParam(
                    videoId: this.widget.data['video']['id'],
                    showUI: true,
                    startSeconds: 0,
                    showYoutube: false,
                    showFullScreen: true,
                    autoPlay: true),
              ),
            ));
          }
          return Column(
            children: list,
          );
        }));
  }
}
