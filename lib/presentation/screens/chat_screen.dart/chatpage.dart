import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_builder.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';
import 'package:social_media_app/data/models/get_conversation.dart';
import 'package:social_media_app/data/models/get_singleuser_model.dart';
import 'package:social_media_app/presentation/bloc/add_message/add_message_bloc.dart';
import 'package:social_media_app/presentation/bloc/fetchall_conversation/fetchall_conversation_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:social_media_app/presentation/screens/chat_screen.dart/individual_chatpage.dart';
import 'package:social_media_app/presentation/screens/chat_screen.dart/select_contactpage.dart';
import 'package:social_media_app/presentation/widgets/custom_navigator.dart';
import 'package:social_media_app/presentation/widgets/custom_round_image.dart';
import 'package:social_media_app/presentation/widgets/tex.dart';

class Chatpage extends StatefulWidget {
  const Chatpage({super.key});

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  List<ConversationModel> conversations = [];
  List<GetUserModel> users = [];
  List<GetUserModel> filteredUsers = [];
  String? onchanged;

  final searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    context
        .read<FetchallConversationBloc>()
        .add(AllConversationsInitialFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigatePush(context, const SelectContact());
          },
          child: const Icon(Icons.chat),
        ),
        appBar: AppBar(
          backgroundColor: kpurpleColor,
          title: customHeadingtext('Messages', 25),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 20,
                  child: CupertinoSearchTextField(
                    controller: searchController,
                    backgroundColor: kpurplelightColor.withOpacity(0.4),
                    prefixIcon: const Icon(
                      CupertinoIcons.search,
                      color: kpurpleBorderColor,
                    ),
                    suffixIcon: const Icon(CupertinoIcons.xmark_circle_fill,
                        color: kpurpleMediumColor),
                    style: const TextStyle(color: kpurpleColor),
                    onChanged: (value) {
                      onchanged = value;
                      setState(() {});
                    },
                  ),
                ),
                kheight20
              ],
            ),
          ),
        ),
        body: MultiBlocBuilder(
          blocs: [
            context.watch<FetchallConversationBloc>(),
            context.watch<AddMessageBloc>()
          ],
          builder: (context, state) {
            var state1 = state[0];
            if (state1 is FetchAllCnversationLoadingstate) {
              return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                    color: kpurpleMediumColor, size: 40),
              );
            } else if (state1 is FetchAllconversationSuccessState) {
              conversations = state1.conversations;
              users = state1.otherusers;
              filteredUsers = state1.otherusers
                  .where(
                      (element) => element.userName.contains(onchanged ?? ''))
                  .toList();
              return filteredUsers.isEmpty
                  ? const Center(
                      child: Text(
                        'No chat found',
                        style: TextStyle(color: kblackColor),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredUsers.length,
                      itemBuilder: ((context, index) {
                        final ConversationModel conversation =
                            conversations[index];
                        final user = filteredUsers[index];
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                navigatePush(
                                    context,
                                    IndividualChatPage(
                                        conversationId: conversation.id,
                                        receiverid: user.id,
                                        name: user.userName,
                                        profilepic: user.profilePic));
                              },
                              child: ListTile(
                                leading: CustomRoundImage(
                                    circleContainerSize: 40,
                                    imageUrl: user.profilePic),
                                title: Text(
                                  user.userName,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  conversation.lastMessage ?? "",
                                  style: const TextStyle(fontSize: 15),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                trailing: conversation.lastMessageTime == null
                                    ? const Text('')
                                    : customstyletext(
                                        timeago.format(conversation
                                            .lastMessageTime!
                                            .toLocal()),
                                        13,
                                        textColor: kgreycolor),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 20, left: 80),
                              child: Divider(
                                thickness: 1,
                              ),
                            )
                          ],
                        );
                      }));
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
