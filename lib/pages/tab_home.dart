import 'package:carousel_slider/carousel_slider.dart';
import 'package:etc/bloc/bloc.dart';
import 'package:etc/bloc/categories/categories_bloc.dart';
import 'package:etc/components/brandItem.dart';
import 'package:etc/components/categoryItem.dart';
import 'package:etc/components/offerItem.dart';
import 'package:etc/components/searchbar.dart';
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

class TabHome extends StatelessWidget {
  final dynamic userProfile;
  const TabHome({Key key, this.userProfile}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();
    var reqParam = {};
    reqParam['viewFeaturedOffers'] = "false";

    return Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 45, right: 45),
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
                    onChanged: (value) {},
                    // controller: editingController,
                    decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(10),
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
            BlocBuilder<CategoriesBloc, CategoriesState>(
              builder: (context, state) {
                if (state is CategoriesSuccess) {
                  final catItems = state.categories;
                  print(catItems);
                  return Container(
                      height: 200.0,
                      child: GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          mainAxisSpacing: 20.0,
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
                          })));
                } else {
                  return Container(child: Text("Loading...."));
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
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            ),
            BlocBuilder<FeaturedOffersBloc, FeaturedOffersState>(
              builder: (context, state) {
                if (state is FeaturedOffersSuccess) {
                  final offersList = state.offers;
                  print(offersList);
                  return Container(
                      child: GFCarousel(
                    items: offersList
                        .map<Widget>((itm) => GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => BlocProvider(
                                  create: (context) =>
                                      OfferdetailsBloc(Services()),
                                  child: OfferDetails(oItem: itm),
                                ),

                                //(_)=>OfferDetails(oItem: itm,)
                              ));
                            },
                            child: OfferItem(offerItem: itm)))
                        .toList(),
                    height: 200.0,
                    viewportFraction: 1.0,
                    autoPlay: false,
                    reverse: true,
                    pagination: true,
                    passiveIndicator: lightGrayColor,
                    activeIndicator: grayColor,
                    enableInfiniteScroll: true,
                  ));
                } else if (state is FeaturedOffersError) {
                  return Container(child: Text(state.message));
                } else {
                  return Container(child: Text("Loading...."));
                }
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: Text(
                "Popular Brands",
                style: headingText,
                textAlign: TextAlign.left,
              ),
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            ),
            BlocBuilder<BrandsBloc, BrandsState>(
              builder: (context, state) {
                if (state is BrandsSuccess) {
                  final brandsList = state.brands;
                  print(brandsList);
                  return Container(
                      child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GFCarousel(
                      items: _brandsPage(brandsList,context),
                      height: 100.0,
                    viewportFraction: 1.0,
                    autoPlay: true,
                    reverse: true,
                    pagination: true,
                    passiveIndicator: lightGrayColor,
                    activeIndicator: grayColor,
                    enableInfiniteScroll: true,
                    ),
                  ));
                } else if (state is BrandsError) {
                  return Container(child: Text(state.message));
                } else {
                  return Container(child: Text("Loading...."));
                }
              },
            ),
          ],
        ));
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
