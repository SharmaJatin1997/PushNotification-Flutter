class UserModel {
  num? id;
  num? userid;
  num? user2Id;
  String? name;
  String? group_name;
  String? email;
  String? password;
  String? phone;
  num? otp;
  num? isVerify;
  var role;
  num? supervisorId;
  String? deviceToken;
  String? deviceType;
  String? updatedAt;
  String? createdAt;
  String? token;
  String? old_password;
  String? new_password;
  UserModel({
      this.id, 
      this.userid,
      this.user2Id,
      this.name,
      this.group_name,
      this.email,
      this.password, 
      this.phone, 
      this.otp, 
      this.isVerify, 
      this.role, 
      this.supervisorId, 
      this.deviceToken, 
      this.deviceType, 
      this.updatedAt,
      this.token,
      this.createdAt,
      this.old_password,
      this.new_password,
  });

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    userid = json['userid'];
    user2Id = json['user2Id'];
    name = json['name'];
    group_name = json['group_name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    otp = json['otp'];
    isVerify = json['is_verify'];
    role = json['role'];
    supervisorId = json['supervisor_id'];
    deviceToken = json['device_token'];
    deviceType = json['device_type'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    token = json['token'];
    old_password = json['old_password'];
    new_password = json['new_password'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    void writeNotNull(String key, dynamic value) {
      if (value != null && value.toString().isNotEmpty) {
        data[key] = value;
      }
    }
    writeNotNull('id' , id);
    writeNotNull('userid' , userid);
    writeNotNull('user2Id' , user2Id);
    writeNotNull('name' , name);
    writeNotNull('group_name' , group_name);
    writeNotNull('email' , email);
    writeNotNull('password' , password);
    writeNotNull('phone' , phone);
    writeNotNull('otp' , otp);
    writeNotNull('is_verify',isVerify);
    writeNotNull('role' , role);
    writeNotNull('supervisor_id',  supervisorId);
    writeNotNull('device_token' , deviceToken);
    writeNotNull('device_type' , deviceType);
    writeNotNull('updatedAt' , updatedAt);
    writeNotNull('createdAt' , createdAt);
    writeNotNull('token' , token);
    writeNotNull('old_password' , old_password);
    writeNotNull('new_password' , new_password);
    return data;
  }

}