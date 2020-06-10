import 'package:etc/bloc/authenticate/authenticate_bloc.dart';
import 'package:etc/bloc/bloc.dart';
import 'package:etc/components/loader.dart';
import 'package:etc/components/norecords.dart';
import 'package:etc/components/notauthorized.dart';
import 'package:etc/components/offerItem.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/helper/services.dart';
import 'package:etc/pages/offerdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class Favourites extends StatefulWidget {
  Favourites({Key key}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {

  List<dynamic> offersList = [];
  bool _loadingOffers = false;

  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void didChangeDependencies() async {
    super.didChangeDependencies();
    print("=====");
    print(currentFilterParams);
    print("=====");
    _loadingOffers = true;
    setState(() {});
    currentFilterParams = {};
    var position = null;

    var permission = await Geolocator().isLocationServiceEnabled();
    print(permission);
    if(permission == false){
      position = null;
    }else {
      position = await Geolocator().getCurrentPosition();
    }
    
    print(position);
    if (position!=null && position!=''){
      var userloc = {};
      userloc['latitude'] = position.latitude.toString();
      userloc['longitude'] = position.longitude.toString();
      currentFilterParams['userLocation']=userloc;
    }
    if (currentUserProfile != null && currentUserProfile != '') {
      currentFilterParams['userID'] = currentUserProfile['user']['userID'];
      currentFilterParams['userName'] =
          currentUserProfile['userProfile']['userName'];
      currentFilterParams['viewUserBookmarkedOffers'] = "true";
    }
    print(currentFilterParams);
    // BlocProvider.of<OffersBloc>(context)
    //   ..add(GetOffers(data: currentFilterParams));
    
    try {
      
      offersList = await Services().getOffers(data:currentFilterParams,start:"1",offset:rowsPerPage);
      _loadingOffers = false;
      setState(() {});
    }catch (e){
      offersList = [];
      _loadingOffers = false;
      setState(() {});
    }
    
  }

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
      if(offerList[index]['offerInfo']['isBookmarked'] != currentOfferDetails['isBookmarked']){
        offerList.removeAt(index);
        currentOfferDetails['isBookmarked'] = "";
        setState(() {});
      }
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticateBloc, AuthenticateState>(
      builder: (context, state) {
        if (state is! AuthenticateSuccess) {
          return NotAuthorized();
        } else {
          return Container(
            child: (_loadingOffers==true)?CustomLoader():Container(
              child: (offersList.length>0)?
                ListView.builder(
                      itemCount: offersList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            navigateToOfferDetailPage(context,offersList,index);
                          },
                          child: Container(
                            height: 170.0,
                            child: OfferItem(
                              offerItem: offersList[index],
                            ),
                          ),
                        );
                      })
              : NoRecords(icon:"",title:"Oops!",message:"It seems you haven't marked any offers as your favourite yet.")
              ,)
          );
        }
      },
    );
  }
}
