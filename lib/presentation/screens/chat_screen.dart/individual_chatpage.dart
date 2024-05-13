import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/data/models/getall_messagemodel.dart';
import 'package:social_media_app/data/socket/socket.dart';
import 'package:social_media_app/presentation/bloc/add_message/add_message_bloc.dart';

import 'package:social_media_app/presentation/bloc/conversation_bloc/conversation_bloc.dart';

import 'package:social_media_app/presentation/screens/chat_screen.dart/datedevider.dart';

import 'package:social_media_app/presentation/screens/chat_screen.dart/ourmessagecard.dart';
import 'package:social_media_app/presentation/screens/chat_screen.dart/replaycard.dart';
import 'package:social_media_app/presentation/screens/home_screen/screen_home.dart';

class IndividualChatPage extends StatefulWidget {
  final String conversationId;
  final String receiverid;
  final String name;
  final String profilepic;
  const IndividualChatPage(
      {super.key,
      required this.conversationId,
      required this.receiverid,
      required this.name,
      required this.profilepic});

  @override
  State<IndividualChatPage> createState() => _IndividualChatPageState();
}

class _IndividualChatPageState extends State<IndividualChatPage> {
  final TextEditingController messageinput = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final scrollController = ScrollController();
  @override
  void initState() {
    context.read<ConversationBloc>().add(
        FetchallMessageInitialEvent(conversationId: widget.conversationId));
    super.initState();
  }

  // @override
  // void dispose() {
  //   messageinput.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leadingWidth: 70,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios_new_rounded)),
            CircleAvatar(
              radius: 21,
              backgroundImage: NetworkImage(widget.profilepic),
            )
          ],
        ),
        title: Text(widget.name,
            style:
                const TextStyle(fontSize: 18.5, fontWeight: FontWeight.bold)),
      ),
      body: Form(
        key: formkey,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height - 180,
                child: BlocBuilder<ConversationBloc, ConversationState>(
                  builder: (context, state) {
                    if (state is FetchAllmessageLoadingState) {
                      return Center(
                        child: LoadingAnimationWidget.fourRotatingDots(
                            color: kpurpleMediumColor, size: 40),
                      );
                    } else if (state is FetchAllmessageSuccessfullState) {
                      List<DateTime> dates = [];
                      List<List<AllMessagesModel>> messagesBydate = [];
                      for (var message in state.messageList) {
                        DateTime date = DateTime(message.createdAt.year,
                            message.createdAt.month, message.createdAt.day);
                        if (!dates.contains(date)) {
                          dates.add(date);
                          messagesBydate.add([message]);
                        } else {
                          messagesBydate.last.add(message);
                        }
                      }
                      dates = dates.reversed.toList();
                      messagesBydate = messagesBydate.reversed.toList();
                      return ListView.builder(
                        controller: scrollController,
                        shrinkWrap: true,
                        reverse: true,
                        itemCount: dates.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              DateDivider(date: dates[index]),
                              ...messagesBydate[index].map((message) {
                                if (message.senderId == loginuserid) {
                                  return OurMessagecard(
                                    message: message.text,
                                    time: message.createdAt,
                                  );
                                } else {
                                  return ReplayMessagecard(
                                    message: message.text,
                                    time: message.updatedAt,
                                  );
                                }
                              })
                            ],
                          );
                        },
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 55,
                      child: Card(
                        margin:
                            const EdgeInsets.only(left: 2, right: 2, bottom: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextFormField(
                          controller: messageinput,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          minLines: 1,
                          decoration: InputDecoration(
                              hintText: "Type a message",
                              prefixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.emoji_emotions))),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8,
                      ),
                      child: CircleAvatar(
                        radius: 25,
                        child: IconButton(
                            onPressed: () {
                              if (messageinput.text.isNotEmpty) {
                                SocketService().sendMessgage(messageinput.text,
                                    widget.receiverid, loginuserid);
                                final message = AllMessagesModel(
                                    id: '',
                                    senderId: loginuserid,
                                    recieverId: widget.receiverid,
                                    conversationId: widget.conversationId,
                                    text: messageinput.text,
                                    isRead: false,
                                    deleteType: '',
                                    createdAt: DateTime.now(),
                                    updatedAt: DateTime.now(),
                                    v: 0);
                                BlocProvider.of<ConversationBloc>(context)
                                    .add(AddNewMessageEvent(message: message));
                                context.read<AddMessageBloc>().add(
                                    AddMessageButtonClickEvent(
                                        message: messageinput.text,
                                        senderId: loginuserid,
                                        recieverId: widget.receiverid,
                                        conversationId: widget.conversationId));
                                messageinput.clear();
                              }
                            },
                            icon: const Icon(Icons.send)),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
