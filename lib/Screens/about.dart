import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AboutScreen extends StatelessWidget {
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
              title: Text("Китеп жөнүндө"),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.all(Radius.circular(10.0))),
                child: Column(
                  children: <Widget>[
                    Text(
                        "       Бул окуу китеби, билим берүү стандартынын жана органикалык химия боюнча окуу программасынын негизинде жогорку окуу жайларында окуган бакалаврлар, магистрлер, аспиранттар жана химия курсун тереңдетип окуган мектептин окуучуларына жана мугалимдери үчүн түзүлгөн.",
                        style: new TextStyle(
                            color: Color.fromRGBO(50, 50, 50, 1),
                            fontSize: 17.0)),
                    Container(
                      margin: EdgeInsets.only(top: 70),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text("АВТОРЛОР ЖӨНҮНДӨ",
                            style: new TextStyle(
                                color: Color.fromRGBO(50, 50, 50, 1),
                                fontSize: 17.0)),
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
