import 'dart:convert';
import 'dart:io';

import 'package:base_project_flutter/api_services/ApiHelper.dart';
import 'package:base_project_flutter/constants/apiConstants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// Uploads images/PDFs to the backend's own storage (`POST media/upload`),
/// replacing Firebase Storage. The returned `url` is posted in the same
/// fields that used to receive the Firebase download URL.
///
/// Server accepts JPEG/PNG/WebP/GIF/PDF, max ~4 MB by default.
class MediaApi {
  /// Returns the stored file's URL, or null if the upload failed.
  static Future<String?> upload(File file) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final authCode = prefs.getString('authCode');
      if (authCode == null || authCode.isEmpty) return null;

      final request =
          http.MultipartRequest('POST', Uri.parse(apiBaseUrl + 'media/upload'))
            ..headers['auth_code'] = authCode
            ..files.add(await http.MultipartFile.fromPath('file', file.path));

      final response = await request.send();
      final body = await response.stream.bytesToString();
      if (response.statusCode != 200) {
        print('Media upload failed: HTTP ${response.statusCode}');
        return null;
      }

      final json = jsonDecode(body);
      if (ApiHelper.isSessionInvalid(json, uri: 'auth_code')) {
        await ApiHelper.handleSessionExpired();
        return null;
      }
      if (json is Map && json['status'] == 'OK' && json['url'] is String) {
        return json['url'] as String;
      }
      print('Media upload rejected: ${json is Map ? json['error'] : body}');
    } catch (e) {
      print('Media upload error: $e');
    }
    return null;
  }
}
