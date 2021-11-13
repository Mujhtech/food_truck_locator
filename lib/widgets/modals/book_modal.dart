import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/models/truck_model.dart';
import 'package:food_truck_locator/ui/book.dart';
import 'package:food_truck_locator/ui/reservation.dart';
import 'package:food_truck_locator/utils/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class BookModal extends StatefulWidget {
  final TruckModel item;
  const BookModal({Key? key, required this.item}) : super(key: key);

  @override
  State<BookModal> createState() => _BookModalState();
}

class _BookModalState extends State<BookModal> {
  TextEditingController specialRequest = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisSize: MainAxisSize.min,
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
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
              width: context.screenWidth(1),
              height: 150,
              child: Stack(children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16)),
                      image: DecorationImage(
                        image: NetworkImage(widget.item.bannerImage!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                    child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16)),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.transparent,
                        Colors.transparent,
                        Colors.white
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0, 0, 0.2, 1],
                    ),
                  ),
                ))
              ])),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, bottom: 30, top: 20),
              width: context.screenWidth(1),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Center(
                        child: Text(
                          widget.item.title!,
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  color: Commons.primaryColor,
                                  fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.item.location!,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '5km Away',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 14, color: Commons.primaryColor),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (await canLaunch(widget.item.website!)) {
                        await launch(widget.item.website!);
                      } else {
                        throw 'Could not launch the url';
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.language,
                          size: 20,
                          color: Color(0xFF656565),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(widget.item.website!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: Commons.primaryColor,
                                    fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      MaterialButton(
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookingScreen(
                                        item: widget.item,
                                      )));
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
                            'Book Now',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Commons.whiteColor),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReservationScreen(
                                        item: widget.item,
                                      )));
                        },
                        elevation: 0,
                        color: Commons.primaryColor.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          width: context.screenWidth(1),
                          height: 53,
                          alignment: Alignment.center,
                          child: Text(
                            'Make reservations',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Commons.primaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
