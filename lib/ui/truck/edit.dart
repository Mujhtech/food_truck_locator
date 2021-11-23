import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_truck_locator/controllers/auth_controller.dart';
import 'package:food_truck_locator/controllers/connectivity_controller.dart';
import 'package:food_truck_locator/controllers/truck_controller.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/models/truck_model.dart';
import 'package:food_truck_locator/ui/home.dart';
import 'package:food_truck_locator/utils/constant.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class TruckEdit extends StatefulWidget {
  final TruckModel item;
  const TruckEdit({Key? key, required this.item}) : super(key: key);

  @override
  State<TruckEdit> createState() => _TruckEditState();
}

class _TruckEditState extends State<TruckEdit> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController website = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();

  File? bannerImage;
  File? featuredImage;
  List<File>? galleries;
  double? latitude, longitude;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    title.text = widget.item.title!;
    location.text = widget.item.location!;
    website.text = widget.item.website!;
    description.text = widget.item.description!;
    latitude = double.parse(widget.item.latitude!);
    longitude = double.parse(widget.item.longitude!);
  }

  Future<void> updateGallery(List<XFile> images) async {
    List<File> files = [];
    if (images.isNotEmpty) {
      for (final image in images) {
        files.add(File(image.path));
      }
      setState(() {
        galleries = [...files];
      });
    }
  }

  final homeScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final truck = watch(truckController);
      final auth = watch(authControllerProvider);
      final connect = watch(connectivityControllerProvider);
      return WillPopScope(
        onWillPop: () async => !loading,
        child: Scaffold(
          key: homeScaffoldKey,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Stack(
            children: [
              GestureDetector(
                onTap: () async {
                  if (!await Commons.checkStoragePermission()) {
                    if (!await Commons.requestStoragePermission()) {
                      return;
                    }
                  }
                  try {
                    final XFile? image =
                        await _picker.pickImage(source: ImageSource.gallery);
                    if (image!.name.isNotEmpty) {
                      setState(() {
                        bannerImage = File(image.path);
                      });
                    }
                    //print(image);
                  } catch (err) {
                    //print(err.toString());
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: context.screenWidth(1),
                      height: 160,
                      padding: const EdgeInsets.all(50),
                      decoration: BoxDecoration(
                          color: const Color(0xFFEFEFEF),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(
                                  widget.item.bannerImage!))),
                      child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              color: const Color(0xFFFFFFFF),
                            ),
                            width: 50,
                            height: 50,
                            child: bannerImage != null
                                ? Image.file(
                                    bannerImage!,
                                    width: 40,
                                    height: 40,
                                  )
                                : const Center(
                                    child: Icon(
                                      Icons.photo_camera,
                                      size: 20,
                                      color: Color(0xFFCCCCCC),
                                    ),
                                  ),
                          )),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 0, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: Form(
                        key: formKey,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () {
                                  if (loading) {
                                    return;
                                  }
                                  Navigator.pop(context);
                                },
                                child: Container(
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
                              ),
                            ),
                            const SizedBox(height: 40),
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
                                width: 105,
                                height: 105,
                                child: GestureDetector(
                                    onTap: () async {
                                      // if (!await Commons
                                      //     .checkStoragePermission()) {
                                      //   if (!await Commons
                                      //       .requestStoragePermission()) {
                                      //     return;
                                      //   }
                                      // }
                                      // try {
                                      //   final XFile? image =
                                      //       await _picker.pickImage(
                                      //           source: ImageSource.gallery);
                                      //   if (image!.name.isNotEmpty) {
                                      //     setState(() {
                                      //       featuredImage = File(image.path);
                                      //     });
                                      //   }
                                      // } catch (err) {
                                      //   //print(err.toString());
                                      // }
                                    },
                                    child: galleries != null &&
                                            galleries!.isNotEmpty
                                        ? Image.file(
                                            galleries![0],
                                            width: 200,
                                            height: 200,
                                          )
                                        : Container(
                                            width: 200,
                                            height: 200,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(8)),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: CachedNetworkImageProvider(
                                                        widget.item
                                                            .featuredImage!))))),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Add Details',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return 'Truck Name Field is required';
                                }
                              },
                              controller: title,
                              cursorColor: Commons.primaryColor,
                              keyboardType: TextInputType.text,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 14),
                              decoration: InputDecoration(
                                enabledBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                focusedBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                focusedErrorBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                hintText: 'Truck Name',
                                hintStyle:
                                    const TextStyle(color: Color(0xFFAAAAAA)),
                                errorBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                errorStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.red),
                                fillColor: Theme.of(context)
                                    .inputDecorationTheme
                                    .fillColor,
                                filled: true,
                              ),
                              autocorrect: false,
                              autofocus: false,
                              obscureText: false,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return 'Location Field is required';
                                }
                              },
                              onChanged: (value) async {
                                if (value.isEmpty) return;
                                try {
                                  List<Location> locations =
                                      await locationFromAddress(value);
                                  Location location = locations[0];
                                  setState(() {
                                    latitude = location.latitude;
                                    longitude = location.longitude;
                                  });
                                  //print(location.latitude);
                                } catch (err) {
                                  //print(err.toString());
                                }
                              },
                              controller: location,
                              cursorColor: Commons.primaryColor,
                              keyboardType: TextInputType.text,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 14),
                              decoration: InputDecoration(
                                enabledBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                focusedBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                focusedErrorBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                hintText: 'Location',
                                hintStyle:
                                    const TextStyle(color: Color(0xFFAAAAAA)),
                                errorBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                errorStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.red),
                                fillColor: Theme.of(context)
                                    .inputDecorationTheme
                                    .fillColor,
                                filled: true,
                              ),
                              autocorrect: false,
                              autofocus: false,
                              obscureText: false,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return 'Description Field is required';
                                }
                              },
                              controller: description,
                              cursorColor: Commons.primaryColor,
                              keyboardType: TextInputType.text,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 14),
                              decoration: InputDecoration(
                                enabledBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                focusedBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                focusedErrorBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                hintText: 'About your truck',
                                hintStyle:
                                    const TextStyle(color: Color(0xFFAAAAAA)),
                                errorBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                errorStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.red),
                                fillColor: Theme.of(context)
                                    .inputDecorationTheme
                                    .fillColor,
                                filled: true,
                              ),
                              autocorrect: false,
                              autofocus: false,
                              obscureText: false,
                              maxLines: 6,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (v) {},
                              controller: website,
                              cursorColor: Commons.primaryColor,
                              keyboardType: TextInputType.text,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 14),
                              decoration: InputDecoration(
                                enabledBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                focusedBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                focusedErrorBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                hintText: 'Website',
                                hintStyle:
                                    const TextStyle(color: Color(0xFFAAAAAA)),
                                errorBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                errorStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.red),
                                fillColor: Theme.of(context)
                                    .inputDecorationTheme
                                    .fillColor,
                                filled: true,
                              ),
                              autocorrect: false,
                              autofocus: false,
                              obscureText: false,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Add Images',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (!await Commons.checkStoragePermission()) {
                                  if (!await Commons
                                      .requestStoragePermission()) {
                                    return;
                                  }
                                }
                                try {
                                  final List<XFile>? images =
                                      await _picker.pickMultiImage();
                                  await updateGallery(images!);
                                } catch (err) {
                                  //print(err.toString());
                                }
                              },
                              child: Container(
                                height: 100,
                                width: context.screenWidth(1),
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFFFFF),
                                  border: Border.all(
                                      width: 1,
                                      color: const Color(0xFFCCCCCC),
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Column(
                                  children: [
                                    Center(
                                      child: Text(
                                        galleries != null &&
                                                galleries!.isNotEmpty
                                            ? '${galleries!.length} images selected'
                                            : '${widget.item.galleries!.length} Selected, Remove & Add',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: Commons.primaryColor,
                                                fontSize: 18),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        'Note: One of the selected images will be used for banner',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (loading || truck.loading)
                      const Center(
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Commons.primaryColor)),
                        ),
                      )
                    else
                      MaterialButton(
                        onPressed: () async {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }
                          if (!connect.connectivityStatus) {
                            const snackBar = SnackBar(
                                content: Text('No internet connection'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            return;
                          }
                          if (widget.item.galleries!.isEmpty) {
                            const snackBar = SnackBar(
                                content: Text('Please minimum of 1 images'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            return;
                          }
                          try {
                            setState(() {
                              loading = false;
                            });
                            //String featured = widget.item.featuredImage!;
                            List<String> gallery = widget.item.galleries!;

                            // if (featuredImage != null &&
                            //     featuredImage!.path.isNotEmpty) {
                            //   featured = await truck.uploadFile(featuredImage!);
                            // }
                            if (galleries != null && galleries!.isNotEmpty) {
                              gallery = await truck.uploadFiles(galleries!);
                            }
                            if (!await truck.update(
                                widget.item.id!,
                                auth.user!.uid!,
                                title.text.trim(),
                                description.text.trim(),
                                location.text.trim(),
                                website.text.trim(),
                                latitude!,
                                longitude!,
                                gallery[0],
                                gallery[0],
                                gallery)) {
                              final snackBar =
                                  SnackBar(content: Text(truck.error!));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              return;
                            } else {
                              setState(() {
                                loading = false;
                              });
                              showGeneralDialog(
                                barrierLabel: "Barrier",
                                barrierDismissible: true,
                                barrierColor: Colors.black.withOpacity(0.5),
                                transitionDuration:
                                    const Duration(milliseconds: 200),
                                context: context,
                                pageBuilder: (_, __, ___) {
                                  return Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 283,
                                      width: 293,
                                      child: SizedBox.expand(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 75,
                                            width: 75,
                                            decoration: BoxDecoration(
                                              color: Commons.primaryColor
                                                  .withOpacity(0.05),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: const Icon(
                                              Icons.check,
                                              color: Commons.primaryColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Center(
                                            child: Text(
                                              'Successful',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1!
                                                  .copyWith(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Center(
                                            child: Text(
                                              'Your truck has been updated\nsuccessfully',
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(fontSize: 14),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Center(
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const HomeScreen(index: 0,)),
                                                    (Route<dynamic> route) =>
                                                        false);
                                              },
                                              child: Text(
                                                'Return Home',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        fontSize: 14,
                                                        color: Commons
                                                            .primaryColor),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                      margin: const EdgeInsets.only(
                                          bottom: 50, left: 12, right: 12),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                  );
                                },
                                transitionBuilder: (_, anim, __, child) {
                                  return SlideTransition(
                                    position: Tween(
                                            begin: const Offset(0, 1),
                                            end: const Offset(0, 0))
                                        .animate(anim),
                                    child: child,
                                  );
                                },
                              );
                            }
                          } catch (err) {
                            //
                            setState(() {
                              loading = false;
                            });
                          }
                        },
                        elevation: 0,
                        color: Commons.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          width: context.screenWidth(1),
                          height: 56,
                          alignment: Alignment.center,
                          child: Text(
                            'Save',
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
          ),
        ),
      );
    });
  }
}
