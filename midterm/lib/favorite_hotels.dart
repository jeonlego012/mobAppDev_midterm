import 'package:flutter/material.dart';

import 'model/hotel.dart';

class FavoriteHotelsPage extends StatefulWidget {
  @override
  _FavoriteHotelsPageState createState() => _FavoriteHotelsPageState();
}

class _FavoriteHotelsPageState extends State<FavoriteHotelsPage> {
  @override
  Widget build(BuildContext context) {
    final List<Hotel> hotels =
        ModalRoute.of(context).settings.arguments as List<Hotel>;
    List<Hotel> favoriteHotels = List<Hotel>();

    for (int i = 0; i < hotels.length; i++) {
      if (hotels[i].isFavorite) {
        favoriteHotels.add(hotels[i]);
      }
    }

    final favoriteTiles = favoriteHotels.map(
      (favoriteHotel) {
        return Dismissible(
          background: Container(
            color: Colors.red,
          ),
          key: Key(favoriteHotel.name),
          onDismissed: (direction) {
            setState(() {
              favoriteHotels.remove(favoriteHotel);
              for (int i = 0; i < hotels.length; i++) {
                if (hotels[i].name == favoriteHotel.name) {
                  hotels[i].isFavorite = false;
                }
              }
            });
          },
          child: ListTile(
            title: Container(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                favoriteHotel.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );

    final dividedFavoriteTiles = ListTile.divideTiles(
      context: context,
      tiles: favoriteTiles,
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Hotels'),
      ),
      body: ListView(
        children: dividedFavoriteTiles,
      ),
    );
  }
}
