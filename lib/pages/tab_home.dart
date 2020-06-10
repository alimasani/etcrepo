import 'package:carousel_slider/carousel_slider.dart';
import 'package:etc/bloc/bloc.dart';
import 'package:etc/bloc/categories/categories_bloc.dart';
import 'package:etc/components/brandItem.dart';
import 'package:etc/components/categoryItem.dart';
import 'package:etc/components/offerItem.dart';
import 'package:etc/components/searchbar.dart';
import 'package:etc/components/shimmer/shimmer-brandItem.dart';
import 'package:etc/components/shimmer/shimmer-catitem.dart';
import 'package:etc/components/shimmer/shimmer-offeritem.dart';
import 'package:etc/helper/api.dart';
import 'package:etc/helper/data-process.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/helper/services.dart';
import 'package:etc/models/app_tab.dart';
import 'package:etc/pages/offerdetails.dart';
import 'package:etc/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getflutter/getflutter.dart';
import 'package:shimmer/shimmer.dart';

class TabHome extends StatefulWidget {
  final dynamic userProfile;
  const TabHome({Key key, this.userProfile}) : super(key: key);

  @override
  _TabHomeState createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {
  final TextEditingController _searchController = TextEditingController();

  navigateToOfferDetailPage(BuildContext context, offerList, index) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => OfferdetailsBloc(Services()),
            child: OfferDetails(offerId: offerList[index]['offerInfo']['offerID'],outletId: offerList[index]['outlet']['outletID'],outletName: offerList[index]['outlet']['outletName']),
          )
        )
        );

    if (currentOfferDetails['isBookmarked'] != "") {
      offerList[index]['offerInfo']['isBookmarked'] = currentOfferDetails['isBookmarked'];
      currentOfferDetails['isBookmarked'] = "";
      BlocProvider.of<FeaturedOffersBloc>(context).add(ChangeFeaturedOfferDetail(offerList));
    }
  }

  @override
  Widget build(BuildContext context) {
    
    var reqParam = {};
    reqParam['viewFeaturedOffers'] = "false";

    return SingleChildScrollView(
          child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: TextFormField(
                      controller: _searchController,
                      onFieldSubmitted: (value) {
                        currentFilterParams = {};
                        currentFilterParams['searchKeyword'] = value;
                        BlocProvider.of<FooterBloc>(context)
                            .add(TabUpdated(AppTab.list_offer));
                      },
                      textInputAction: TextInputAction.search,
                      autocorrect: false,
                      decoration: InputDecoration(
                          isDense: false,
                          contentPadding: EdgeInsets.only(left:10.0,right:10.0,top:0,bottom:0),
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
              SizedBox(
                height: 10.0,
              ),
              Container(
                child: Text(
                  "Categories",
                  style: headingText,
                  textAlign: TextAlign.left,
                ),
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 3.0),
              ),
              BlocBuilder<CategoriesBloc, CategoriesState>(
                builder: (context, state) {
                  if (state is CategoriesSuccess) {
                    final catItems = state.categories;
                    print(catItems);
                    return AspectRatio(
                      aspectRatio: 16/7,
                                        child: Container(
                        
                          child: GridView.count(
                              physics: NeverScrollableScrollPhysics(),
                              mainAxisSpacing: 5.0,
                              childAspectRatio: 3 / 2,
                              crossAxisCount: 3,
                              children: List.generate(catItems.length, (index) {
                                return InkWell(
                                  onTap: () {
                                    currentFilterParams = {};
                                    var tmpList = [];
                                    tmpList.add(
                                        catItems[index]['categoryID'].toString());
                                    currentFilterParams['categoryIDs'] = tmpList;

                                    BlocProvider.of<FooterBloc>(context)
                                        .add(TabUpdated(AppTab.list_offer));
                                  },
                                  child: Center(
                                    child: CategoryItem(catItem: catItems[index]),
                                  ),
                                );
                              }))),
                    );
                  } else {
                    return Container(
                        height: 200.0,
                        child: GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            mainAxisSpacing: 20.0,
                            childAspectRatio: 3 / 2,
                            crossAxisCount: 3,
                            children: List.generate(6, (index) {
                              return shimmerCatItem(context);
                            })));
                  }
                },
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                child: Text(
                  "Featured Offers",
                  style: headingText,
                  textAlign: TextAlign.left,
                ),
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 3.0),
              ),
              BlocBuilder<FeaturedOffersBloc, FeaturedOffersState>(
                builder: (context, state) {
                  if (state is FeaturedOffersSuccess) {
                    final offersList = state.offers;
                    print(offersList);
                    return Container(
                        
                        child: GFCarousel(
                          onPageChanged: (index){
                            setState((){});
                          },
                      items: offersList
                          .map<Widget>((itm) => GestureDetector(
                              onTap: () {
                                var index = offersList.indexOf(itm);
                                navigateToOfferDetailPage(context, offersList, index);
                              },
                              child: OfferItem(offerItem: itm)))
                              
                          .toList(),
                      aspectRatio: 16/7.4,
                      viewportFraction: 1.0,
                      autoPlay: false,
                      reverse: false,
                      pagination: true,
                      passiveIndicator: lightGrayColor,
                      activeIndicator: grayColor,
                      enableInfiniteScroll: true,
                    ));
                  } else if (state is FeaturedOffersError) {
                    return Container(child: Text(state.message));
                  } else {
                    return shimmerOfferItem(context);
                  }
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: Text(
                  "Popular Brands",
                  style: headingText,
                  textAlign: TextAlign.left,
                ),
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
              ),
              BlocBuilder<BrandsBloc, BrandsState>(
                builder: (context, state) {
                  if (state is BrandsSuccess) {
                    final brandsList = state.brands;
                    print(brandsList);
                    return Container(
                      padding: EdgeInsets.all(0.0),
                      margin: EdgeInsets.all(0.0),
                      child: Padding(
                      padding: const EdgeInsets.only(top:0.0,left:10.0,right:10.0,bottom:0.0),
                      child: GFCarousel(
                        onPageChanged: (index){
                          setState((){});
                        },
                        items: _brandsPage(brandsList,context),
                      aspectRatio: 16/4.2,
                      viewportFraction: 1.0,
                      autoPlay: true,
                      reverse: false,
                      pagination: true,
                      passiveIndicator: lightGrayColor,
                      activeIndicator: grayColor,
                      enableInfiniteScroll: true,
                      ),
                    ));
                  } else if (state is BrandsError) {
                    return Container(child: Text(state.message));
                  } else {
                    return Container(
                      padding: EdgeInsets.only(left:10.0,right:10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                        shimmerBrandItem(context),
                        shimmerBrandItem(context),
                        shimmerBrandItem(context),
                        shimmerBrandItem(context),
                      ],),
                    );
                  }
                },
              ),
            ],
          )),
    );
  }
}



