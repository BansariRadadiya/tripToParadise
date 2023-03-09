class StateServices {
  static final List<String> places = ['Candolim Beach', 'Chandipur Beach','Nainital'];

  static List<String> getSuggestions(String query) {
    List<String> matches = [];
    matches.addAll(places);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
