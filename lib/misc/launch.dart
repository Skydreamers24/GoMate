import 'package:url_launcher/url_launcher.dart';

void launch(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception("Could not launch URL");
  }
}
