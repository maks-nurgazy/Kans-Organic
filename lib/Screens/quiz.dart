import 'dart:async';
import 'package:org_chemistry/elements/htmlFiller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';

import 'package:webview_flutter/webview_flutter.dart';

class QuizScreen extends StatefulWidget {
  QuizScreen({Key key, this.data}) : super(key: key);

  final dynamic data;

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  bool isLoading = true;
  List<dynamic> questions = [];
  Widget quizScreen;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    DefaultAssetBundle.of(context)
        .loadString("assets/data/quizzes/" + this.widget.data['id'] + ".json")
        .then((data) {
      final quiz = json.decode(data);
      List<dynamic> tmpQuestions = quiz['questions'];
      tmpQuestions.shuffle();
      tmpQuestions = tmpQuestions.sublist(
          0, (tmpQuestions.length >= 15 ? 15 : tmpQuestions.length));
      for (dynamic question in tmpQuestions) {
        int answer;
        String answerTmp = question['variants'][question['answer']]['title'];
        List<dynamic> variants = [];

        question['variants'].shuffle();
        for (var i = 0; i < question['variants'].length; i++) {
          dynamic variant = question['variants'][i];

          if (answerTmp == variant['title']) {
            answer = i;
          }

          variants.add(variant['title']);
        }

        this.questions.add({
          'title': question['question'],
          'variants': variants,
          'answer': answer
        });
      }

      HtmlFiller.renderQuizHTML(context, jsonEncode(this.questions), (html) {
        setState(() {
          quizScreen = WebView(
            initialUrl: 'about:blank',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              webViewController.loadUrl(Uri.dataFromString(html,
                      mimeType: 'text/html',
                      encoding: Encoding.getByName('utf-8'))
                  .toString());
              _controller.complete(webViewController);
            },
            onPageStarted: (String url) {},
            onPageFinished: (String url) {
              setState(() {
                isLoading = false;
              });
            },
            gestureNavigationEnabled: true,
          );
        });
      });
    });
    super.initState();
  }

  Widget getDataScreen(context) {
    List<Widget> tmp = [];
    if (this.quizScreen != null) {
      tmp.add(this.quizScreen);
    }
    if (isLoading) {
      tmp.add(Positioned.fill(
        child: Align(
            alignment: Alignment.centerRight,
            child: Center(
                child: Container(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Column(children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Please Wait....",
                      style: TextStyle(color: Colors.blueAccent),
                    )
                  ])
                ],
              ),
            ))),
      ));
    }
    return Stack(
      children: tmp,
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
              title: Text(this.widget.data['name'])),
          body: this.getDataScreen(context),
        ),
      ),
    );
  }
}
