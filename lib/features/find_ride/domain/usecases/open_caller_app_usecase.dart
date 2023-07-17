import 'package:url_launcher/url_launcher.dart';

class OpenCallerAppUsecase {
  /// Opens the caller app with the given phone number 
  /// and waits for the user's response
  Future<bool> call(String phoneNumber) async {
    final Uri uri = Uri.parse('tel:$phoneNumber');

    return await launchUrl(uri);
  }
}
