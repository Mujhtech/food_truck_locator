import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_truck_locator/controllers/food_controller.dart';
import 'package:food_truck_locator/controllers/message_controller.dart';
import 'package:food_truck_locator/controllers/user_controller.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/models/order_model.dart';
import 'package:food_truck_locator/utils/constant.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class SingleOrderModal extends StatefulWidget {
  final OrderModel item;
  const SingleOrderModal({Key? key, required this.item}) : super(key: key);

  @override
  State<SingleOrderModal> createState() => _SingleOrderModalState();
}

class _SingleOrderModalState extends State<SingleOrderModal> {
  TextEditingController messageInput = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final food = watch(foodController);
      final user = watch(userControllerProvider);
      final message = watch(messageControllerProvider);
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
                          image: CachedNetworkImageProvider(food
                              .filterFoodbyId(widget.item.foodId!)
                              .bannerImage!),
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
                        left: 10, right: 10, bottom: 20, top: 20),
                    width: context.screenWidth(1),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: ListView(children: [
                      Center(
                        child: Text(
                          food.filterFoodbyId(widget.item.foodId!).title!,
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  color: Commons.primaryColor,
                                  fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Text('${widget.item.qty} QTY',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Commons.primaryColor.withOpacity(0.1),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.shopping_cart,
                                size: 24, color: Commons.primaryColor),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(widget.item.status!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        color: Commons.primaryColor,
                                        fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Row(children: [
                            Text(
                              'Feedback',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.thumb_up_alt,
                              color: Colors.black,
                              size: 20,
                            )
                          ]),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: const Color(0xFFFBFBFB),
                            height: 100,
                            padding: const EdgeInsets.all(10),
                            width: context.screenWidth(1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                widget.item.comment != null &&
                                        widget.item.comment!.isNotEmpty
                                    ? Text(widget.item.comment!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                              fontWeight: FontWeight.w600,
                                            ))
                                    : Text('No feedback yet',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                              fontWeight: FontWeight.w600,
                                            )),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Row(children: [
                            Text(
                              'Delivery',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.local_shipping,
                              color: Colors.black,
                              size: 20,
                            )
                          ]),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: const Color(0xFFFBFBFB),
                            height: 148,
                            padding: const EdgeInsets.all(10),
                            width: context.screenWidth(1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    user
                                        .filterUserbyId(widget.item.userId!)
                                        .fullName!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontWeight: FontWeight.w600,
                                        )),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    user
                                            .filterUserbyId(widget.item.userId!)
                                            .email! +
                                        '\n' +
                                        user
                                            .filterUserbyId(widget.item.userId!)
                                            .phoneNumber!,
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    widget.item.shippingPostalCode! +
                                        ', ' +
                                        widget.item.shippingAddress! +
                                        ', \n' +
                                        widget.item.shippingCity! +
                                        ' ' +
                                        widget.item.shippingCountry!,
                                    style:
                                        Theme.of(context).textTheme.bodyText2)
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(children: [
                        Text(
                          'Messages',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.forum,
                          color: Colors.black,
                          size: 20,
                        )
                      ]),
                      const SizedBox(
                        height: 10,
                      ),
                      if (message
                          .filterMessageByOrderId(widget.item.id!)
                          .isNotEmpty)
                        ...message.filterMessageByOrderId(widget.item.id!).map(
                            (e) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user
                                            .filterUserbyId(e.userId!)
                                            .fullName!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                      Container(
                                          color: const Color(0xFFFBFBFB),
                                          height: 40,
                                          padding: const EdgeInsets.all(10),
                                          width: context.screenWidth(1),
                                          child: Text(
                                            e.message!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                          )),
                                      Text(
                                        DateFormat('dd-MM-yyyy – kk:mm')
                                            .format(e.createdAt!),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ])),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          TextFormField(
                            controller: messageInput,
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
                              hintText: 'Enter message....',
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
                              suffixIcon: GestureDetector(
                                onTap: () async {
                                  if (messageInput.text.trim().isEmpty) {
                                    return;
                                  }
                                  if (!await message.create(
                                      widget.item.id!,
                                      widget.item.foodOwnerId!,
                                      widget.item.userId!,
                                      messageInput.text.trim())) {
                                    return;
                                  }
                                  messageInput.text = '';
                                  //print(0);
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(right: 4),
                                    decoration: const BoxDecoration(
                                        color: Commons.primaryColor,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(6),
                                            bottomRight: Radius.circular(6))),
                                    child: const Icon(
                                      Icons.send,
                                      color: Commons.whiteColor,
                                    )),
                              ),
                              filled: true,
                            ),
                            autocorrect: false,
                            autofocus: false,
                            obscureText: false,
                          ),
                        ],
                      )
                    ])))
          ]));
    });
  }
}
