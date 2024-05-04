import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/presentation/bloc/followerspost/fetch_followerspost_bloc.dart';

import 'package:social_media_app/presentation/bloc/report_post/report_post_bloc.dart';
import 'package:social_media_app/presentation/cubit/reportCubit/bottonav_cubit.dart';

class ReportPostDialog extends StatelessWidget {
  final List<String> reportReasons = [
    'Inappropriate content',
    'Spam',
    'Harassment',
    'Misinformation',
  ];

  ReportPostDialog({Key? key, required this.state, required this.index})
      : super(key: key);
  final FetchFollowersPostSuccessState state;

  final int index;
  @override
  Widget build(BuildContext context) {
    final reportdata = context.read<ReportPostBloc>();
    final post = state.followersposts[index];

    return BlocBuilder<ReportCubit, String?>(
      builder: (context, selectedReason) {
        return SimpleDialog(
          title: const Text('Report Post'),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: reportReasons
                    .map((reason) => RadioListTile(
                          title: Text(reason),
                          value: reason,
                          groupValue: selectedReason,
                          onChanged: (value) => context
                              .read<ReportCubit>()
                              .selectReason(value as String),
                        ))
                    .toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: selectedReason != null
                      ? () {
                          reportdata.add(ReportpostClickEvent(
                              postId: post.id, reportType: selectedReason));
                          Navigator.pop(context);
                        }
                      : null,
                  child: const Text('Report'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
