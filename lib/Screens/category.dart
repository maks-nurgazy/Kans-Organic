import 'package:org_chemistry/Screens/topic.dart';
import 'package:org_chemistry/Screens/quiz.dart';
import 'package:org_chemistry/elements/screenArguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class CategoryScreen extends StatelessWidget {
  List<Widget> listViewGenerator(List<dynamic> chapterList, context,
      {color, backgroundColor, icon}) {
    var list = <Widget>[];

    for (final subData in chapterList) {
      list.add(Container(
        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
        child: Ink(
            decoration: new BoxDecoration(
                color: (backgroundColor != null)
                    ? backgroundColor
                    : Color.fromRGBO(0, 0, 0, 0.05),
                borderRadius: new BorderRadius.all(Radius.circular(10.0))),
            child: InkWell(
              child: new ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  title: Container(
                    child: new Text(
                      subData["name"],
                      style: new TextStyle(
                          color: (color != null)
                              ? color
                              : Color.fromRGBO(55, 100, 253, 1),
                          fontSize: 17.0),
                    ),
                    transform: Matrix4.translationValues(
                        (subData["suffix"] != null) ? -5 : -2, 0, 0),
                  ),
                  leading: subData["suffix"] != null
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
                                  subData["suffix"],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: (subData["suffix"].length > 2
                                        ? 15
                                        : 17),
                                  ),
                                ),
                              )),
                        )
                      : Container(
                          margin: EdgeInsets.only(left: 10),
                          child: SvgPicture.asset(
                            'assets/icons/' + icon + '.svg',
                            color: (color != null) ? color : Colors.white,
                            semanticsLabel: 'Contents',
                            width: 32,
                          ),
                        ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: (color != null)
                        ? color
                        : Color.fromRGBO(55, 100, 253, 1),
                  )),
              onTap: () {
                if (subData["chapters"] != null) {
                  Navigator.pushNamed(
                    context,
                    '/category',
                    arguments: ScreenArguments(subData,
                        backgroundColor: Color.fromRGBO(0, 0, 0, 0.07)),
                  );
                } else if (subData["videos"] != null) {
                  Navigator.pushNamed(
                    context,
                    '/videos',
                    arguments: ScreenArguments(subData),
                  );
                } else if (subData["topic"] != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TopicScreen(data: subData["topic"]),
                    ),
                  );
                } else if (subData["quiz"] != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(data: subData["quiz"]),
                    ),
                  );
                }
              },
            )),
      ));
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
            bottom: args.type != 'solutions'
                ? TabBar(
                    tabs: [
                      Tab(
                        child: Text(
                          args.type == 'quizzes' ? 'Суроолор' : 'Аныктама',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Cүрөттөмө",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  )
                : null,
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
          body: args.type != 'solutions'
              ? TabBarView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 6),
                      child: new ListView(
                        children: this.listViewGenerator(
                            args.data['chapters'], context,
                            color: args.color,
                            backgroundColor: args.backgroundColor,
                            icon: (args.type == 'quizzes' ? 'symbol' : null)),
                      ),
                    ),
                    SingleChildScrollView(
                      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 7, horizontal: 7),
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                new BorderRadius.all(Radius.circular(10.0))),
                        child: Text(
                          args.data['description'],
                          style: new TextStyle(
                              color: Color.fromRGBO(50, 50, 50, 1),
                              fontSize: 17.0),
                        ),
                      ),
                    ),
                  ],
                )
              : Container(
                  margin: EdgeInsets.only(top: 6),
                  child: new ListView(
                    children: this.listViewGenerator(
                        args.data['chapters'], context,
                        color: args.color,
                        backgroundColor: args.backgroundColor,
                        icon: 'book'),
                  ),
                ),
        ),
      ),
    );
  }
}
