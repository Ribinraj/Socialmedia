import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/presentation/cubit/cubits/cubit/toggle_password_cubit.dart';

Widget togglePassword() {
    return BlocBuilder<TogglepasswordCubit, bool>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            context.read<TogglepasswordCubit>().togglePassword();
          },
          icon: state
              ? const Icon(
                  Icons.visibility,
                  color:kpurpleColor,
                )
              : const Icon(
                  Icons.visibility_off,
                  color: kpurpleColor,
                ),
        );
      },
    );
  }