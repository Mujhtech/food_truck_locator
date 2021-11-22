import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_truck_locator/controllers/share_controller.dart';
import 'package:food_truck_locator/controllers/truck_controller.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/models/truck_model.dart';
import 'package:food_truck_locator/utils/constant.dart';
import 'package:food_truck_locator/widgets/modals/book_modal.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class NearbyScreen extends StatefulWidget {
  const NearbyScreen({Key? key}) : super(key: key);

  @override
  State<NearbyScreen> createState() => _NearbyScreenState();
}

class _NearbyScreenState extends State<NearbyScreen> {
  late GoogleMapController mapController;
  late BitmapDescriptor customIcon;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  bool mapPermission = false;

  TruckModel? myTruck;

  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(12, 12)),
            'assets/images/MapIcon.png')
        .then((d) {
      setState(() {
        customIcon = d;
      });
    });
  }

  void onClickMarker(TruckModel data) {
    setState(() {
      myTruck = data;
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

  Future<bool> _requestMapPermission() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          mapPermission = false;
        });
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        mapPermission = false;
      });
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final truck = watch(truckController);
      final share = watch(shareControllerProvider);
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: share.getMapPermission()! || mapPermission
            ? Stack(
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
                            LatLng _userLocation = LatLng(
                                snapshotData!.latitude, snapshotData.longitude);

                            return GoogleMap(
                              zoomControlsEnabled: false,
                              mapToolbarEnabled: false,
                              onMapCreated: _onMapCreated,
                              initialCameraPosition: CameraPosition(
                                target: _userLocation,
                                zoom: 12,
                              ),
                              markers: truck.maps(customIcon, onClickMarker)
                                ..add(Marker(
                                    markerId: const MarkerId("My Location"),
                                    //icon: customIcon,
                                    infoWindow:
                                        const InfoWindow(title: "My Location"),
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
                  if (myTruck != null)
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
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
                                          borderRadius:
                                              BorderRadius.circular(20.0),
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
                                      child: myTruck!.featuredImage!.isNotEmpty
                                          ? Container(
                                              width: 100,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(8)),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: CachedNetworkImageProvider(
                                                          myTruck!
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          myTruck!.title!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          myTruck!.location!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '${calculateDistance(double.parse(myTruck!.latitude!), double.parse(myTruck!.longitude!), double.parse(myTruck!.latitude!), double.parse(myTruck!.longitude!))}km Away',
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
                                  shadow: const BoxShadow(
                                      color: Colors.transparent),
                                  backgroundColor: Colors.transparent,
                                  transitionBackgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) => BookModal(
                                    item: myTruck!,
                                    km: calculateDistance(
                                        double.parse(myTruck!.latitude!),
                                        double.parse(myTruck!.longitude!),
                                        double.parse(myTruck!.latitude!),
                                        double.parse(myTruck!.longitude!)),
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
                        ))
                ],
              )
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Nearby',
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Commons.primaryColor),
                        ),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/images/Map.svg',
                                  color: const Color(0xFFCCCCCC),
                                  semanticsLabel: 'Explore'),
                              Text(
                                'Allow the app to locate your location\nto find the trucks near you',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            MaterialButton(
                              onPressed: () async {
                                final result = await _requestMapPermission();
                                await share.updateMapPermission(result);
                              },
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
                                  'Allow',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Commons.whiteColor),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ]),
                ),
              ),
      );
    });
  }
}
