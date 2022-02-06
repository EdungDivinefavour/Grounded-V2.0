import 'package:url_launcher/url_launcher.dart';

void launchUri({bool isPhoneNumber = false, required String url}) async {
  final launchUrl = isPhoneNumber ? "tel:" + url : url;

  if (await canLaunch(launchUrl)) {
    await launch(launchUrl);
  } else {
    throw 'Could not launch $launchUrl';
  }
}
