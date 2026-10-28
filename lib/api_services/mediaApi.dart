// ----------------------------------------------------------------------
// Photo / document upload
//
// Sends one picture (selfie, car photo, licence...) to the Rubia server and
// gets back the web address where it is stored on the Rubia server.
//
// Developer note: POST media/upload with the auth_code header; the returned
// URL goes in the existing form field.
// ----------------------------------------------------------------------
import 'dart:convert';
import 'dart:io';

import 'package:base_project_flutter/api_services/ApiHelper.dart';
import 'package:base_project_flutter/constants/apiConstants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// >>> START  class MediaApi
/// Uploads images/PDFs to the backend's own storage (`POST media/upload`),
/// on the Rubia server itself. The returned `url` is posted in the same
/// form fields that carry image addresses (profile_image, documents ...).
///
/// Server accepts JPEG/PNG/WebP/GIF/PDF, max ~4 MB by default.
class MediaApi {
  // >>> START  MediaApi.upload()
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
  // <<< END    MediaApi.upload()
}
// <<< END    class MediaApi
