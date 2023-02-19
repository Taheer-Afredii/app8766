import 'package:url_launcher/url_launcher.dart';

class MapLauncher {
  mapLaunch(String lat, String long) async {
    String url = "https://www.google.com/maps/search/?api=1&query=$lat,$long";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}

mapLaunch(String lat, String long) async {
  String url = "https://www.google.com/maps/search/?api=1&query=$lat,$long";
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}
