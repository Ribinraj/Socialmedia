

import 'package:flutter/material.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/presentation/widgets/tex.dart';

class FollowersFollowingLoadingState extends StatelessWidget {
  const FollowersFollowingLoadingState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment
              .spaceBetween,
      children: [
        GestureDetector(
          onTap: () {},
          child: Column(
            children: [
              customHeadingtext(' ', 17,
                  textColor:
                      kblackColor,
                  fontWeight:
                      FontWeight.bold),
              customHeadingtext(
                  'Followers', 15,
                  fontWeight:
                      FontWeight.w400,
                  textColor:
                      kblackColor)
            ],
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Column(
            children: [
              customHeadingtext(' ', 17,
                  textColor:
                      kblackColor,
                  fontWeight:
                      FontWeight.bold),
              customHeadingtext(
                  'Following', 15,
                  fontWeight:
                      FontWeight.w400,
                  textColor:
                      kblackColor)
            ],
          ),
        ),
      ],
    );
  }
}
