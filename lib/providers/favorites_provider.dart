import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/event.dart';

class FavoritesProvider with ChangeNotifier {
List<Event> _favoriteEvents = [];
static const String _favoritesKey = 'favoriteEvents';

List<Event> get favoriteEvents => _favoriteEvents;

FavoritesProvider() {
_loadFavorites();
}

Future<void> _loadFavorites() async {
final prefs = await SharedPreferences.getInstance();
final String? favoritesString = prefs.getString(_favoritesKey);
if (favoritesString != null) {
final List<dynamic> decodedData = json.decode(favoritesString);
_favoriteEvents = decodedData
.map((item) => Event.fromJson(item))
.toList();
notifyListeners();
}
}

Future<void> _saveFavorites() async {
final prefs = await SharedPreferences.getInstance();
final String encodedData = json.encode(
_favoriteEvents.map((event) => event.toJson()).toList(),
);
await prefs.setString(_favoritesKey, encodedData);
}

void toggleFavorite(Event event) {
if (_favoriteEvents.contains(event)) {
_favoriteEvents.remove(event);
} else {
_favoriteEvents.add(event);
}
_saveFavorites(); 
notifyListeners(); 
}

bool isFavorite(Event event) {
return _favoriteEvents.contains(event);
}
}
