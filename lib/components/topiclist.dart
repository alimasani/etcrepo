import 'package:etc/helper/globals.dart';
import 'package:etc/helper/services.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
class TopicList extends StatefulWidget {
  final topics;
  final theme;
  TopicList({Key key, this.topics,this.theme}) : super(key: key);

  @override
  _TopicListState createState() => _TopicListState();
}

class _TopicListState extends State<TopicList> {
  
  final _scrollController = ScrollController();
  bool _showLoader = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _toggleTopic(context,topic,index) async {
    _showLoader = true;
    setState((){});
    var data = {};
    data['topicID'] = topic["topicID"];
    try {
      final resp = await Services().toggleTopic(data);
    print(resp);
    if(resp['desc']=='Topic Subscribed Successfully'){
      widget.topics[index]['userIsSubscribed']="true";
    }else {
      widget.topics[index]['userIsSubscribed']="false";
    }
    _showLoader = false;
    setState((){});
    Scaffold.of(context).showSnackBar(SnackBar(behavior:SnackBarBehavior.floating, content: Text(resp['desc'], textAlign: TextAlign.center,),));
    }catch(e){
      print(e);
      _showLoader = true;
      setState((){});
      Scaffold.of(context).showSnackBar(SnackBar(behavior:SnackBarBehavior.floating, content: Text("Error occured while updating your preference.", textAlign: TextAlign.center,),backgroundColor: Colors.red,));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: _showLoader,
        progressIndicator: CircularProgressIndicator(strokeWidth: 1.5,),
        color: Colors.black,
          child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: null,
            body: ListView.builder(
                        padding: EdgeInsets.only(top:0.0),
                        controller: _scrollController,
                        itemCount: widget.topics.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                                  onTap: () {
                                      _toggleTopic(context,widget.topics[index],index);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border:Border(bottom: BorderSide(color:(widget.theme=="dark")?Colors.black12:Colors.white12)),
                                      color:Colors.transparent,
                                    ),
                                    padding: EdgeInsets.all(15.0),
                                    child: Row(children: <Widget>[
                                      Expanded(child:Text(widget.topics[index]['topicName'], style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: (widget.theme=="dark")?darkGrayColor:Colors.white ),)),
                                      (widget.topics[index]['userIsSubscribed']=="true")?Container(child:Icon(Icons.check_box, color: primaryColor,)):Icon(Icons.check_box_outline_blank, color: (widget.theme=="dark")?grayColor:Colors.white,)
                                    ],),
                                  ),
                                );
                        }),
      ),
    );
  }
}