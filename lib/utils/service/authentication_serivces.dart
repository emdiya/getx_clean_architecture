import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testproject/utils/service/local_storage_services.dart';

class AuthenticationService extends GetxService {
  Future<String?> getDeivcesToken() async {
    try {
      return await LocalStorageService.getStringValue('device-token');
    } catch (e) {
      debugPrint("AuthenticationService getDeivcesToken: $e");
    }
    return null;
  }

  Future<String?> getUserToken() async {
    try {
      return await LocalStorageService.getStringValue('token');
    } catch (e) {
      debugPrint("AuthenticationService getUserToken: $e");
    }
    return null;
  }

  Future<void> storeDeivcesToken(String token) async {
    try {
      await LocalStorageService.storeData(key: 'device-token', value: token);
    } catch (e) {
      debugPrint("AuthenticationService storeDeivcesToken: $e");
    }
  }

  Future<void> storeUserToken(String token) async {
    try {
      await LocalStorageService.storeData(key: 'token', value: token);
    } catch (e) {
      debugPrint("AuthenticationService storeUserToken: $e");
    }
  }
}
