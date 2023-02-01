import 'package:smash_gift_app/model/city.dart';

class Country {
  final String id;
  final String name;
  final List<City> cities;

  Country(this.id, this.name, this.cities);

  factory Country.fromDoc(doc) {
    String id = doc.id;
    String name = doc.get('country');
    List<City> cities = (doc.get('cities') as List).map((e) => City.fromDoc(e)).toList();

    return Country(id, name, cities);
  }
}
