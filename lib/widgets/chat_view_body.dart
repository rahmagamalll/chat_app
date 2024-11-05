import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ChatViewBody extends StatelessWidget {
  final ScrollController _controller = ScrollController();

  TextEditingController controller = TextEditingController();
  String? textFeildData;

  @override
  Widget build(BuildContext context) {
    // List<MessageModel> messagesList = [];
    //ممكن اشيلها واشيل اللي جايه من الاستيت واستعمل اللي عملتها تحت او دي بس اللي تحت مع الهوت ريلود المسدجات هتفضل موجوده بس الاتنين ينفعو لان اليوزر معندوش هوت ريلود
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is ChatSuccess) {
          // messagesList = state.messagesList; //اشيلها مع دي واخلي الويدجيت بليدر بما ان مش محتاجه ال ليسينر  في حاجه اخليه بليدر
        }
      },
      builder: (context, state) {
        var messageListCubit = BlocProvider.of<ChatCubit>(context).messagesList;
        return Scaffold(
          backgroundColor: kPrimaryBackgroundColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: kPrimaryAppBarColor,
            elevation: 0,
            shadowColor: kPrimaryBackgroundColor,
            title: const Text(
              'Chat',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryBackgroundColor,
                  fontSize: 15),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    reverse:
                        true, //بما ان هي ريفيرس اللي فوق تحت واللي تحت فوق هخلي ال التصاعدي ترو
                    controller: _controller,
                    itemCount: messageListCubit.length,
                    itemBuilder: (context, index) {
                      return messageListCubit[index].id ==
                              ModalRoute.of(context)!
                                  .settings
                                  .arguments //email الللي جاي مع الويدجيت ف البوش نيمد في اللوجين بيدج
                          ? ChatBuble(
                              message: messageListCubit[index],
                            )
                          : ChatBubleForFriend(
                              message: messageListCubit[index]);
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: controller,
                  onSubmitted: (data) {
                    BlocProvider.of<ChatCubit>(context).addMessage(
                        message: data,
                        email: ModalRoute.of(context)!
                            .settings
                            .arguments
                            .toString() /*email*/);

                    controller.clear();
                    void _scrollDown() {
                      _controller.animateTo(
                        0, //هتبدا من تحت
                        duration: Duration(seconds: 2),
                        curve: Curves.fastOutSlowIn,
                      );
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(11),
                    hintText: 'Send Message',
                    hintStyle: TextStyle(fontSize: 12),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.send),
                      color: kPrimaryAppBarColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: kPrimaryAppBarColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: kPrimaryAppBarColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}




//oooollllllllllddddddd

// class ChatViewBody extends StatefulWidget {
//   const ChatViewBody({super.key});

//   @override
//   State<ChatViewBody> createState() => _ChatViewBodyState();
// }

// class _ChatViewBodyState extends State<ChatViewBody> {
//   final ScrollController _controller = ScrollController();

//   TextEditingController controller = TextEditingController();
//   String? textFeildData;

//   @override
//   Widget build(BuildContext context) {
//     CollectionReference messages =
//         FirebaseFirestore.instance.collection('messages');

//     return StreamBuilder<QuerySnapshot>(
//       stream: messages.orderBy('Time', descending: true).snapshots(),
//       builder: (context, snapshot) {
//         List<MessageModel> messagesList = [];

//         if (snapshot.hasData) {
//           for (int i = 0; i < snapshot.data!.docs.length; i++) {
//             messagesList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
//           }
//         }
//         return Scaffold(
//           backgroundColor: kPrimaryBackgroundColor,
//           appBar: AppBar(
//             automaticallyImplyLeading: false,
//             backgroundColor: kPrimaryAppBarColor,
//             elevation: 0,
//             shadowColor: kPrimaryBackgroundColor,
//             title: const Text(
//               'Chat',
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: kPrimaryBackgroundColor,
//                   fontSize: 15),
//             ),
//             centerTitle: true,
//           ),
//           body: Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                     reverse:
//                         true, //بما ان هي ريفيرس اللي فوق تحت واللي تحت فوق هخلي ال التصاعدي ترو
//                     controller: _controller,
//                     itemCount: messagesList.length,
//                     itemBuilder: (context, index) {
//                       return messagesList[index].id ==
//                               ModalRoute.of(context)!
//                                   .settings
//                                   .arguments // الللي جاي مع الويدجيت ف البوش نيمد في اللوجين بيدج
//                           ? ChatBuble(
//                               message: messagesList[index],
//                             )
//                           : ChatBubleForFriend(message: messagesList[index]);
//                     }),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: TextField(
//                   controller: controller,
//                   onSubmitted: (data) {
//                     messages.add({
//                           'message': data,
//                           'Time': DateTime.now(),
//                           'id': ModalRoute.of(context)!
//                               .settings
//                               .arguments, //email
//                         });
//                         controller.clear();
//                         void _scrollDown() {
//                           _controller.animateTo(
//                             0, //هتبدا من تحت
//                             duration: Duration(seconds: 2),
//                             curve: Curves.fastOutSlowIn,
//                           );
//                         }
//                   },
//                   decoration: InputDecoration(
//                     contentPadding: EdgeInsets.all(11),
//                     hintText: 'Send Message',
//                     hintStyle: TextStyle(fontSize: 12),
//                     suffixIcon: IconButton(
//                       onPressed: () {
                       
//                       },
//                       icon: Icon(Icons.send),
//                       color: kPrimaryAppBarColor,
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(16),
//                       borderSide: const BorderSide(
//                         color: kPrimaryAppBarColor,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(16),
//                       borderSide: const BorderSide(
//                         color: kPrimaryAppBarColor,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
