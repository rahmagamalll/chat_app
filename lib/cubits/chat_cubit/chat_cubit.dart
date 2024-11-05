import 'package:bloc/bloc.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  List<MessageModel> messagesList = [];

  addMessage({required String message, required String email}) {
    messages.add({
      'message': message,
      'Time': DateTime.now(),
      'id': email,
    });
  }

  getMessages() {
    messages.orderBy('Time', descending: true).snapshots().listen(
      (event) {
        messagesList.clear();
        for (var doc in event.docs) {
          messagesList.add(MessageModel.fromJson(doc));
        }
        
        emit(ChatSuccess(messagesList: messagesList)); // بعد ما الرساله اضافت
 
      },
    );
  }
}
