/// A library that provides a list of countries from a point on the map
library geo_countries;

import 'dart:math';

import 'package:flutter/services.dart';
import 'package:geo/geo.dart';
import 'dart:convert';
import 'dart:io';

/// This is a list of countries with their bounding box.
/// The bounding box is an array of 4 numbers: [minLat, minLng, maxLat, maxLng]
const Map<String, List<double>> _corners = {
  'AW': [12.4124, -70.0635, 12.624, -69.8654],
  'AF': [29.3619, 60.5049, 38.4904, 74.8941],
  'AO': [-18.0421, 11.6687, -4.3726, 24.0801],
  'AI': [18.1609, -63.4278, 18.5918, -62.9267],
  'AL': [39.6507, 19.2642, 42.6604, 21.0491],
  'AE': [22.6316, 51.498, 26.0693, 56.3812],
  'AR': [-55.0615, -73.5606, -21.7814, -53.5918],
  'AM': [38.8305, 43.4498, 41.3018, 46.63],
  'AG': [16.9318, -62.349, 17.729, -61.6565],
  'AU': [-55.1169, 112.9211, -9.1422, 159.1092],
  'AT': [46.3728, 9.531, 49.0212, 17.1621],
  'AZ': [38.3972, 44.7726, 41.9075, 50.6078],
  'BE': [49.4972, 2.5554, 51.5038, 6.4079],
  'BJ': [6.2349, 0.7743, 12.4184, 3.8517],
  'BF': [9.4011, -5.5189, 15.0826, 2.4054],
  'BD': [20.7411, 88.0106, 26.6341, 92.6737],
  'BG': [41.2348, 22.3438, 44.2127, 28.609],
  'BH': [25.5571, 50.2747, 26.2888, 50.8246],
  'BS': [20.9121, -80.476, 27.2711, -72.7121],
  'BA': [42.5653, 15.7274, 45.2747, 19.6147],
  'BY': [51.2696, 23.1783, 56.1684, 32.7946],
  'BZ': [15.8927, -89.2242, 18.4967, -87.4865],
  'BM': [32.2467, -64.8878, 32.4772, -64.6465],
  'BO': [-22.9066, -69.6452, -9.6709, -57.4544],
  'BR': [-33.7463, -73.9897, 5.2649, -28.8479],
  'BB': [13.0446, -59.6507, 13.3351, -59.4193],
  'BN': [4.0222, 114.1281, 5.046, 115.3759],
  'BT': [26.7007, 88.746, 28.2477, 92.1248],
  'BW': [-26.9073, 20, -17.7808, 29.3683],
  'CF': [2.2205, 14.4177, 11.0076, 27.4634],
  'CA': [41.6769, -141.0069, 83.1104, -52.6189],
  'CH': [45.8173, 5.9561, 47.8085, 10.4948],
  'CL': [-55.9797, -109.4549, -17.4986, -66.4182],
  'CN': [18.1593, 73.5577, 53.56, 134.7739],
  'CI': [4.3618, -8.5993, 10.7366, -2.4949],
  'CM': [1.6523, 8.4995, 13.0774, 16.191],
  'CD': [-13.4525, 12.2015, 5.3861, 31.3057],
  'CG': [-5.0307, 11.2009, 3.7031, 18.65],
  'CO': [-4.2284, -81.8412, 15.9125, -66.8377],
  'KM': [-12.4226, 43.2287, -11.3649, 44.541],
  'CV': [14.8018, -25.3618, 17.2054, -22.6571],
  'CR': [5.4986, -87.1018, 11.2198, -82.5525],
  'KY': [19.2626, -81.4199, 19.7568, -79.7232],
  'CY': [34.625, 32.2693, 35.1994, 34.0882],
  'CZ': [48.5524, 12.0908, 51.0554, 18.8593],
  'DE': [47.2708, 5.8663, 55.0565, 15.0418],
  'DJ': [10.9087, 41.7482, 12.7068, 43.4176],
  'DM': [15.2063, -61.4801, 15.6401, -61.2401],
  'DK': [54.559, 8.0764, 57.7515, 15.1925],
  'DO': [17.4704, -72.0039, 19.9318, -68.3226],
  'DZ': [18.9602, -8.6739, 37.0887, 11.9874],
  'EC': [-5.0158, -92.0085, 1.6811, -75.1871],
  'EG': [21.7254, 24.6981, 31.6674, 36.2485],
  'ER': [12.357, 36.4388, 18.0067, 43.1376],
  'ES': [27.6374, -18.1615, 43.7915, 4.3282],
  'EE': [57.5139, 21.7643, 59.822, 28.209],
  'FI': [59.721, 20.5512, 70.0915, 31.5828],
  'FJ': [-21.0425, -180, -12.4619, 180],
  'FR': [41.3338, -5.1438, 51.0894, 9.5604],
  'FM': [1.0253, 137.4256, 10.0906, 163.0356],
  'GA': [-3.9907, 8.6996, 2.3156, 14.5023],
  'GB': [49.8653, -8.65, 60.8454, 1.7644],
  'GE': [41.0385, 40.0111, 43.5845, 46.7214],
  'GH': [4.7388, -3.2621, 11.1748, 1.2002],
  'GI': [36.1085, -5.3676, 36.1572, -5.3385],
  'GN': [7.1936, -15.0762, 12.6915, -7.6411],
  'GM': [13.0647, -16.8174, 13.8269, -13.7916],
  'GW': [10.8643, -16.7149, 12.6854, -13.6365],
  'GR': [34.8007, 19.3724, 41.748, 29.6457],
  'GD': [11.9843, -61.8021, 12.5396, -61.3782],
  'GT': [13.7383, -92.2224, 17.8165, -88.2257],
  'GY': [1.1768, -61.3869, 8.5308, -56.4803],
  'HN': [12.9845, -89.3508, 17.4185, -82.4057],
  'HR': [42.3854, 13.4904, 46.5505, 19.4352],
  'HT': [18.0218, -74.4812, 20.0904, -71.6181],
  'HU': [45.7478, 16.1138, 48.5864, 22.9056],
  'ID': [-11.0075, 95.0097, 6.0767, 141.0194],
  'IN': [6.7543, 68.1862, 33.2557, 97.1722],
  'IE': [51.4199, -10.6628, 55.4351, -5.9945],
  'IQ': [29.0586, 38.7968, 37.378, 48.5686],
  'IS': [63.0958, -24.5328, 66.5646, -12.0505],
  'IL': [29.4971, 34.268, 33.364, 35.9009],
  'IT': [35.4929, 6.6309, 47.0927, 18.5207],
  'JM': [17.0204, -78.369, 18.5251, -75.9701],
  'JO': [29.1834, 34.9576, 33.3682, 39.3021],
  'JP': [24.0454, 122.9332, 45.5227, 153.9869],
  'KZ': [40.5517, 46.4919, 55.4318, 87.3127],
  'KE': [-4.7204, 33.9096, 5.0612, 41.9262],
  'KG': [39.1728, 69.2797, 43.2382, 80.2284],
  'KH': [9.9136, 102.3338, 14.6903, 107.6277],
  'KN': [17.0935, -62.864, 17.4179, -62.5393],
  'KR': [33.1126, 124.6097, 38.6118, 131.871],
  'KW': [28.5244, 46.5426, 30.0839, 48.654],
  'LA': [13.9097, 100.0868, 22.5004, 107.635],
  'LB': [33.055, 35.1026, 34.6914, 36.6218],
  'LR': [4.3529, -11.4857, 8.5518, -7.3651],
  'LY': [19.5082, 9.3917, 33.1654, 25.1482],
  'LC': [13.7071, -61.0801, 14.1104, -60.8699],
  'LI': [47.0474, 9.4725, 47.2703, 9.6359],
  'LK': [5.9185, 79.5218, 9.8357, 81.8788],
  'LT': [53.8901, 20.9506, 56.447, 26.8472],
  'LU': [49.4478, 5.7441, 50.1816, 6.5305],
  'LV': [55.6637, 20.9719, 58.0856, 28.2405],
  'MA': [27.6701, -13.1679, 35.9226, -0.9963],
  'MC': [43.7226, 7.4095, 43.7509, 7.4401],
  'MD': [45.4668, 26.6213, 48.4902, 30.1637],
  'MG': [-25.606, 43.1885, -11.9487, 50.4865],
  'MV': [-0.7032, 72.6382, 7.1065, 73.7604],
  'MX': [14.5351, -118.3665, 32.7186, -86.7107],
  'MK': [40.8553, 20.4558, 42.3386, 23.0061],
  'ML': [10.1595, -12.2389, 25, 4.245],
  'MT': [35.786, 14.1843, 36.0824, 14.5765],
  'MM': [8.8244, 92.1725, 28.5433, 101.1768],
  'ME': [41.8479, 18.4589, 43.5626, 20.3176],
  'MN': [41.5677, 87.7497, 52.1543, 119.9243],
  'MZ': [-26.8687, 30.2194, -10.4712, 40.8393],
  'MR': [14.7156, -17.0665, 27.2981, -4.83],
  'MS': [16.6749, -62.2418, 16.8243, -62.1446],
  'MU': [-20.5257, 56.5857, -10.3371, 63.5032],
  'MW': [-17.1272, 32.6898, -9.3638, 35.915],
  'MY': [0.8537, 99.6408, 7.3806, 119.2694],
  'NA': [-28.9694, 11.7349, -16.9599, 25.2677],
  'NE': [11.697, 0.1663, 23.525, 15.9956],
  'NG': [4.2707, 2.6684, 13.892, 14.6762],
  'NI': [10.7074, -87.691, 15.0259, -81.9999],
  'NL': [50.7235, 3.3608, 53.5546, 7.227],
  'NO': [57.959, 3.9047, 71.1813, 31.162],
  'NP': [26.3475, 80.0601, 30.447, 88.204],
  'NR': [-0.5536, 166.9097, -0.5021, 166.9593],
  'NZ': [-52.6208, -178.827, -29.2318, 179.0658],
  'OM': [16.6424, 52, 26.5068, 59.8393],
  'PK': [23.7029, 60.8994, 36.8898, 75.367],
  'PA': [7.2024, -83.0519, 9.6474, -77.1293],
  'PE': [-18.3518, -81.3307, -0.039, -68.6522],
  'PH': [4.5878, 116.9283, 21.0699, 126.6053],
  'PW': [2.9714, 131.1199, 8.0942, 134.7214],
  'PG': [-11.6554, 140.8405, -0.7564, 157.0377],
  'PL': [49.0024, 14.1229, 54.8364, 24.1455],
  'PT': [30.0302, -31.2682, 42.1543, -6.1891],
  'PY': [-27.6057, -62.6424, -19.2952, -54.2586],
  'QA': [24.4708, 50.7365, 26.1835, 51.6474],
  'RO': [43.6193, 20.2638, 48.2656, 29.7199],
  'RU': [41.1889, -180, 81.8562, 180],
  'RW': [-2.84, 28.8617, -1.0476, 30.8991],
  'SA': [16.3795, 34.4944, 32.1543, 55.6667],
  'SN': [12.3079, -17.5429, 16.6921, -11.3426],
  'SG': [1.1664, 103.6091, 1.4714, 104.0858],
  'SB': [-12.3083, 155.3931, -4.4452, 170.1923],
  'SL': [6.9176, -13.3035, 10.0004, -10.2658],
  'SV': [13.1526, -90.1249, 14.4506, -87.684],
  'SM': [43.8949, 12.4012, 43.9955, 12.5141],
  'SO': [-1.6471, 40.9785, 11.9885, 51.4157],
  'RS': [42.2276, 18.8087, 46.1894, 22.9789],
  'ST': [-0.0135, 6.4599, 1.7015, 7.4626],
  'SR': [1.8311, -58.0866, 6.0151, -53.9775],
  'SK': [47.7327, 16.8345, 49.6138, 22.5678],
  'SI': [45.4283, 13.3821, 46.8782, 16.5843],
  'SE': [55.3363, 10.9614, 69.059, 24.1724],
  'SZ': [-27.3175, 30.7914, -25.7188, 32.1367],
  'SC': [-10.2274, 46.2037, -3.7126, 56.2957],
  'TC': [21.1774, -72.4829, 21.9626, -71.0821],
  'TD': [7.4411, 13.4735, 23.4504, 24.0025],
  'TG': [6.1115, -0.144, 11.138, 1.8075],
  'TH': [5.616, 97.3455, 20.4631, 105.6391],
  'TJ': [36.6721, 67.3871, 41.0422, 75.1372],
  'TM': [35.1298, 52.4414, 42.7956, 66.6843],
  'TO': [-22.3494, -176.2138, -15.5658, -173.735],
  'TT': [10.0429, -61.9301, 11.3596, -60.4921],
  'TN': [30.2368, 7.5301, 37.5599, 11.5983],
  'TR': [35.8154, 25.6651, 42.1067, 44.835],
  'TW': [20.6975, 116.71, 26.3854, 122.1085],
  'TZ': [-11.7457, 29.3272, -0.9858, 40.4451],
  'UG': [-1.4821, 29.5715, 4.2345, 35.0003],
  'UA': [44.386, 22.1404, 52.375, 40.2181],
  'UY': [-34.974, -58.4406, -30.0855, -53.0942],
  'US': [18.9099, -179.1506, 72.6875, 179.7734],
  'UZ': [37.1772, 55.9981, 45.5711, 73.1346],
  'VA': [41.9001, 12.4456, 41.9076, 12.4579],
  'VC': [12.5787, -61.461, 13.3835, -61.114],
  'VE': [0.6488, -73.3521, 15.6729, -59.8072],
  'VG': [18.306, -64.8501, 18.7488, -64.2704],
  'VN': [8.3814, 102.1446, 23.3927, 109.469],
  'VU': [-20.2532, 166.5414, -13.0731, 170.24],
  'WS': [-14.0772, -172.804, -13.4398, -171.398],
  'XK': [41.8483, 19.9794, 43.2461, 21.793],
  'YE': [12.1082, 41.8146, 19, 54.5354],
  'ZA': [-34.8351, 16.4519, -22.1251, 32.8913],
  'ZM': [-18.0792, 21.98, -8.272, 33.7124],
  'ZW': [-22.4196, 25.238, -15.6073, 33.055],
};
const _verifyCountriesCount = 10;

