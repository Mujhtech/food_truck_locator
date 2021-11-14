import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/models/truck_model.dart';
import 'package:food_truck_locator/utils/constant.dart';
import 'package:food_truck_locator/widgets/modals/book_modal.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TruckLookUp extends StatefulWidget {
  final TruckModel item;
  const TruckLookUp({Key? key, required this.item}) : super(key: key);

  @override
  State<TruckLookUp> createState() => _TruckLookUpState();
}

class _TruckLookUpState extends State<TruckLookUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Container(
            width: context.screenWidth(1),
            height: context.screenHeight(1),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/Group.png'))),
          ),
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
                                child: SvgPicture.asset(
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
                                    '5km',
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
