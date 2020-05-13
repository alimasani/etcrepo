import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  Welcome({Key key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  List<Color> _gradients = [
    Color(0xFF214469),
    Color(0xFF06519b),
    Color(0xFF214469),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
        body: Stack(children: <Widget>[
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/img/etc_bg.jpg"), fit: BoxFit.cover)),
      ),
      Container(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Center(
              child: Image.asset("assets/img/logo.png",
                  width: MediaQuery.of(context).size.width * 0.65))),
      Container(color: Colors.black45),
      Positioned(
        top:40.0,
        right:5.0,
        child: FlatButton(onPressed:(){
          Navigator.pushReplacementNamed(context, '/home');
        },color: Colors.transparent, child: Text("Skip", style:TextStyle(color:Colors.white, fontSize: 20.0, decoration: TextDecoration.underline)),)),
      Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.5),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text("Welcome to Dubai",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26.0,
                    fontWeight: FontWeight.w500,
                  )),
              Text("Explore. Save. Enjoy",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontSize: 20.0, height: 1.5)),
              SizedBox(
                height: 30.0,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.15,
                    10.0,
                    MediaQuery.of(context).size.width * 0.15,
                    10.0),
                height: 50.0,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/login", arguments: {'activeTab':"login"});
                  },
                  padding: const EdgeInsets.all(0.0),
                  child: Ink(
                    child: Container(
                      width:double.infinity,
                      height: double.infinity,
                      child: Center(
                        child: Text(
                          "Member Login",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: _gradients,
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight),
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            ),
                  ),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.transparent)),
                ),
              ),
              
              
            ]),
      )
    ]));
  }
}

// Container(
//                 color: Colors.transparent,
//                 margin: EdgeInsets.fromLTRB(
//                     MediaQuery.of(context).size.width * 0.15,
//                     10.0,
//                     MediaQuery.of(context).size.width * 0.15,
//                     10.0),
//                 height: 50.0,
//                 child: Ink(
//                                   child: FlatButton(
//                     onPressed: () {

//                       Navigator.pushNamed(context, "/login", arguments: {'activeTab':"login"});

//                     },
//                     color: Colors.transparent,
//                     padding: const EdgeInsets.all(0.0),
//                     child: Container(
//                       width:double.infinity,
//                       height: double.infinity,
//                       child: Center(
//                         child: Text(
//                           "Member Login",
//                           style: TextStyle(fontSize: 18.0),
//                         ),
//                       ),
//                     ),
//                     textColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30.0),
//                         side: BorderSide(color: Colors.white)),
//                   ),
//                 ),
//               )