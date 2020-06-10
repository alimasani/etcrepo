import 'package:etc/helper/globals.dart';
import 'package:etc/helper/methods.dart';
import 'package:flutter/material.dart';

class FilterPopup extends StatefulWidget {
  final filterCallBack applyFilter;
  FilterPopup({Key key, this.applyFilter}) : super(key: key);

  @override
  _FilterPopupState createState() => _FilterPopupState();
}

class _FilterPopupState extends State<FilterPopup> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> catList = [];
  List<dynamic> filterList = gFilters.toList();
  dynamic selectedFilters = {};
  List<dynamic> otherFilters = [];
  dynamic categoryFilters = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(currentFilterParams['keyword']!=''){
      _searchController.text = currentFilterParams['keyword'];
    }

    if(currentFilterParams.containsKey("viewUserEntitledOffers")){
      selectedFilters['viewUserEntitledOffers'] = "true";
    }
    
    if(currentFilterParams.containsKey("viewUserBookmarkedOffers")){
      selectedFilters['viewUserBookmarkedOffers'] = "true";
    }
    
    if(currentFilterParams.containsKey("viewNewOffers")){
      selectedFilters['viewNewOffers'] = "true";
    }
    
    if(currentFilterParams.containsKey("viewFeaturedOffers")){
      selectedFilters['viewFeaturedOffers'] = "true";
    }
    selectedFilters['filters'] = currentFilterParams['filters'];
    selectedFilters['categoryIDs'] = currentFilterParams['categoryIDs'];
    if (currentFilterParams['categoryIDs'] != null) {
      if (currentFilterParams['categoryIDs']?.length > 0) {
        var tmpCat = gCategories.toList();
        for (var i = 0; i < tmpCat.length; i++) {
          if (tmpCat[i]['categoryID'] ==
              currentFilterParams['categoryIDs'][0]) {
            tmpCat[i]['selected'] = true;

            otherFilters = [];
            var tmp = filterList
                .where((f) =>
                    f['applicableCategories'].contains(tmpCat[i]['category']) &&
                    f['type'] == 'boolean')
                .toList();
            for (var i = 0; i < tmp.length; i++) {
              tmp[i]['selected'] = false;
              if(currentFilterParams['filters']!=null){
                if (currentFilterParams['filters']?.length > 0) {
                  if (currentFilterParams['filters']
                          .indexWhere((v) => v['key'] == tmp[i]['label']) >=
                      0) {
                    tmp[i]['selected'] = true;
                  }
                }
              }
            }
            otherFilters = tmp;
            categoryFilters = [];
            var tmp1 = filterList
                .where((f) =>
                    f['applicableCategories'].contains(tmpCat[i]['category']) &&
                    f['type'] == 'LOV')
                .toList();
            for (var i = 0; i < tmp1.length; i++) {
              tmp1[i]['selected'] = false;
              for (var j = 0; j < tmp1[i]['arrayLookups'].length; j++) {
                tmp1[i]['arrayLookups'][j]['selected'] = false;
                if(currentFilterParams['filters']!=null){ 
                  if (currentFilterParams['filters']?.length > 0) {
                    if (currentFilterParams['filters'].indexWhere((v) =>
                            v['key'] == tmp1[i]['name'] &&
                            v['value'] == tmp1[i]['arrayLookups'][j]['label']) >=
                        0) {
                      tmp1[i]['arrayLookups'][j]['selected'] = true;
                    }
                  }
                }
              }
            }
            categoryFilters = tmp1;
          }
        }

        catList = tmpCat;
      }else {
        catList = gCategories.toList();
      }
    } else {
      catList = gCategories.toList();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
          Widget>[
        Container(
          height: 40.0,
          child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(children: <Widget>[
                Expanded(
                    child: Text(
                  "Filter Offers",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0),
                )),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                )
              ])),
          decoration: BoxDecoration(color: darkGrayColor),
        ),
        Expanded(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Search Keyword
                Padding(
                    padding: EdgeInsets.only(left: 25, right: 25),
                    child: TextFormField(
                        controller: _searchController,
                        textInputAction: TextInputAction.search,
                        autocorrect: false,
                        decoration: InputDecoration(
                            isDense: false,
                            contentPadding: EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 0, bottom: 0),
                            hintText: "Search for merchants, locations",
                            hintStyle: TextStyle(color: grayColor),
                            prefixIcon: Icon(
                              Icons.search,
                              size: 25.0,
                            ),
                            fillColor: Colors.white,
                            filled: false,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                    color: Color(0xFFEFEFEF), width: 2.5)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                    color: Color(0xFFEFEFEF), width: 2.5))))),
                // Category Filters
                Container(
                  padding: EdgeInsets.only(bottom: 7.0, top: 7.0),
                  margin: EdgeInsets.only(bottom: 7.0, top: 7.0),
                  child: Text(
                    "Categories",
                    style: TextStyle(
                        color: blueColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black38)),
                    color: Colors.transparent,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: catList
                      .map<Widget>((item) => InkWell(
                          onTap: () {
                            
                            var index = catList.indexOf(item);
                            if(item['selected']==false){

                              catList[index]['selected'] = true;
                              var catIds = [];
                              catIds.add(item['categoryID']);
                              selectedFilters['categoryIDs'] = catIds;
                              otherFilters = [];
                              var tmp = filterList
                                  .where((f) =>
                                      f['applicableCategories']
                                          .contains(item['category']) &&
                                      f['type'] == 'boolean')
                                  .toList();
                              for (var i = 0; i < tmp.length; i++) {
                                tmp[i]['selected'] = false;
                              }
                              otherFilters = tmp;
                              categoryFilters = [];
                              var tmp1 = filterList
                                  .where((f) =>
                                      f['applicableCategories']
                                          .contains(item['category']) &&
                                      f['type'] == 'LOV')
                                  .toList();
                              for (var i = 0; i < tmp1.length; i++) {
                                tmp1[i]['selected'] = false;
                                for (var j = 0;
                                    j < tmp1[i]['arrayLookups'].length;
                                    j++) {
                                  tmp1[i]['arrayLookups'][j]['selected'] = false;
                                }
                              }
                              categoryFilters = tmp1;
                              print(otherFilters);
                            }else {
                              catList[index]['selected'] = false;
                              var catIds = [];
                              selectedFilters['categoryIDs'] = catIds;
                              otherFilters = [];
                              categoryFilters = [];
                            }
                            setState(() {});
                          },
                          child: filterItem(item, 'category', "category")))
                      .toList(),
                ),
                // Category sub filters
                Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: categoryFilters
                        .map<Widget>((item) => Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Container(
                                  padding:
                                      EdgeInsets.only(bottom: 7.0, top: 7.0),
                                  margin:
                                      EdgeInsets.only(bottom: 7.0, top: 7.0),
                                  child: Text(
                                    item['label'],
                                    style: TextStyle(
                                        color: blueColor,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.black38)),
                                    color: Colors.transparent,
                                  ),
                                ),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: item['arrayLookups']
                                        .map<Widget>((al) => InkWell(
                                              onTap: () {
                                                var cindex = categoryFilters
                                                    .indexOf(item);
                                                var index = item['arrayLookups']
                                                    .indexOf(al);
                                                if (al['selected'] == true) {
                                                  setState(() {
                                                    categoryFilters[cindex]
                                                                ['arrayLookups']
                                                            [index]
                                                        ['selected'] = false;
                                                    selectedFilters['filters']
                                                        .removeWhere((v) =>
                                                            v['key'] ==
                                                                item['name'] &&
                                                            v['value'] ==
                                                                al['label']);
                                                  });
                                                  print(item['name'] +
                                                      al['label']);
                                                  print(selectedFilters);
                                                } else {
                                                  setState(() {
                                                    categoryFilters[cindex]
                                                                ['arrayLookups']
                                                            [index]
                                                        ['selected'] = true;
                                                    if (selectedFilters
                                                        .containsKey(
                                                            'filters')) {

                                                      if(selectedFilters['filters']==null) selectedFilters['filters']=[];       

                                                      selectedFilters['filters']
                                                          .add({
                                                        "key": item['name'],
                                                        "value": al['label']
                                                      });
                                                    } else {
                                                      selectedFilters[
                                                          'filters'] = [];
                                                      selectedFilters['filters']
                                                          .add({
                                                        "key": item['name'],
                                                        "value": al['label']
                                                      });
                                                    }
                                                  });
                                                  print(item['label'] +
                                                      "selected");
                                                  print(selectedFilters);
                                                }
                                              },
                                              child: filterItem(
                                                  al, 'label', "lov"),
                                            ))
                                        .toList())
                              ],
                            ))
                        .toList()),

                // Other Filters
                Container(
                  padding: EdgeInsets.only(bottom: 7.0, top: 7.0),
                  margin: EdgeInsets.only(bottom: 7.0, top: 7.0),
                  child: Text(
                    "Other Filters",
                    style: TextStyle(
                        color: blueColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black38)),
                    color: Colors.transparent,
                  ),
                ),
                Column(
                  children: <Widget>[
                    InkWell(
                        onTap: () {
                          if(selectedFilters.containsKey("viewNewOffers")){
                            selectedFilters.remove("viewNewOffers");
                          }else {
                            selectedFilters['viewNewOffers']="true";
                          }
                          setState((){});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.black12)),
                            color: Colors.transparent,
                          ),
                          padding: EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 7.0, bottom: 7.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: Text(
                                "New Offers",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                    color: darkGrayColor),
                              )),
                              (selectedFilters.containsKey('viewNewOffers'))
                                  ? Container(
                                      child: Icon(
                                      Icons.check_box,
                                      color: primaryColor,
                                    ))
                                  : Icon(
                                      Icons.check_box_outline_blank,
                                      color: grayColor,
                                    )
                            ],
                          ),
                        )),
                        InkWell(
                        onTap: () {
                          if(selectedFilters.containsKey("viewFeaturedOffers")){
                            selectedFilters.remove("viewFeaturedOffers");
                          }else {
                            selectedFilters['viewFeaturedOffers']="true";
                          }
                          setState((){});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.black12)),
                            color: Colors.transparent,
                          ),
                          padding: EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 7.0, bottom: 7.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: Text(
                                "Featured Offers",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                    color: darkGrayColor),
                              )),
                              (selectedFilters.containsKey('viewFeaturedOffers'))
                                  ? Container(
                                      child: Icon(
                                      Icons.check_box,
                                      color: primaryColor,
                                    ))
                                  : Icon(
                                      Icons.check_box_outline_blank,
                                      color: grayColor,
                                    )
                            ],
                          ),
                        )),
                        InkWell(
                        onTap: () {
                          if(selectedFilters.containsKey("viewUserEntitledOffers")){
                            selectedFilters.remove("viewUserEntitledOffers");
                          }else {
                            selectedFilters['viewUserEntitledOffers']="true";
                          }
                          setState((){});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.black12)),
                            color: Colors.transparent,
                          ),
                          padding: EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 7.0, bottom: 7.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: Text(
                                "User Entitled Offers",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                    color: darkGrayColor),
                              )),
                              (selectedFilters.containsKey('viewUserEntitledOffers'))
                                  ? Container(
                                      child: Icon(
                                      Icons.check_box,
                                      color: primaryColor,
                                    ))
                                  : Icon(
                                      Icons.check_box_outline_blank,
                                      color: grayColor,
                                    )
                            ],
                          ),
                        )),
                        // InkWell(
                        // onTap: () {
                        //   if(selectedFilters.containsKey("viewUserBookmarkedOffers")){
                        //     selectedFilters.remove("viewUserBookmarkedOffers");
                        //   }else {
                        //     selectedFilters['viewUserBookmarkedOffers']="true";
                        //   }
                        // },
                        // child: Container(
                        //   decoration: BoxDecoration(
                        //     border: Border(
                        //         bottom: BorderSide(color: Colors.black12)),
                        //     color: Colors.transparent,
                        //   ),
                        //   padding: EdgeInsets.only(
                        //       left: 15.0, right: 15.0, top: 7.0, bottom: 7.0),
                        //   child: Row(
                        //     children: <Widget>[
                        //       Expanded(
                        //           child: Text(
                        //         "My Favourite Offers",
                        //         style: TextStyle(
                        //             fontSize: 16.0,
                        //             fontWeight: FontWeight.w400,
                        //             color: darkGrayColor),
                        //       )),
                        //       (selectedFilters.containsKey('viewUserBookmarkedOffers'))
                        //           ? Container(
                        //               child: Icon(
                        //               Icons.check_box,
                        //               color: primaryColor,
                        //             ))
                        //           : Icon(
                        //               Icons.check_box_outline_blank,
                        //               color: grayColor,
                        //             )
                        //     ],
                        //   ),
                        // ))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: otherFilters
                      .map<Widget>((item) => InkWell(
                          onTap: () {
                            var index = otherFilters.indexOf(item);
                            if (item['selected'] == true) {
                              setState(() {
                                otherFilters[index]['selected'] = false;
                                selectedFilters['filters'].removeWhere(
                                    (v) => v['key'] == item['label']);
                              });
                              print(item['label'] + "unselect");
                              print(selectedFilters);
                            } else {
                              setState(() {
                                otherFilters[index]['selected'] = true;
                                if (selectedFilters.containsKey('filters')) {
                                  if(selectedFilters['filters']==null) selectedFilters['filters']=[];              
                                  selectedFilters['filters'].add(
                                      {"key": item['label'], "value": true});
                                } else {
                                  selectedFilters['filters'] = [];
                                  selectedFilters['filters'].add(
                                      {"key": item['label'], "value": true});
                                }
                              });
                              print(item['label'] + "selected");
                              print(selectedFilters);
                            }
                          },
                          child: filterItem(item, 'label', "boolean")))
                      .toList(),
                )
              ],
            ),
          )),
        ),
        Container(
          margin: EdgeInsets.only(left: 15.0, right: 15.0),
          padding: EdgeInsets.only(bottom: 10.0),
          child: FlatButton(
              onPressed: () {
                if (_searchController.text != '' &&
                    _searchController.text != null) {
                  selectedFilters['keyword'] = _searchController.text;
                }
                widget.applyFilter(selectedFilters);
                Navigator.of(context).pop();
              },
              color: primaryColor,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
              child: Text("Apply",
                  style: TextStyle(color: Colors.white, fontSize: 16.0))),
        )
      ]),
    );
  }
}

Widget filterItem(item, lblField, type) {
  return Container(
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.black12)),
      color: Colors.transparent,
    ),
    padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 7.0, bottom: 7.0),
    child: Row(
      children: <Widget>[
        Expanded(
            child: Text(
          item[lblField],
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: darkGrayColor),
        )),
        (item['selected'] == true)
            ? Container(
                child: Icon(
                Icons.check_box,
                color: primaryColor,
              ))
            : Icon(
                Icons.check_box_outline_blank,
                color: grayColor,
              )
      ],
    ),
  );
}

typedef filterCallBack = void Function(dynamic filter);
