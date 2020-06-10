import 'dart:async';
import 'package:etc/bloc/bloc.dart';
import 'package:etc/bloc/offers/offers_bloc.dart';
import 'package:etc/components/loader.dart';
import 'package:etc/components/norecords.dart';
import 'package:etc/components/offerItem.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/helper/services.dart';
import 'package:etc/pages/offerdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class Offers extends StatefulWidget {
  final dynamic data;
  final stream;
  Offers({Key key, this.data, this.stream}) : super(key: key);
  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  OffersBloc _offersBloc;
  List<dynamic> offersList = [];
  bool _loadingOffers = false;
  bool _loadingMoreOffers = false;
  int currentPage = 1;
  bool noRecords = false;

  @override
  void initState() {
    super.initState();
    widget.stream.listen((filter){
      applyFilter(filter);
    });
    // _scrollController.addListener(_onScroll);
    // _offersBloc = BlocProvider.of<OffersBloc>(context);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  applyFilter(filter) async{ 
    print("**********");
    print(filter);
    print("**********");
    currentPage = 1;
    currentFilterParams = filter;
    getOffers();
  }

  void _onScroll() async {
    if (_loadingOffers == false) {
      _loadingMoreOffers = true;
      setState(() {});
      print("loading more offers ....");
      currentPage = currentPage + 1;
      try {
        var offersListNew = await Services().getOffers(
            data: currentFilterParams,
            start: ((int.parse(rowsPerPage) * (currentPage - 1)) + 1).toString(),
            offset: rowsPerPage);
        offersList = offersList + offersListNew;
        _loadingMoreOffers = false;
        setState(() {});
      } catch (e) {
        _loadingMoreOffers = false;
        setState(() {});
        print("///");
        print(e);
        print("///");
      }
    }
  }

  getOffers() async{
    
    var position = null;

    var permission = await Geolocator().isLocationServiceEnabled();
    print(permission);
    if(permission == false){
      position = null;
    }else {
      position = await Geolocator().getCurrentPosition();
    }
    
    print(position);
    if(position!=null && position!=''){
      var userloc = {};
      userloc['latitude'] = position.latitude.toString();
      userloc['longitude'] = position.longitude.toString();
      currentFilterParams['userLocation'] = userloc;
    }
    currentFilterParams.remove("viewUserBookmarkedOffers");
    currentFilterParams.remove("mapMBR");

    if (currentUserProfile != null &&
        currentUserProfile != '' &&
        currentUserProfile.length > 0) {
      currentFilterParams['userID'] = currentUserProfile['user']['userID'];
      currentFilterParams['userName'] =
          currentUserProfile['userProfile']['userName'];
    }
  print("=====");
    print(currentFilterParams);
    print("=====");

    // BlocProvider.of<OffersBloc>(context)
    //   ..add(GetOffers(data:currentFilterParams,resetList: true));
    _loadingOffers = true;
    setState(() {});
    try {
      offersList = await Services().getOffers(
          data: currentFilterParams,
          start: currentPage.toString(),
          offset: rowsPerPage);
      _loadingOffers = false;
      noRecords = false;
      setState(() {});
    } catch (e) {
      _loadingOffers = false;
      offersList = [];
      noRecords = true;
      setState(() {});
    }
  }

  void didChangeDependencies() async {
    super.didChangeDependencies();
    getOffers();
  }

  navigateToOfferDetailPage(BuildContext context, offerList, index) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => OfferdetailsBloc(Services()),
                  child: OfferDetails(
                      offerId: offerList[index]['offerInfo']['offerID'],
                      outletId: offerList[index]['outlet']['outletID'],
                      outletName: offerList[index]['outlet']['outletName']),
                )));

    if (currentOfferDetails['isBookmarked'] != "") {
      offerList[index]['offerInfo']['isBookmarked'] =
          currentOfferDetails['isBookmarked'];
      currentOfferDetails['isBookmarked'] = "";
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: (_loadingOffers == true)
            ? CustomLoader()
            : (noRecords==false)?NotificationListener<ScrollNotification>(
                onNotification: _handleScrollNotification,
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: offersList.length+1,
                    itemBuilder: (context, index) {
                      return (index >= offersList.length )
                          ? (_loadingMoreOffers == true)?_buildLoaderListItem():null
                          : InkWell(
                              onTap: () {
                                navigateToOfferDetailPage(
                                    context, offersList, index);
                              },
                              child: Container(
                                height: 170.0,
                                child: OfferItem(
                                  offerItem: offersList[index],
                                ),
                              ),
                            );
                    }),
              ):NoRecords(title:"Oops!", message:"No offers found matching your search criteria.", icon:""));
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      _onScroll();
    }
    return false;
  }
}

Widget _buildLoaderListItem() {
  return Container(
    padding: EdgeInsets.all(5.0),
    child: Center(
      child: SizedBox(
        width:20.0,
        height: 20.0,
        child: CircularProgressIndicator(strokeWidth: 1,)),
    ),
  );
}
