import 'package:org_chemistry/db/favoriteDatabase.dart';
import 'package:org_chemistry/elements/htmlFiller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

class TopicScreen extends StatefulWidget {
  TopicScreen({Key key, this.data}) : super(key: key);

  final dynamic data;

  @override
  _TopicScreenState createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  Widget texData;
  Widget loadingWidget;
  double height;
  bool isLoading = true;
  bool isStarred = false;
  PdfViewerController _pdfViewerController;
  FavoriteDatabase db;
  // final Completer<WebViewController> _controller =
  //     Completer<WebViewController>();

  @override
  void initState() {
    // _pdfViewerController = PdfViewerController();

    // loadingWidget = Center(
    //     child: Container(
    //   child: ListView(
    //     shrinkWrap: true,
    //     children: <Widget>[
    //       Column(children: [
    //         CircularProgressIndicator(),
    //         SizedBox(
    //           height: 10,
    //         ),
    //         Text(
    //           "Please Wait....",
    //           style: TextStyle(color: Colors.blueAccent),
    //         )
    //       ])
    //     ],
    //   ),
    // ));

    // db = FavoriteDatabase.get();
    // db.init().then((value) {
    //   db.isPostFavorite(this.widget.data['id']).then((value) {
    //     setState(() {
    //       isStarred = value;
    //     });
    //   });
    // });

    // DefaultAssetBundle.of(context)
    //     .loadString("assets/data/topics/" + this.widget.data['file'] + ".data")
    //     .then((value) {
    //   HtmlFiller.renderKatexHTML(context, value, (html) {
    //     setState(() {
    //       texData = WebView(
    //         initialUrl: 'about:blank',
    //         javascriptMode: JavascriptMode.unrestricted,
    //         onWebViewCreated: (WebViewController webViewController) {
    //           webViewController.loadUrl(Uri.dataFromString(html,
    //                   mimeType: 'text/html',
    //                   encoding: Encoding.getByName('utf-8'))
    //               .toString());
    //           _controller.complete(webViewController);
    //         },
    //         onPageStarted: (String url) {},
    //         onPageFinished: (String url) {
    //           setState(() {
    //             isLoading = false;
    //           });
    //         },
    //         gestureNavigationEnabled: true,
    //       );
    //     });
    //   });
    // });
    super.initState();
  }

  Widget getDataScreen(context) {


    return SfPdfViewer.asset(
      'assets/books/${this.widget.data['file']}.pdf',
      // controller: _pdfViewerController,
    );
  }

  @override
  Widget build(BuildContext context) {
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
            title: Text(this.widget.data['name']),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: Icon(
                    Icons.star,
                    color: isStarred ? Colors.yellow : Colors.white,
                    size: 20,
                  ),
                  onPressed: () async {
                    // await db.updatePostFavorite(
                    //     PostFavorite(this.widget.data['id'], !isStarred));
                    // db.isPostFavorite(this.widget.data['id']).then((value) {
                    //   setState(() {
                    //     isStarred = value;
                    //   });
                    // });
                  },
                ),
              )
            ],
          ),
          body: this.getDataScreen(context),
        ),
      ),
    );
  }
}