/// A class that represents the relation between a point and a boundary
class GeoRelation {
  /// The nearest distance from the point to one of the poiunt on the boundary
  double distance;

  /// Whether the point is inside the boundary
  bool inside;
  GeoRelation(this.distance, this.inside);
}

/// Check if a point is inside a polygon
/// @param {LatLng} point
/// @param {LatLng[]} polygon
/// @returns {GeoRelation}
/// @private
GeoRelation _isPointInPolygon(LatLng point, List<LatLng> polygon) {
  bool inside = false;
  double dist = double.infinity;
  for (int i = 0, j = polygon.length - 1; i < polygon.length; j = i++) {
    if ((polygon[i].lat > point.lat != polygon[j].lat > point.lat)) {
      var lng = (polygon[j].lng - polygon[i].lng) * (point.lat - polygon[i].lat) / (polygon[j].lat - polygon[i].lat) +
          polygon[i].lng;
      if (point.lng < lng) {
        inside = !inside;
      }
      dist = min(dist, (point.lng - lng).abs());
    } else {
      dist = min(dist, sqrt(pow(point.lat - polygon[i].lat, 2) + pow(point.lng - polygon[i].lng, 2)));
    }
  }
  return GeoRelation(dist, inside);
}

/// Check if a point is inside a boundary
/// @param {LatLng} point
/// @param {LatLng[][][]} boundary
/// @returns {GeoRelation}
/// @private
GeoRelation _isPointInBoundary(LatLng point, List<List<List<LatLng>>> boundary) {
  GeoRelation rs = GeoRelation(double.infinity, false);
  for (var part in boundary) {
    GeoRelation isInOuterPolygon = _isPointInPolygon(point, part.first);
    rs.distance = min(rs.distance, isInOuterPolygon.distance);

    // If the point is not in the outer polygon, continue to the next part
    if (!isInOuterPolygon.inside) continue;

    bool isInHole = part.skip(1).any((hole) => _isPointInPolygon(point, hole).inside);

    // If the point is in the outer polygon and not in any holes, it's inside the boundary
    if (!isInHole) {
      rs.inside = true;
    }
  }
  return rs;
}

