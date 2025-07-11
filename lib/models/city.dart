class City {
  bool isSelected;
  final String name;
  final String country;
  final bool isDefault;

  City({
    required this.name,
    required this.country,
    required this.isDefault,
    this.isSelected = false,
  });

  get lat => null;

  static List<City> getCities() {
    return [
      City(isSelected: false, name: 'Jakarta', country: 'ID', isDefault: true),
      City(isSelected: false, name: 'Bandung', country: 'ID', isDefault: false),
      City(
        isSelected: false,
        name: 'Surabaya',
        country: 'ID',
        isDefault: false,
      ),
      City(isSelected: false, name: 'Medan', country: 'ID', isDefault: false),
      City(isSelected: false, name: 'Bali', country: 'ID', isDefault: false),
      City(
        isSelected: false,
        name: 'Yogyakarta',
        country: 'ID',
        isDefault: false,
      ),
      City(
        isSelected: false,
        name: 'Makassar',
        country: 'ID',
        isDefault: false,
      ),
      City(
        isSelected: false,
        name: 'Palembang',
        country: 'ID',
        isDefault: false,
      ),
    ];
  }

  static List<City> getSelectedCities() {
    List<City> selectedCities = City.getCities();
    return selectedCities.where((city) => city.isSelected == true).toList();
  }
}
