# Geo Countries
The geo_countries package is a Dart library designed for applications that require geographical data processing. It offers a convenient way to handle country boundaries and geographical coordinates.

## Features
- Provides geographical boundary data for various countries.
- Easy integration with Dart and Flutter projects.
- Utilizes efficient algorithms for geographical calculations.

## Getting Started
To use geo_country in your project, add it to your package's pubspec.yaml file:
```yaml
dependencies:
  geo_countries: ^1.0.0
```

## Usage
Import geo_countries in your Dart file:
```dart
import 'package:geo_countries/geo_countries.dart';
```

You can then access the functionality provided by geo_countries to work with geographical data related to countries.

## Example
Here's a simple example of how to use geo_countries:
```dart
var countries = await getCountriesFromLatLng(const LatLng(40.6884277, -74.0482555));
// Getting the list of countries, ordered by the distance from the given point to the countries
```

## Contributing
Contributions to geo_countries are welcome. 

## License
This project is licensed under the MIT License - see the LICENSE file for details.