final Map<String, List<List<List<LatLng>>>> _boundaries = {};

/// Load boundary from assets
/// @param {String} countryCode
/// @returns {Future<LatLng[][][]>}
/// @private
Future<List<List<List<LatLng>>>?> _loadBoundary(String countryCode) async {
  try {
    var gzip = await rootBundle.load('assets/countries/$countryCode.json.gz');
    var raw = GZipCodec().decode(gzip.buffer.asUint8List());
    var json = utf8.decode(raw);
    Map<String, dynamic> data = jsonDecode(json);
    List<dynamic> features = data['features'] as List<dynamic>;
    List<dynamic> coordinates = features[0]['geometry']['coordinates'] as List<dynamic>;
    return List<List<List<LatLng>>>.from(coordinates
        .map((c) => List<List<LatLng>>.from(c.map((p) => List<LatLng>.from(p.map((l) => LatLng(l[1], l[0])))))));
  } catch (_) {
    return null;
  }
}

/// Check if a point is inside a country
/// @param {LatLng} point
/// @param {String} countryCode
/// @returns {Future<GeoRelation>}
Future<GeoRelation> isInsideCountry(LatLng point, String countryCode) async {
  List<List<List<LatLng>>>? boundaries = _boundaries[countryCode];
  if (boundaries == null) {
    boundaries = await _loadBoundary(countryCode);
    if (boundaries != null) {
      _boundaries[countryCode] = boundaries;
    }
  }
  if (boundaries == null) {
    return GeoRelation(double.infinity, false);
  }
  return _isPointInBoundary(point, boundaries);
}

