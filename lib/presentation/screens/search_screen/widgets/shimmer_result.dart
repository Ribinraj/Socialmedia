import 'package:flutter/material.dart';


import 'package:shimmer/shimmer.dart';
import 'package:social_media_app/core/colors.dart';

class ShimmerResultWidget extends StatelessWidget {
  const ShimmerResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 3,
                mainAxisSpacing: 3,
                childAspectRatio: .75,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  
                  return  ClipRRect(
                    
                    borderRadius: BorderRadius.circular(10),
                    child:     Shimmer(
                            gradient: const LinearGradient(colors: [
                              kpurpleMediumColor,
                              kpurplelightColor
                            ]),
                            child: Container(),)
                  );
                },
                childCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}