import 'dart:async';
import 'dart:ui';

import 'package:etc/bloc/bloc.dart';
import 'package:etc/components/loader.dart';
import 'package:etc/components/offerItem.dart';
import 'package:etc/helper/globals.dart';
import 'package:etc/helper/map_helper.dart';
import 'package:etc/helper/map_marker.dart';
import 'package:etc/helper/services.dart';
import 'package:etc/pages/offerdetails.dart';
import 'package:fluster/fluster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getflutter/components/carousel/gf_carousel.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map/plugin_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'package:latlong/latlong.dart';
class LeafMap extends StatefulWidget {
  final stream;
  LeafMap({Key key, this.stream}) : super(key: key);

  @override
  _LeafMapState createState() => _LeafMapState();
}

class _LeafMapState extends State<LeafMap> {
  bool _loadingOffers = false;
  bool _movingMap = false;
  bool _showClusterPopup = false;
  int _currentPage = 1;
  List offersList = [];
  dynamic clusterItems = [];
  LatLng currentLatLng = LatLng(25.070819, 55.137023);
  GoogleMapController _gmController;
  Completer<GoogleMapController> _controller = Completer();
  bool _mapChild = false;
  LatLngBounds _currentBounds;
  List _markerLocations = [];
  List<ClusterItem<dynamic>> markerItems = [];
  Set<Marker> _markers = Set();
  final int _minClusterZoom = 0;
  final int _maxClusterZoom = 19;
  Fluster<MapMarker> _clusterManager;
  bool _isMapLoading = true;
  bool _areMarkersLoading = true;
  final String _markerImageUrl =
      'https://img.icons8.com/office/80/000000/marker.png';
  final Color _clusterColor = Colors.blue;
  final Color _clusterTextColor = Colors.white;
  ClusterManager _manager;

  Future<Marker> Function(Cluster<dynamic>) get _markerBuilder =>
      (cluster) async {
        return Marker(
          markerId: MarkerId(cluster.getId()),
          position: cluster.location,
          onTap: () {
            print('---- $cluster');
            cluster.items.forEach((p) => print(p));
            clusterItems = cluster.items;
            _currentPage = 1;
            _showClusterPopup = true;
            setState(() {});
          },
          consumeTapEvents: true,
          icon: await _getMarkerBitmap(cluster.isMultiple ? 100 : 100,
              text: cluster.isMultiple ? cluster.count.toString() : cluster.count.toString()),
        );
      };

  Future<BitmapDescriptor> _getMarkerBitmap(int size, {String text}) async {
    assert(size != null);

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = Colors.red;
    final Paint paint2 = Paint()..color = Colors.white;

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);

