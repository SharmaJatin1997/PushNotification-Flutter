class NotificationEntity {

  String? title;
  String? body;
  String? sender_id;
  String? notification_type;
  String? msgData;
  var user_id;
  var first_name;
  var last_name;
  var user_profile_img;
  var isGroup;
  String? msg;
  String? receiverId;
  String? senderId;
  String? senderName;

  NotificationEntity({
    this.title,
    this.body,
    this.sender_id,
    this.notification_type,
    this.msgData,
    this.user_id,
    this.first_name,
    this.senderName,
    this.last_name,
    this.user_profile_img,
    this.isGroup,
    this.msg,
    this.receiverId,
    this.senderId,
  });

  NotificationEntity.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body=json['body'];
    sender_id = json['sender_id'];
    senderName = json['senderName'];
    notification_type = json['notification_type'];
    msgData = json['msgData'];
    user_id = json['user_id'];
    first_name = json['first_name'];
    last_name = json['last_name'];
    user_profile_img = json['user_profile_img'];
    isGroup = json['isGroup'];
    msg = json['msg'];
    receiverId = json['receiverId'];
    senderId = json['senderId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    void writeNotNull(String key, dynamic value) {
      if (value != null && value
          .toString()
          .isNotEmpty) {
        data[key] = value;
      }
    }
    writeNotNull("title", title);
    writeNotNull("body", body);
    writeNotNull("sender_id", sender_id);
    writeNotNull("notification_type", notification_type);
    writeNotNull("msgData", msgData);
    writeNotNull("senderName", senderName);
    writeNotNull("user_id", user_id);
    writeNotNull("first_name", first_name);
    writeNotNull("last_name", last_name);
    writeNotNull("user_profile_img", user_profile_img);
    writeNotNull("isGroup", isGroup);
    writeNotNull("msg", msg);
    writeNotNull("receiverId", receiverId);
    writeNotNull("senderId", senderId);
    return data;
  }
}