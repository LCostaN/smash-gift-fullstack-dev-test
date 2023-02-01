import 'package:flutter/material.dart';
import 'package:smash_gift_app/model/country.dart';

class CityList extends StatelessWidget {
  const CityList({super.key, required this.country});

  final Country country;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(country.name)),
      body: ListView.builder(
        itemCount: country.cities.length,
        itemBuilder: (context, i) => Card(
          child: ListTile(
            title: Text(country.cities[i].name),
            subtitle: Text(country.cities[i].state),
          ),
        ),
      ),
    );
  }
}