_brandsPage(itms,context) {
  List<Widget> list = List<Widget>();
  var pages = itms.length / 4;
  var itmPP = 4;
  for (var i = 0; i < pages; i++) {
    if(((i*4) + 4)<=itms.length){
      itmPP = (i*4)+4;
    }else {
      itmPP = itms.length;
    }
    var pi = itms.getRange((i*4), itmPP);

    list.add(Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: pi
          .map<Widget>((bi) => InkWell(
                      onTap: () {
                                currentFilterParams = {};
                                var tmpList = [];
                                tmpList.add(
                                    bi['brandID'].toString());
                                currentFilterParams['brandIDs'] = tmpList;

                                BlocProvider.of<FooterBloc>(context)
                                    .add(TabUpdated(AppTab.list_offer));
                              },
                      child: BrandItem(
                  brandItem: bi,
                ),
          ))
          .toList(),
    ));
  }
  return list;
}

// Row(
//                       children: <Widget>[
//                         BrandItem(brandItem: brandsList[4]),
//                         BrandItem(brandItem: brandsList[1]),
//                         BrandItem(brandItem: brandsList[2]),
//                         BrandItem(brandItem: brandsList[3]),
//                       ],
//                     )

// FutureBuilder(
//                 future: Services()
//                     .getOffers(data: reqParam, start: "1", offset: "3"),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.done) {
//                     if (snapshot.hasData) {
//                       var offersList = snapshot.data;
//                       return Container(
//                           child: GFCarousel(
//                         items: offersList
//                             .map<Widget>((itm) => GestureDetector(
//                                 onTap: () {
//                                   Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (_) => BlocProvider(
//                                       create: (context) =>
//                                           OfferdetailsBloc(Services()),
//                                       child: OfferDetails(oItem: itm),
//                                     ),

//                                     //(_)=>OfferDetails(oItem: itm,)
//                                   ));
//                                 },
//                                 child: OfferItem(offerItem: itm)))
//                             .toList(),
//                         height: 200.0,
//                         viewportFraction: 1.0,
//                         autoPlay: false,
//                         reverse: true,
//                         pagination: true,
//                         passiveIndicator: lightGrayColor,
//                         activeIndicator: grayColor,
//                         enableInfiniteScroll: true,
//                       ));
//                     } else {
//                       return Text("Loading");
//                     }
//                   } else {
//                     return Text("Loading");
//                   }
//                 }),