/// Get a list of countries that ordered by the distance from the point
/// @param {LatLng} point
/// @returns {Future<String[]>}
Future<List<String>> getCountriesFromLatLng(LatLng point) async {
  var countries = _corners.keys.toList();
  Map<String, double> dist0 = {};
  for (var country in countries) {
    var c = _corners[country]!;
    if (point.lat > c[0] != point.lat > c[2] && point.lng > c[1] != point.lng > c[3]) {
      dist0[country] = 0;
    } else {
      var dx = min((point.lat - c[0]).abs(), (point.lat - c[2]).abs());
      var dy = min((point.lng - c[1]).abs(), (point.lng - c[3]).abs());
      dist0[country] = sqrt(dx * dx + dy * dy);
    }
  }
  countries.sort((a, b) => dist0[a]!.compareTo(dist0[b]!));
  int topCount = 0;
  while (topCount < countries.length && dist0[countries[topCount]]! == 0) {
    topCount++;
  }
  if (topCount < _verifyCountriesCount) {
    topCount = _verifyCountriesCount;
  }
  var top = countries.sublist(0, topCount);
  Map<String, GeoRelation> dist = {};
  for (var country in top) {
    dist[country] = await isInsideCountry(point, country);
  }
  top.sort((a, b) =>
      dist[a]!.inside != dist[b]!.inside ? (dist[a]!.inside ? -1 : 1) : dist[a]!.distance.compareTo(dist[b]!.distance));
  top.addAll(countries.sublist(topCount));
  return top;
}
