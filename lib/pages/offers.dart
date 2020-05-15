import 'package:etc/bloc/bloc.dart';
import 'package:etc/bloc/offers/offers_bloc.dart';
import 'package:etc/components/loader.dart';
import 'package:etc/components/offerItem.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/helper/services.dart';
import 'package:etc/pages/offerdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Offers extends StatefulWidget {
  final dynamic data;
  Offers({Key key, this.data}) : super(key: key);
  
  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {

  void didChangeDependencies() {
    super.didChangeDependencies();
    print("=====");
    print(currentFilterParams);
    print("=====");

    currentFilterParams.remove("viewUserBookmarkedOffers");

    if(currentUserProfile!=null && currentUserProfile!='' && currentUserProfile.length>0){
      currentFilterParams['userID'] = currentUserProfile['user']['userID'];
      currentFilterParams['userName'] = currentUserProfile['userProfile']['userName'];
    }
    
    BlocProvider.of<OffersBloc>(context)
      ..add(GetOffers(data:currentFilterParams));
  }

  @override
  Widget build(BuildContext context) {

    

    return Container(
      child: BlocBuilder<OffersBloc, OffersState>(
        builder: (context, state) {
          if (state is OffersSuccess) {
            final offerList = state.offers;
            print(offerList);
            return ListView.builder(
                itemCount: offerList.length,
                itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => BlocProvider(
                                      create: (context) =>
                                          OfferdetailsBloc(Services()),
                                      child: OfferDetails(offerId: offerList[index]['offerInfo']['offerID'],outletId: offerList[index]['outlet']['outletID'],outletName: offerList[index]['outlet']['outletName']),
                                    ),
                                    //(_)=>OfferDetails(oItem: itm,)
                                  ));
                                },
                                              child: Container(
                          height: 170.0,
                          child: OfferItem(
                            offerItem: offerList[index],
                          ),
                        ),
                      );
                    });
          } else {
            return CustomLoader();
          }
        },
      ),
    );
  }
}
