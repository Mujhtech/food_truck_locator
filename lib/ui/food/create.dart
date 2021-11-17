import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_truck_locator/controllers/food_controller.dart';
import 'package:food_truck_locator/controllers/truck_controller.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/ui/home.dart';
import 'package:food_truck_locator/utils/constant.dart';
import 'package:food_truck_locator/widgets/truck_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class FoodCreate extends StatefulWidget {
  const FoodCreate({Key? key}) : super(key: key);

  @override
  State<FoodCreate> createState() => _FoodCreateState();
}

class _FoodCreateState extends State<FoodCreate> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController amount = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();

  File? bannerImage;
  File? featuredImage;
  List<File>? galleries;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Container(
            width: context.screenWidth(1),
            height: 160,
            padding: const EdgeInsets.all(50),
            color: const Color(0xFFEFEFEF),
            child: Align(
                alignment: Alignment.center,
                child: Container(
                  //padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: const Color(0xFFFFFFFF),
                  ),
                  width: 50,
                  height: 50,
                  child: const Center(
                    child: Icon(
                      Icons.photo_camera,
                      size: 20,
                      color: Color(0xFFCCCCCC),
                    ),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            onTap: () => Navigator.pop(context),
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
                                if (!await Commons.checkStoragePermission()) {
                                  if (!await Commons
                                      .requestStoragePermission()) {
                                    return;
                                  }
                                }
                                try {
                                  final XFile? image = await _picker.pickImage(
                                      source: ImageSource.gallery);
                                  if (image!.name.isNotEmpty) {
                                    setState(() {
                                      featuredImage = File(image.path);
                                    });
                                  }
                                } catch (err) {
                                  //print(err.toString());
                                }
                              },
                              child: featuredImage != null
                                  ? Image.file(
                                      featuredImage!,
                                      width: 200,
                                      height: 200,
                                    )
                                  : SvgPicture.asset(
                                      'assets/images/User.svg',
                                      width: 200,
                                      height: 200,
                                      color: const Color(0xFF656565),
                                    ),
                            ),
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
                              return 'Cuisine Name Field is required';
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
                            enabledBorder:
                                Theme.of(context).inputDecorationTheme.border,
                            focusedBorder:
                                Theme.of(context).inputDecorationTheme.border,
                            focusedErrorBorder:
                                Theme.of(context).inputDecorationTheme.border,
                            hintText: 'Cuisine Name',
                            hintStyle:
                                const TextStyle(color: Color(0xFFAAAAAA)),
                            errorBorder:
                                Theme.of(context).inputDecorationTheme.border,
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
                              return 'Price Field is required';
                            }
                          },
                          controller: amount,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[0-9.,]+')),
                            LengthLimitingTextInputFormatter(11),
                          ],
                          cursorColor: Commons.primaryColor,
                          keyboardType: TextInputType.number,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 14),
                          decoration: InputDecoration(
                            enabledBorder:
                                Theme.of(context).inputDecorationTheme.border,
                            focusedBorder:
                                Theme.of(context).inputDecorationTheme.border,
                            focusedErrorBorder:
                                Theme.of(context).inputDecorationTheme.border,
                            hintText: 'Price in USD',
                            hintStyle:
                                const TextStyle(color: Color(0xFFAAAAAA)),
                            errorBorder:
                                Theme.of(context).inputDecorationTheme.border,
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
                              return 'About Field is required';
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
                            enabledBorder:
                                Theme.of(context).inputDecorationTheme.border,
                            focusedBorder:
                                Theme.of(context).inputDecorationTheme.border,
                            focusedErrorBorder:
                                Theme.of(context).inputDecorationTheme.border,
                            hintText: 'About',
                            hintStyle:
                                const TextStyle(color: Color(0xFFAAAAAA)),
                            errorBorder:
                                Theme.of(context).inputDecorationTheme.border,
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
                          maxLines: 5,
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
                              if (!await Commons.requestStoragePermission()) {
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
                                    galleries != null && galleries!.isNotEmpty
                                        ? '${galleries!.length} images selected'
                                        : 'Browse',
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
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
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
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }
                        if (featuredImage == null ||
                            featuredImage!.path.isEmpty) {
                          const snackBar = SnackBar(
                              content: Text('Please select featured image'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          return;
                        }
                        if (galleries == null || galleries!.length < 2) {
                          const snackBar = SnackBar(
                              content: Text('Please minimum of 2 images'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          return;
                        }
                        showCupertinoModalBottomSheet(
                          elevation: 0,
                          expand: true,
                          shadow: const BoxShadow(color: Colors.transparent),
                          backgroundColor: Colors.transparent,
                          transitionBackgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) => SelectTruckModal(
                            amount: amount.text.trim(),
                            title: title.text.trim(),
                            about: description.text.trim(),
                            galleries: galleries!,
                            featuredImage: featuredImage!,
                          ),
                        );
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
                          'Continue',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Commons.whiteColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SelectTruckModal extends StatefulWidget {
  final File featuredImage;
  final List<File> galleries;
  final String title;
  final String about;
  final String amount;
  const SelectTruckModal(
      {Key? key,
      required this.featuredImage,
      required this.title,
      required this.galleries,
      required this.amount,
      required this.about})
      : super(key: key);

  @override
  State<SelectTruckModal> createState() => _SelectTruckModalState();
}

class _SelectTruckModalState extends State<SelectTruckModal> {
  String? selectedId;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final truck = watch(truckController);
      final food = watch(foodController);
      return Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(mainAxisSize: MainAxisSize.min, children: [
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
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 20, top: 20),
                    width: context.screenWidth(1),
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select Truck',
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (truck.trucks!.isNotEmpty)
                          Flexible(
                            fit: FlexFit.loose,
                            child: GridView.builder(
                                padding: const EdgeInsets.only(
                                    bottom: 10.0, top: 5.0),
                                itemCount: truck.trucks!.length,
                                scrollDirection: Axis.vertical,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: (1 / 1.1),
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedId = truck.trucks![index].id;
                                        });
                                      },
                                      child: Stack(
                                        children: [
                                          TruckCard(
                                            title: truck.trucks![index].title!,
                                            bannerImage: truck
                                                .trucks![index].bannerImage!,
                                            width: 1,
                                          ),
                                          if (selectedId != null &&
                                              selectedId ==
                                                  truck.trucks![index].id!)
                                            Center(
                                              child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Commons
                                                              .whiteColor,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          100))),
                                                  child: const Icon(
                                                    Icons.check,
                                                    size: 20,
                                                    color: Commons.primaryColor,
                                                  )),
                                            )
                                        ],
                                      ));
                                }),
                          ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            if (food.loading)
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
                                  if (selectedId == null) {
                                    return;
                                  }
                                  try {
                                    final featured = await food
                                        .uploadFile(widget.featuredImage);
                                    final gallery = await food
                                        .uploadFiles(widget.galleries);
                                    if (!await food.create(
                                        selectedId!,
                                        widget.title,
                                        widget.about,
                                        int.parse(widget.amount),
                                        featured,
                                        gallery[0],
                                        gallery)) {
                                      return;
                                    } else {
                                      showGeneralDialog(
                                        barrierLabel: "Barrier",
                                        barrierDismissible: true,
                                        barrierColor:
                                            Colors.black.withOpacity(0.5),
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
                                                      color: Commons
                                                          .primaryColor
                                                          .withOpacity(0.05),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                    child: const Icon(
                                                      Icons.check,
                                                      color:
                                                          Commons.primaryColor,
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
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      'Your cuisine has been addedd\nsuccessfully',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              fontSize: 14),
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
                                                                builder:
                                                                    (context) =>
                                                                        const HomeScreen()),
                                                            (Route<dynamic>
                                                                    route) =>
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
                                                  bottom: 50,
                                                  left: 12,
                                                  right: 12),
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                            ),
                                          );
                                        },
                                        transitionBuilder:
                                            (_, anim, __, child) {
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
                                  } catch (err) {}
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
                      ],
                    )))
          ]));
    });
  }
}
