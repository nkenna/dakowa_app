import 'package:linkify/linkify.dart';

class DataHolder {
  static String BASE_URL = "https://backend.dakowa.com/";
  static String TEST_BASE_URL = "https://localhost:8081/";
  static String PAYSTACK_PUBLIC_TEST_KEY = "";
  static String PAYSTACK_PUBLIC_LIVE_KEY = "pk_live_612c847b7e233477f5c420e8c4d26e47551c7162";


  static String extractLink(String input) {
    var elements = linkify(input,
        options: LinkifyOptions(
          humanize: false,
        ));
    for (var e in elements) {
      if (e is LinkableElement) {
        return e.url;
      }
    }
    return "";
  }
}