import 'package:etc/components/loader.dart';
import 'package:etc/components/topiclist.dart';
import 'package:etc/helper/services.dart';
import 'package:flutter/material.dart';
class Topics extends StatefulWidget {
  Topics({Key key}) : super(key: key);

  @override
  _TopicsState createState() => _TopicsState();
}

class _TopicsState extends State<Topics> {

  List<dynamic> categories=[];
  List<dynamic> topics=[];
  bool _loading = false;
  bool _processing = false; 

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void didChangeDependencies() async {
    super.didChangeDependencies();
    _loading = true;
    setState(() {});
    try {
      // categories = await Services().getCategories(null);
      topics = await Services().getSubscribedTopics();
      print(topics);
      _loading = false;
      setState(() {});
    }catch (e){
      _loading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("Topics"),
        centerTitle:true,
      ),
      body:(_loading==false)?TopicList(topics: topics, theme: "dark",):CustomLoader()
    );
  }
}