    if (text != null) {
      TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: TextStyle(
            fontSize: size / 3,
            color: Colors.white,
            fontWeight: FontWeight.normal),
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
      );
    }

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }

  _loadOffers(bounds) async {
    print("=====");
    print(currentFilterParams);
    print("=====");
    var mbr = {};
    mbr['minLat'] = bounds.southwest.latitude;
    mbr['minLong'] = bounds.southwest.longitude;
    mbr['maxLat'] = bounds.northeast.latitude;
    mbr['maxLong'] = bounds.northeast.longitude;

    currentFilterParams['mapMBR'] = mbr;

    var position = null;

    var permission = await Geolocator().isLocationServiceEnabled();
    print(permission);
    if(permission == false){
      position = null;
    }else {
      position = await Geolocator().getCurrentPosition();
    }
    
    print(position);
    if (position != null && position != '') {
      var userloc = {};
      userloc['latitude'] = position.latitude.toString();
      userloc['longitude'] = position.longitude.toString();
      currentFilterParams['userLocation'] = userloc;
    }
    currentFilterParams.remove("viewUserBookmarkedOffers");

    if (currentUserProfile != null &&
        currentUserProfile != '' &&
        currentUserProfile.length > 0) {
      currentFilterParams['userID'] = currentUserProfile['user']['userID'];
      currentFilterParams['userName'] =
          currentUserProfile['userProfile']['userName'];
    }

    _loadingOffers = true;
    setState(() {});

    try {
      offersList = await Services().getOffers(
          data: currentFilterParams, start: "0", offset: rowsPerPage);
      List<ClusterItem<dynamic>> tmpItems;

      tmpItems = offersList
          .map((e) => ClusterItem(
              LatLng(
                  double.parse(e['outlet']['locality']['location']
                      ['geoLocation']['latitude']),
                  double.parse(e['outlet']['locality']['location']
                      ['geoLocation']['longitude'])),
              item: e))
          .toList();

      _manager.setItems(tmpItems);

      _loadingOffers = false;
      print("Offers = " + offersList.length.toString());
      setState(() {});
      // _initMarkers(offersList);
    } catch (e) {
      _loadingOffers = false;
      offersList = [];
      setState(() {});
    }
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
  void didChangeDependencies() async {
    super.didChangeDependencies();

    var position = null;

    var permission = await Geolocator().isLocationServiceEnabled();
    print(permission);
    if(permission == false){
      position = null;
      setState(() {
        _mapChild = true;
      });
    }else {
      position = await Geolocator().getCurrentPosition();
      setState(() {
        currentLatLng = LatLng(position.latitude, position.longitude);
        _mapChild = true;
      });
    }
    

    print(position);
  }

  @override
  void initState() {
    _manager = _initClusterManager();
    widget.stream.listen((filter){
      applyFilter(filter);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  applyFilter(filter) async{ 
    print("**********");
    print(filter);
    print("**********");
    currentFilterParams = filter;
    _loadOffers(_currentBounds);
  }

  ClusterManager _initClusterManager() {
    return ClusterManager<dynamic>(markerItems, _updateMarkers,
        markerBuilder: _markerBuilder, initialZoom: 16);
  }

  void _updateMarkers(Set<Marker> markers) {
    print('Updated ${markers.length} markers');
    setState(() {
      this._markers = markers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          (_mapChild == true)
              ? GoogleMap(
                  mapType: MapType.normal,
                  markers: _markers,
                  mapToolbarEnabled: false,
                  initialCameraPosition:
                      CameraPosition(target: currentLatLng, zoom: 16),
                  onMapCreated: (GoogleMapController controller) async {
                    _controller.complete(controller);
                    _gmController = controller;
                    _currentBounds = await _gmController.getVisibleRegion();
                    _manager.setMapController(controller);
                  },
                  onCameraMove: (CameraPosition position) async {
                    _currentBounds = await _gmController.getVisibleRegion();
                    print(_currentBounds);
                    print("map is moving");
                    _manager.onCameraMove(position, forceUpdate: true);
                  },
                  onCameraIdle: () {
                    print("map is idle now");
                    _loadOffers(_currentBounds);
                  },
                )
              : CustomLoader(),
          if(_showClusterPopup==true) Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black87,
              ),
              child: Column(
                children: <Widget>[
                  Expanded(child: InkWell(onTap:(){
                    _showClusterPopup = false;
                    setState((){});
                  }, 
                  child: Container(child: null,)),),
                  Container(
                    child: (clusterItems.length > 0)
                        ? Column(
                          children: <Widget>[
                            Container(
                              height: 30.0,
                              child: Padding(
                                padding: const EdgeInsets.only(left:10.0,right:10.0),
                                child: Row(children: <Widget>[
                                  Expanded(
                                    child: Text(_currentPage.toString() + " / "+clusterItems.length.toString(), style: TextStyle(color:Colors.white, fontSize:18.0, fontWeight:FontWeight.w600),textAlign: TextAlign.center,),),
                                  InkWell(onTap:(){
                                    _showClusterPopup=false;
                                    setState((){});
                                  }, child: Icon(Icons.close, color: Colors.white,),)
                                ],),
                              ),
                              decoration: BoxDecoration(
                                color:darkGrayColor
                              ),
                            ),
                            GFCarousel(
                                onPageChanged: (index) {
                                  _currentPage = index + 1;
                                  setState(() {});
                                },
                                items: clusterItems
                                    .map<Widget>((itm) => GestureDetector(
                                        onTap: () {
                                          var index = offersList.indexOf(itm);
                                          navigateToOfferDetailPage(
                                              context, offersList, index);
                                        },
                                        child: OfferItem(offerItem: itm)))
                                    .toList(),
                                height: 170.0,
                                initialPage: 0,
                                viewportFraction: 1.0,
                                autoPlay: false,
                                reverse: false,
                                pagination: false,
                                enableInfiniteScroll: true,
                              ),
                          ],
                        )
                        : Container(
                            child: null,
                          ),
                    decoration: BoxDecoration(color: Colors.white),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// Widget _mapWidget(currentLatLng, _controller, _movingMap) {
//   return GoogleMap(
//     mapType: MapType.normal,
//     initialCameraPosition: CameraPosition(target: currentLatLng, zoom: 16),
//     onMapCreated: (GoogleMapController controller) {
//       _controller.complete(controller);
//     },
//     onCameraMove: (CameraPosition position) async {
//       print(position);
//       _movingMap = true;
//       print("===========");
//       var vb = await _controller.getVisibleRegion();
//       print(vb);
//     },
//     onCameraIdle: () {
//       _movingMap = false;
//     },
//   );
// }
