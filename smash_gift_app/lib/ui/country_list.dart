
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smash_gift_app/model/country.dart';
import 'package:smash_gift_app/service/service.dart';
import 'package:smash_gift_app/ui/city_list.dart';

class CountryList extends StatefulWidget {
  const CountryList({super.key});

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  Service service = Service();
  List<DocumentSnapshot> docs = [];

  ScrollController controller = ScrollController();

  bool loading = false;

  @override
  void initState() {
    super.initState();

    loadCountries();
    controller.addListener(() {
      if (controller.position.extentAfter < 300 && !loading) loadCountries();
    });
  }

  Future<void> loadCountries() async {
    setState(() => loading = true);

    if (docs.isEmpty) {
      docs.addAll(await service.getData(null));
    } else {
      docs.addAll(await service.getData(docs.last));
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Países")),
      body: ListView.builder(
        controller: controller,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: docs.length,
        itemBuilder: (context, i) {
          Country country = Country.fromDoc(docs[i]);
          return Card(
            child: ListTile(
              title: Text(country.name),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CityList(country: country),
              )),
            ),
          );
        },
      ),
    );
  }
}
