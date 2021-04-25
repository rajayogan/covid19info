import 'package:covid19tracker/services/constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

main() {
  test('Find if api is available', () async {
    final url = AppConstants.allUrl;
    final res = await http.get(Uri.parse(url));
    if(res.statusCode == 200){
      expect(res.body, isNotNull);
    }
    else {
      expect(res.statusCode, 500);
    }
  });
}