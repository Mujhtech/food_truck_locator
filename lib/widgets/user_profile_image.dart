import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_truck_locator/utils/constant.dart';

class UserProfileImage extends StatelessWidget {
  final String? image;
  final double? radius;
  const UserProfileImage({Key? key, this.radius, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return image != null && image != ""
        ? CachedNetworkImage(
            imageUrl: image!,
            imageBuilder: (context, imageProvider) => CircleAvatar(
              backgroundImage: imageProvider,
              backgroundColor: Commons.primaryColor,
              radius: radius! / 2,
            ),
            placeholder: (context, url) => Stack(children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Container(
                    color: const Color(0xFFEFEFEF),
                    width: radius,
                    height: radius,
                    child: const SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Commons.primaryColor),
                        strokeWidth: 2,
                      ),
                    ),
                  )),
            ]),
            errorWidget: (context, url, error) => ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  color: const Color(0xFFEFEFEF),
                  width: radius,
                  height: radius,
                  child: SvgPicture.asset(
                    'assets/images/User.svg',
                    width: 200,
                    height: 200,
                    color: const Color(0xFF656565),
                  ),
                )),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: Container(
              padding: const EdgeInsets.all(20),
              color: const Color(0xFFEFEFEF),
              width: radius,
              height: radius,
              child: SvgPicture.asset(
                'assets/images/User.svg',
                width: 200,
                height: 200,
                color: const Color(0xFF656565),
              ),
            ));
  }
}
