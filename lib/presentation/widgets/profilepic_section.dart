import 'package:flutter/material.dart';

class ProfilePicSection extends StatelessWidget {
  const ProfilePicSection({
    super.key,
    required this.size,
    required this.circleContainerSize, required this.profilepic,
  });

  final Size size;
  final double circleContainerSize;
  final String profilepic;
  @override
  Widget build(BuildContext context) {
    return Positioned(
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
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    profilepic,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
