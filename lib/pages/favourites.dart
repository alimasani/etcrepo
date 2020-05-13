import 'package:etc/bloc/authenticate/authenticate_bloc.dart';
import 'package:etc/bloc/bloc.dart';
import 'package:etc/components/loader.dart';
import 'package:etc/components/notauthorized.dart';
import 'package:etc/components/offerItem.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/helper/services.dart';
import 'package:etc/pages/offerdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Favourites extends StatefulWidget {
  Favourites({Key key}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("=====");
    print(currentFilterParams);
    print("=====");

    currentFilterParams = {};

    if (currentUserProfile != null && currentUserProfile != '') {
      currentFilterParams['userID'] = currentUserProfile['user']['userID'];
      currentFilterParams['userName'] =
          currentUserProfile['userProfile']['userName'];
      currentFilterParams['viewUserBookmarkedOffers'] = "true";
    }

    BlocProvider.of<OffersBloc>(context)
      ..add(GetOffers(data: currentFilterParams));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticateBloc, AuthenticateState>(
      builder: (context, state) {
        if (state is! AuthenticateSuccess) {
          return NotAuthorized();
        } else {
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
                                child: OfferDetails(oItem: offerList[index]),
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
                } else if (state is OffersError) {
                  return Container(
                    child: Center(child: Text("No Records Found")),
                  );
                } else {
                  return CustomLoader();
                }
              },
            ),
          );
        }
      },
    );
  }
}
