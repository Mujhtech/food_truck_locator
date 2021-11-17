import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/models/truck_model.dart';
import 'package:food_truck_locator/utils/constant.dart';
import 'package:food_truck_locator/widgets/modals/book_modal.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'dart:math' show cos, sqrt, asin;

class TruckLookUp extends StatefulWidget {
  final TruckModel item;
  const TruckLookUp({Key? key, required this.item}) : super(key: key);

  @override
  State<TruckLookUp> createState() => _TruckLookUpState();
}

class _TruckLookUpState extends State<TruckLookUp> {
  late GoogleMapController mapController;
  late BitmapDescriptor customIcon;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Set<Marker> markers = {};

  bool mapPermission = false;

  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(12, 12)),
            'assets/images/MapIcon.png')
        .then((d) {
      if (widget.item.latitude != null && widget.item.latitude != '') {
        Marker _truckMarker = Marker(
            markerId: MarkerId(widget.item.title!),
            icon: d,
            infoWindow: InfoWindow(title: widget.item.title!),
            position: LatLng(double.parse(widget.item.latitude!),
                double.parse(widget.item.longitude!)));
        setState(() {
          customIcon = d;
          markers.add(_truckMarker);
        });
      }
    });
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Future<Position> _currentLocation() async {
    bool serviceEnabled;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          FutureBuilder<Position>(
              future: _currentLocation(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Center(
                        child: Text("Failed to get user location."));
                  } else {
                    Position? snapshotData = snapshot.data;
                    LatLng _userLocation =
                        LatLng(snapshotData!.latitude, snapshotData.longitude);

                    return GoogleMap(
                      zoomControlsEnabled: false,
                      mapToolbarEnabled: false,
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: _userLocation,
                        zoom: 12,
                      ),
                      markers: markers
                        ..add(Marker(
                            markerId: const MarkerId("My Location"),
                            icon: customIcon,
                            infoWindow: const InfoWindow(title: "My Location"),
                            position: _userLocation)),
                    );
                  }
                }
                return const Center(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Commons.primaryColor)),
                  ),
                );
              }),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      margin: const EdgeInsets.only(left: 10, top: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                        color: const Color(0xFFFFFFFF),
                      ),
                      width: 42,
                      height: 42,
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                          color: Color(0xFF656565),
                        ),
                      ),
                    ),
                  )),
              Column(
                children: [
                  Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: const Color(0xFFFFFFFF),
                          ),
                          width: 42,
                          height: 42,
                          child: const Center(
                            child: Icon(
                              Icons.close,
                              size: 20,
                              color: Color(0xFF656565),
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: context.screenWidth(1),
                    height: 220,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: const Color(0xFFFFFFFF),
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF000000)
                                            .withOpacity(0.05),
                                        spreadRadius: 0,
                                        blurRadius: 5,
                                        offset: const Offset(0, 0),
                                      ),
                                    ]),
                                width: 74,
                                height: 74,
                                child: widget.item.featuredImage != null &&
                                        widget.item.featuredImage!.isNotEmpty
                                    ? Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(8)),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image:
                                                    CachedNetworkImageProvider(
                                                        widget.item
                                                            .featuredImage!))),
                                      )
                                    : SvgPicture.asset(
                                        'assets/images/User.svg',
                                        width: 100,
                                        height: 100,
                                        color: const Color(0xFF656565),
                                      ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.item.title!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.item.location!,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${calculateDistance(double.parse(widget.item.latitude!), double.parse(widget.item.longitude!), double.parse(widget.item.latitude!), double.parse(widget.item.longitude!))}Km Away',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                            fontSize: 14,
                                            color: Commons.primaryColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        MaterialButton(
                          onPressed: () => showCupertinoModalBottomSheet(
                            elevation: 0,
                            expand: true,
                            shadow: const BoxShadow(color: Colors.transparent),
                            backgroundColor: Colors.transparent,
                            transitionBackgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) => BookModal(
                              item: widget.item,
                              km: calculateDistance(
                                  double.parse(widget.item.latitude!),
                                  double.parse(widget.item.longitude!),
                                  double.parse(widget.item.latitude!),
                                  double.parse(widget.item.longitude!)),
                            ),
                          ),
                          elevation: 0,
                          color: Commons.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            width: context.screenWidth(1),
                            height: 53,
                            alignment: Alignment.center,
                            child: Text(
                              'Book this Truck',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Commons.whiteColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
