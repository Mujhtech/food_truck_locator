import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_truck_locator/controllers/truck_controller.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/utils/constant.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NearbyScreen extends StatefulWidget {
  const NearbyScreen({Key? key}) : super(key: key);

  @override
  State<NearbyScreen> createState() => _NearbyScreenState();
}

class _NearbyScreenState extends State<NearbyScreen> {
  bool mapPermission = false;
  LatLng? _userLocation;

  @override
  void initState() {
    super.initState();
    _checkMapPermission();
  }

  Future<bool> _checkMapPermission() async {
    bool serviceEnabled;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        mapPermission = false;
      });
      return false;
    }

    final result = await Geolocator.getCurrentPosition();
    setState(() {
      mapPermission = true;
      _userLocation = LatLng(result.latitude, result.longitude);
    });
    return true;
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

    final result = await Geolocator.getCurrentPosition();
    setState(() {
      mapPermission = true;
      _userLocation = LatLng(result.latitude, result.longitude);
    });

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final truck = watch(truckController);
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: mapPermission
            ? Container(
                width: context.screenWidth(1),
                height: context.screenHeight(1),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/Group.png'))),
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
                                await _requestMapPermission();
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
        // body: SafeArea(
        //   child: Padding(
        //     padding: const EdgeInsets.only(left: 10, right: 10),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Text(
        //           'Near By',
        //           style: Theme.of(context)
        //               .textTheme
        //               .headline1!
        //               .copyWith(fontWeight: FontWeight.bold),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      );
    });
  }
}
