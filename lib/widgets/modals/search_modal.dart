import 'package:flutter/material.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/models/truck_model.dart';
import 'package:food_truck_locator/ui/truck/single.dart';
import 'package:food_truck_locator/utils/constant.dart';
import 'package:food_truck_locator/widgets/truck_card.dart';

class SearchModal extends StatefulWidget {
  final List<TruckModel> trucks;
  const SearchModal({Key? key, required this.trucks}) : super(key: key);

  @override
  State<SearchModal> createState() => _SearchModalState();
}

class _SearchModalState extends State<SearchModal> {
  List<TruckModel> trucks = [];

  void filterFoodByTruck(String title) {
    List<TruckModel> search =
        widget.trucks.where((item) => (item.title!.contains(title))).toList();
    setState(() {
      trucks = search;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                        'Search Truck',
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        cursorColor: Commons.primaryColor,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          if(value.isEmpty) return;
                          filterFoodByTruck(value);
                        },
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
                            hintText: 'Enter word...',
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
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Color(0xFFCCCCCC),
                            )),
                        autocorrect: false,
                        autofocus: false,
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (trucks.isNotEmpty)
                        Flexible(
                          fit: FlexFit.loose,
                          child: GridView.builder(
                              padding:
                                  const EdgeInsets.only(bottom: 10.0, top: 5.0),
                              itemCount: trucks.length,
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
                                              builder: (context) => TruckSingle(
                                                    item: trucks[index],
                                                  )));
                                    },
                                    child: TruckCard(
                                      title: trucks[index].title!,
                                      bannerImage: trucks[index].bannerImage!,
                                      width: 0.5,
                                    ));
                              }),
                        )
                    ],
                  )))
        ]));
  }
}
