import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_truck_locator/ui/home/cart.dart';
import 'package:food_truck_locator/ui/home/explore.dart';
import 'package:food_truck_locator/ui/home/nearby.dart';
import 'package:food_truck_locator/ui/home/profile.dart';
import 'package:food_truck_locator/utils/constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int index = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> screens = [
    const ExploreScreen(),
    const NearbyScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  SystemUiOverlayStyle mySystemTheme = SystemUiOverlayStyle.light
      .copyWith(systemNavigationBarColor: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedLabelStyle:
            Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12),
        unselectedLabelStyle:
            Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12),
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        iconSize: 18,
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        selectedItemColor: Commons.primaryColor,
        unselectedItemColor: const Color(0xFF656565),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/Search.svg',
                color: _selectedIndex == 0
                    ? Commons.primaryColor
                    : const Color(0xFF656565),
                semanticsLabel: 'Explore'),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/NearBy.svg',
                color: _selectedIndex == 1
                    ? Commons.primaryColor
                    : const Color(0xFF656565),
                semanticsLabel: 'Near By'),
            label: 'Near By',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/Cart.svg',
                color: _selectedIndex == 2
                    ? Commons.primaryColor
                    : const Color(0xFF656565),
                semanticsLabel: 'Cart'),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/User.svg',
                color: _selectedIndex == 3
                    ? Commons.primaryColor
                    : const Color(0xFF656565),
                semanticsLabel: 'Profile'),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
