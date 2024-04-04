import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/presentation/cubit/bottomnav_cubit/bottonav_cubit.dart';
import 'package:social_media_app/presentation/screens/add_post/screen_addpost.dart';
import 'package:social_media_app/presentation/screens/home_screen/screen_home.dart';
import 'package:social_media_app/presentation/screens/user_profile_screen/screen_userprofile.dart';
import 'package:social_media_app/presentation/screens/search_screen/screen_search.dart';

class SCreenmainpage extends StatefulWidget {
  const SCreenmainpage({super.key});

  @override
  State<SCreenmainpage> createState() => _SCreenmainpageState();
}

class _SCreenmainpageState extends State<SCreenmainpage> {
  final pagecontroller = PageController();

  @override
  void dispose() {
    pagecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pagecontroller,
        children: const <Widget>[
          ScreenHome(),
          ScreenSearch(),
          ScreenAddPost(),
          ScreenUserProfile()
        ],
        onPageChanged: (value) {
          context.read<BottomnavCubit>().onpageChanged(value);
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomnavCubit, int>(
        builder: (context, state) {
          return CurvedNavigationBar(
            backgroundColor: kpurplelightColor,
            buttonBackgroundColor: kpurpleMediumColor,
            color: kpurpleColor,
            height: 55,
            index: state,
            items: const <Widget>[
              Icon(
                Icons.home,
                size: 30,
                color: kwhiteColor,
              ),
              Icon(
                Icons.search,
                size: 30,
                color: kwhiteColor,
              ),
              Icon(
                Icons.add,
                size: 30,
                color: kwhiteColor,
              ),
              Icon(
                Icons.person,
                size: 30,
                color: kwhiteColor,
              )
            ],
            onTap: (index) {
              pagecontroller.animateToPage(index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut);
            },
          );
        },
      ),
    );
  }
}
//stack index
// import 'package:flutter/material.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:social_media_app/core/colors.dart';
// import 'package:social_media_app/presentation/cubit/bottomnav_cubit/bottonav_cubit.dart';
// import 'package:social_media_app/presentation/screens/add_post/screen_addpost.dart';
// import 'package:social_media_app/presentation/screens/home_screen/screen_home.dart';
// import 'package:social_media_app/presentation/screens/user_profile_screen/screen_userprofile.dart';
// import 'package:social_media_app/presentation/screens/search_screen/screen_search.dart';

// class SCreenmainpage extends StatefulWidget {
//   const SCreenmainpage({super.key});

//   @override
//   State<SCreenmainpage> createState() => _SCreenmainpageState();
// }

// class _SCreenmainpageState extends State<SCreenmainpage> {
//   final pagecontroller = PageController();
//   List<Widget> pages = [];

//   @override
//   void initState() {
//     pages = const [
//       ScreenHome(),
//       ScreenSearch(),
//       ScreenAddPost(),
//       ScreenUserProfile()
//     ];
//     super.initState();
//   }

//   @override
//   void dispose() {
//     pagecontroller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView.builder(
//         controller: pagecontroller,
//         // children: const <Widget>[
//         // ScreenHome(),
//         // ScreenSearch(),
//         // ScreenAddPost(),
//         // ScreenUserProfile()
//         // ],
//         itemCount: pages.length,
//         itemBuilder: (context, index) {
//           return IndexedStack(
//             index: index,
//             children: pages,
//           );
//         },
//         onPageChanged: (value) {
//           context.read<BottomnavCubit>().onpageChanged(value);
//         },
//       ),
//       bottomNavigationBar: BlocBuilder<BottomnavCubit, int>(
//         builder: (context, state) {
//           return CurvedNavigationBar(
//             backgroundColor: kpurplelightColor,
//             buttonBackgroundColor: kpurpleMediumColor,
//             color: kpurpleColor,
//             height: 55,
//             index: state,
//             items: const <Widget>[
//               Icon(
//                 Icons.home,
//                 size: 30,
//                 color: kwhiteColor,
//               ),
//               Icon(
//                 Icons.search,
//                 size: 30,
//                 color: kwhiteColor,
//               ),
//               Icon(
//                 Icons.add,
//                 size: 30,
//                 color: kwhiteColor,
//               ),
//               Icon(
//                 Icons.person,
//                 size: 30,
//                 color: kwhiteColor,
//               )
//             ],
//             onTap: (index) {
//               pagecontroller.animateToPage(index,
//                   duration: const Duration(milliseconds: 300),
//                   curve: Curves.easeOut);
//             },
//           );
//         },
//       ),
//     );
//   }
// }
