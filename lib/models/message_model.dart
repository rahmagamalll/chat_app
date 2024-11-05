class MessageModel {
  String message;
  DateTime date;
  String id; //email
  MessageModel(this.message, this.id, this.date);

  factory MessageModel.fromJson(dataJson) {
    return MessageModel(dataJson['message'].toString(), dataJson['id'], dataJson['Time'].toDate());
  }
}
