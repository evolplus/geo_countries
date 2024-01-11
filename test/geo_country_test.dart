import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geo/geo.dart';

import 'package:geo_countries/geo_countries.dart';

int comparator(String a, String b) {
  return a.compareTo(b);
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test('Test with predefined locations', () async {
    expect((await getCountriesFromLatLng(const LatLng(10.778625, 106.695756), comparator))[0], "VN");
    expect((await getCountriesFromLatLng(const LatLng(13.4124693, 103.8669857), comparator))[0], "KH");
    expect((await getCountriesFromLatLng(const LatLng(11.9268226, 105.0422785), comparator))[0], "KH");
    expect((await getCountriesFromLatLng(const LatLng(17.9485403, 102.6302347), comparator))[0], "LA");
    expect((await getCountriesFromLatLng(const LatLng(16.5463602, 103.8648768), comparator))[0], "TH");
    expect((await getCountriesFromLatLng(const LatLng(40.6884277, -74.0482555), comparator))[0], "US");
    expect((await getCountriesFromLatLng(const LatLng(-22.9459168, -43.2151878), comparator))[0], "BR");
  });
}
