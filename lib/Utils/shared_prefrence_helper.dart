import 'dart:convert';
import 'dart:ffi';

import 'package:push_notification/NotificationEntity.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferenceHelper {
  static late SharedPreferences _prefsInstance;
  var _prefs;

  static const String _fcmToken = "fcmToken";
  static const String _userId = "userId";
  static const String _userToken = "userToken";
  static const String _userType = "userType";
  static const String _cardId = "cardId";
  static const String _countryCode = "countryCode";
  static const String _notificationStatus = "notificationStatus";
  static const String _isLoggedIn = "isLoggedIn";
  static const String _startedModel = "startedModel";
  static const String _activeChatId = "activeChatId";
  static const String _location = "location";
  static const String _latitude = "latitude";
  static const String _longitude = "longitude";
  static const String _address = "address";
  static const String _image = "image";
  static const String _section = "section";

  static final JsonDecoder _decoder = JsonDecoder();
  static final JsonEncoder _encoder = JsonEncoder.withIndent('  ');

  static final SharedPreferenceHelper _singleton =
  SharedPreferenceHelper._internal();

  SharedPreferenceHelper._internal() {
    _prefs ??= SharedPreferences.getInstance();
  }

  static Future<SharedPreferences> init() async {
    _prefsInstance = await SharedPreferences.getInstance();
    return _prefsInstance;
  }

  factory SharedPreferenceHelper() {
    return _singleton;
  }

  _savePref(String key, Object? value) async {
    var prefs = _prefsInstance;
    if (prefs.containsKey(key)) {
      prefs.remove(key);
    }
    if (value is bool) {
      return prefs.setBool(key, value);
    } else if (value is int) {
      return prefs.setInt(key, value);
    } else if (value is String) {
      return prefs.setString(key, value);
    } else if (value is Double || value is Float) {
      return prefs.setDouble(key, value as double);
    }
  }

  T _getPref<T>(String key) {
    return _prefsInstance.get(key)as T;
  }

  void clearAll() {
    var token = getFcmToken();
    _prefsInstance.clear();
    saveFcmToken(token);
  }

  String? getCountryCode() {
    return _getPref(_countryCode);
  }


  void saveActiveChatId(num? userId) {
    _savePref(_activeChatId, userId);
  }


  int? getActiveChatId() {
    return _getPref(_activeChatId);
  }
  void saveCountryCode(String? countryCode) {
    _savePref(_countryCode, countryCode);
  }

  bool? getSectionDone() {
    return _getPref(_section);
  }
  void saveSection(value) {
    _savePref(_section, value);
  }



  String? getFcmToken() {
    return _getPref(_fcmToken);
  }

  void saveFcmToken(String? token) {
    _savePref(_fcmToken, token);
  }


  int? getUserId() {
    return _getPref(_userId);
  }

  void saveUserId(int? userId) {
    _savePref(_userId, userId);
  }

  String? getUserToken() {
    return _getPref(_userToken);
  }

  void saveUserToken(String? token) {
    _savePref(_userToken, token);
  }

  String? getUserType() {
    return _getPref(_userType);
  }

  void saveUserType(String? token) {
    _savePref(_userType, token);
  }

  int? getLocationType() {
    return _getPref(_location);
  }

  void saveLocation(int? type) {
    _savePref(_location, type);

  }

  String? getLatitude() {
    return _getPref(_latitude);
  }

  void saveLatitude(lat) {
    _savePref(_latitude, lat);

  }
  String? getLongitude() {
    return _getPref(_longitude);
  }

  void saveLongitude(long) {
    _savePref(_longitude, long);

  }
  String? getAddress() {
    return _getPref(_address);
  }

  void saveAddress(String? type) {
    _savePref(_address, type);

  }
  String? getDjImage() {
    return _getPref(_image);
  }

  void saveDjImage(String? type) {
    _savePref(_image, type);

  }
  bool getIsLoggedIn(){
    return _getPref(_isLoggedIn)??false;
  }

  void saveIsLoggedIn(bool value){
    _savePref(_isLoggedIn, value);
  }


/*
  UserModel? getUserModel() {
    String? user = _getPref(_userModel);
    if (user != null) {
      Map<String, dynamic>  userMap = _decoder.convert(user);
      return UserModel.fromJson(userMap);
    } else {
      return null;
    }
  }




  void saveUserModel(UserModel? userModel) {
    if (userModel != null) {
      String value = _encoder.convert(userModel);
      _savePref(_userModel, value);
    } else {
      _savePref(_userModel, null);
    }
  }

*/



  String? getCardId() {
    return _getPref(_cardId) ?? "";
  }

  void saveCardId(String? cardId) {
    _savePref(_cardId, cardId);
  }

  String getNotificationStatus() {
    return _getPref(_notificationStatus) ?? "1";
  }

  void saveNotificationStatus(String? notificationStatus) {
    _savePref(_notificationStatus, notificationStatus);
  }

  String convertNotificationEntityToString(NotificationEntity? notificationEntity){
    String value = _encoder.convert(notificationEntity);
    return value;
  }

  NotificationEntity? convertStringToNotificationEntity(String? value){
    if(value==null){
      return null;
    }
    Map<String, dynamic> map = _decoder.convert(value);
    return NotificationEntity.fromJson(map);
  }


}
