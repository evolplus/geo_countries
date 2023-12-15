```dart
var countries = await getCountriesFromLatLng(const LatLng(40.6884277, -74.0482555));
// Get the list of countries, ordered by the distance from the given point.
// In above example, the given point is the Statue Of Liberty. "US" will be the first item in the returned list.
```