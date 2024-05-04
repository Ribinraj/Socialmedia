import 'package:flutter/material.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';

import 'package:social_media_app/presentation/widgets/custom_profile_button.dart';
import 'package:social_media_app/presentation/widgets/tex.dart';

class ScreenProfile extends StatelessWidget {
  ScreenProfile({super.key});
  final List imageList = [
    "https://img.freepik.com/free-photo/sports-car-driving-asphalt-road-night-generative-ai_188544-8052.jpg?w=900&t=st=1711111620~exp=1711112220~hmac=5dbcde759ef836ae9d03590c6b7500a636ee1b95c9fd83c2ff1c292472746715",
    "https://stimg.cardekho.com/images/carexteriorimages/630x420/Mahindra/Thar/10745/1697697308167/front-left-side-47.jpg?imwidth=420&impolicy=resize",
    "https://img.freepik.com/free-photo/beautiful-view-greenery-bridge-forest-perfect-background_181624-17827.jpg?size=626&ext=jpg&ga=GA1.1.735520172.1711065600&semt=ais",
    "https://images.pexels.com/photos/707046/pexels-photo-707046.jpeg?cs=srgb&dl=pexels-trace-constant-707046.jpg&fm=jpg",
    "https://i.pinimg.com/736x/d0/4b/1f/d04b1f2ed3ca8ad4a302fbe9f4f5a875.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const double circleContainerSize = 130.0;

    return Scaffold(
      body: SizedBox(
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  const SizedBox(
                    height: 430,
                    width: double.infinity,
                  ),
                  Container(
                    width: double.infinity,
                    height: 250,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://img.freepik.com/free-photo/sports-car-driving-asphalt-road-night-generative-ai_188544-8052.jpg?w=900&t=st=1711111620~exp=1711112220~hmac=5dbcde759ef836ae9d03590c6b7500a636ee1b95c9fd83c2ff1c292472746715"),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 200.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      height: 230,
                      decoration: const BoxDecoration(
                        color: kpurplelightColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 35, right: 35, top: 15, bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      customHeadingtext('100K ', 17,
                                          textColor: kblackColor,
                                          fontWeight: FontWeight.bold),
                                      customHeadingtext('Followers', 15,
                                          fontWeight: FontWeight.w400,
                                          textColor: kblackColor)
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      customHeadingtext('100K', 17,
                                          textColor: kblackColor,
                                          fontWeight: FontWeight.bold),
                                      customHeadingtext('Following', 15,
                                          fontWeight: FontWeight.w400,
                                          textColor: kblackColor)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          customHeadingtext('Vyshak OP', 22,
                              textColor: kblackColor,
                              fontWeight: FontWeight.w500),
                          customHeadingtext('ernamkulam', 17,
                              textColor: kblackColor),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomProfilebutton(
                                  onPressed: () {}, buttonText: 'Follow'),
                              kwidth20,
                              CustomProfilebutton(
                                  onPressed: () {}, buttonText: 'Message')
                            ],
                          ),
                          kheight,
                          customHeadingtext('All Posts', 20,
                              textColor: kblackColor,
                              fontWeight: FontWeight.w500)
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 140,
                    left: (size.width - circleContainerSize) / 2,
                    child: Container(
                      height: circleContainerSize,
                      width: circleContainerSize,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: UnconstrainedBox(
                        child: ClipOval(
                          child: Container(
                            height: circleContainerSize - 10,
                            width: circleContainerSize - 10,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://stimg.cardekho.com/images/carexteriorimages/630x420/Mahindra/Thar/10745/1697697308167/front-left-side-47.jpg?imwidth=420&impolicy=resize",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                padding: const EdgeInsets.all(5),
                shrinkWrap: true,
                itemCount: imageList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          imageList[index],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//

//////////
