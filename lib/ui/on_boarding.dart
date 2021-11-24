import 'package:flutter/material.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/ui/auth/home.dart';
import 'package:food_truck_locator/utils/constant.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int slideIndex = 0;
  PageController controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      height: 6.0,
      width: isCurrentPage ? 28.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Commons.primaryColor : const Color(0xFFBFE5FF),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AuthHomeScreen()));
                  },
                  child: Text(
                    'Skip',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ),
              SizedBox(
                height: context.screenHeight(0.6),
                child: PageView(
                  controller: controller,
                  onPageChanged: (index) {
                    setState(() {
                      slideIndex = index;
                    });
                  },
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/Onboard-1.png',
                          width: 280,
                          height: 280,
                        ),
                        Text(
                          'Locate the best Food Trucks near you',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  fontWeight: FontWeight.w900, fontSize: 28),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/Onboard-2.png',
                          width: 280,
                          height: 280,
                        ),
                        Text(
                          'Get food and other valuables',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  fontWeight: FontWeight.w900, fontSize: 28),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/Onboard-3.png',
                          width: 280,
                          height: 280,
                        ),
                        Text(
                          'Deliver with best Food Trucks near you',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  fontWeight: FontWeight.w900, fontSize: 28),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                for (int i = 0; i < 3; i++)
                  i == slideIndex
                      ? _buildPageIndicator(true)
                      : _buildPageIndicator(false),
              ]),
              const SizedBox(
                height: 10,
              ),
              MaterialButton(
                onPressed: () async {
                  if (slideIndex == 2) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AuthHomeScreen()));
                  } else {
                    controller.nextPage(
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeIn);
                    setState(() {
                      slideIndex = slideIndex + 1;
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
                    slideIndex == 2 ? 'Continue' : 'Next',
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: Commons.whiteColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
