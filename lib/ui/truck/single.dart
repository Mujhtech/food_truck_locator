import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_truck_locator/controllers/auth_controller.dart';
import 'package:food_truck_locator/controllers/food_controller.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/models/truck_model.dart';
import 'package:food_truck_locator/ui/food/single.dart';
import 'package:food_truck_locator/ui/home.dart';
import 'package:food_truck_locator/ui/truck/edit.dart';
import 'package:food_truck_locator/ui/truck/look_up.dart';
import 'package:food_truck_locator/utils/constant.dart';
import 'package:food_truck_locator/widgets/food_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class TruckSingle extends StatefulWidget {
  final TruckModel item;
  const TruckSingle({Key? key, required this.item}) : super(key: key);

  @override
  State<TruckSingle> createState() => _TruckSingleState();
}

class _TruckSingleState extends State<TruckSingle>
    with SingleTickerProviderStateMixin {
  late TabController _myTab;

  @override
  void initState() {
    super.initState();

    _myTab = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _myTab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final food = watch(foodController);
      final auth = watch(authControllerProvider);
      return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Stack(children: [
            Container(
                width: context.screenWidth(1),
                height: 160,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFEFEF),
                  image: DecorationImage(
                      image:
                          CachedNetworkImageProvider(widget.item.bannerImage!),
                      fit: BoxFit.cover),
                ),
                padding: const EdgeInsets.all(50),
                child: Container()),
            Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisSize: MainAxisSize.min,
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
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
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              width: 105,
                              height: 105,
                              child: widget.item.featuredImage != null &&
                                      widget.item.featuredImage!.isNotEmpty
                                  ? Container(
                                      width: 200,
                                      height: 200,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8)),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: CachedNetworkImageProvider(
                                                  widget.item.featuredImage!))),
                                    )
                                  : SvgPicture.asset(
                                      'assets/images/User.svg',
                                      width: 200,
                                      height: 200,
                                      color: const Color(0xFF656565),
                                    ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                  width: 225,
                                  child: Text(
                                    widget.item.title!,
                                    overflow: TextOverflow.visible,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                            color: Commons.primaryColor,
                                            fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/Location.svg',
                                      width: 20,
                                      height: 20,
                                      color: const Color(0xFF656565),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      widget.item.location!,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0E0E0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TabBar(
                            controller: _myTab,
                            indicatorColor: Commons.whiteColor,
                            isScrollable: true,
                            labelColor: const Color(0xFF000000),
                            labelStyle: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(fontSize: 14),
                            tabs: const [
                              Tab(
                                text: 'Details',
                              ),
                              Tab(text: 'Cruisine'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                          child: TabBarView(controller: _myTab, children: [
                        ListView(
                          children: [
                            Text(widget.item.description!,
                                style: Theme.of(context).textTheme.bodyText1),
                            const SizedBox(
                              height: 10,
                            ),
                            Text('Contact Us',
                                style: Theme.of(context).textTheme.bodyText1),
                            const SizedBox(
                              height: 10,
                            ),
                            widget.item.website != null &&
                                    widget.item.website!.isNotEmpty
                                ? GestureDetector(
                                    onTap: () async {
                                      if (await canLaunch(
                                          widget.item.website!)) {
                                        await launch(widget.item.website!);
                                      } else {
                                        throw 'Could not launch the url';
                                      }
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                                    fontWeight:
                                                        FontWeight.w600)),
                                      ],
                                    ),
                                  )
                                : Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.language,
                                        size: 20,
                                        color: Color(0xFF656565),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text('No url',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: Commons.primaryColor,
                                                  fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text('Images',
                                style: Theme.of(context).textTheme.bodyText1),
                            const SizedBox(
                              height: 10,
                            ),
                            if (widget.item.galleries != null &&
                                widget.item.galleries!.isNotEmpty)
                              GridView.builder(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.only(
                                      bottom: 10.0, top: 5.0),
                                  itemCount: widget.item.galleries!.length,
                                  scrollDirection: Axis.vertical,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: (1 / 1.1),
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: context.screenWidth(0.5),
                                      height: 165,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                  widget
                                                      .item.galleries![index]),
                                              fit: BoxFit.cover)),
                                    );
                                  })
                            else
                              Center(
                                child: Text('No images found',
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
                              ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [
                                MaterialButton(
                                  onPressed: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => TruckLookUp(
                                                item: widget.item)));
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
                                      'I want to find you',
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
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeScreen()),
                                        (Route<dynamic> route) => false);
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
                                      'Find Food Truck in my street',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: Commons.primaryColor),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                if (auth.user != null &&
                                    widget.item.userId == auth.user!.uid)
                                  MaterialButton(
                                    onPressed: () async {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TruckEdit(
                                                    item: widget.item,
                                                  )));
                                    },
                                    elevation: 0,
                                    color:
                                        Commons.primaryColor.withOpacity(0.1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Container(
                                      width: context.screenWidth(1),
                                      height: 53,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Edit Truck',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: Commons.primaryColor),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ],
                        ),
                        if (food.filterFoodByTruck(widget.item.id!).isNotEmpty)
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                fit: FlexFit.loose,
                                child: GridView.builder(
                                    padding: const EdgeInsets.only(
                                        bottom: 10.0, top: 5.0),
                                    itemCount: food
                                        .filterFoodByTruck(widget.item.id!)
                                        .length,
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
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => FoodSingle(
                                                      item:
                                                          food.filterFoodByTruck(
                                                                  widget.item
                                                                      .id!)[
                                                              index])));
                                        },
                                        child: FoodCard(
                                          page: 2,
                                          title: food
                                              .filterFoodByTruck(
                                                  widget.item.id!)[index]
                                              .title!,
                                          bannerImage: food
                                              .filterFoodByTruck(
                                                  widget.item.id!)[index]
                                              .bannerImage!,
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          )
                        else
                          ListView(
                            children: [
                              Center(
                                  child: Text(
                                'No cuisines available',
                                style: Theme.of(context).textTheme.bodyText1,
                              ))
                            ],
                          )
                      ]))
                    ]))
          ]));
    });
  }
}
