class City {
  final String geonameid;
  final String name;
  final String state;

  City(this.geonameid, this.name, this.state);

  factory City.fromDoc(doc) {
    String name = doc['name'];
    String state = doc['province'];
    String geonameid = doc['geonameid'];

    return City(geonameid, name, state);
  }
}
