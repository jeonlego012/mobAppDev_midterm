// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'model/hotels_repository.dart';
import 'model/hotel.dart';
import 'home_detail.dart';

const _url = 'https://www.handong.edu/';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final isSelected = <bool>[false, true];
  List<Hotel> hotels = HotelsRepository.loadHotels();

  List<Card> _buildGridCards() {
    if (hotels == null || hotels.isEmpty) {
      return const <Card>[];
    }

    return hotels.map((hotel) {
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18 / 9,
              child: Hero(
                tag: hotel.id,
                child: Image.asset(
                  hotel.assetName,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Expanded(
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 30.0, left: 5.0, right: 5.0),
                    child: Icon(
                      Icons.location_on,
                      color: Colors.blue,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            for (int i = 0; i < hotel.stars; i++)
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 12.0,
                              ),
                          ],
                        ),
                        Container(
                          child: Text(
                            hotel.name,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            hotel.location,
                            style: TextStyle(
                              fontSize: 8,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HotelDetailPage(hotel: hotel)),
                  );
                },
                child: Text('more'),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  textStyle: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  List<Card> _buildListCards() {
    if (hotels == null || hotels.isEmpty) {
      return const <Card>[];
    }

    return hotels.map((hotel) {
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: <Widget>[
            Hero(
              tag: hotel.id,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  child: Image.asset(
                    hotel.assetName,
                    fit: BoxFit.cover,
                    width: 90,
                    height: 90,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //SizedBox(height: 10.0),
                        Row(
                          children: [
                            for (int i = 0; i < hotel.stars; i++)
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 12.0,
                              ),
                          ],
                        ),
                        Container(
                          child: Text(
                            hotel.name,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            hotel.location,
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HotelDetailPage(hotel: hotel)),
                              );
                            },
                            child: Text('more'),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              textStyle: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              semanticLabel: 'search',
            ),
            onPressed: () {
              print('Search button');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.language,
              semanticLabel: 'language',
            ),
            onPressed: _launchURL,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Container(
                padding: EdgeInsets.only(top: 100),
                child: Text(
                  'Pages',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              leading: Icon(
                Icons.home,
                semanticLabel: 'home',
              ),
              onTap: () {
                print('Home button');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Search'),
              leading: Icon(
                Icons.search,
                semanticLabel: 'search',
              ),
              onTap: () {
                print('Search button');
              },
            ),
            ListTile(
              title: Text('Favorite Hotels'),
              leading: Icon(
                Icons.location_city,
                semanticLabel: 'favorite hotels',
              ),
              onTap: () {
                print('Favorite hotels button');
                Navigator.pushNamed(context, '/favorite', arguments: hotels);
              },
            ),
            ListTile(
              title: Text('My Page'),
              leading: Icon(
                Icons.person,
                semanticLabel: 'my page',
              ),
              onTap: () {
                print('My page button');
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10.0, right: 16.0),
            alignment: Alignment.centerRight,
            child: ToggleButtons(
              color: Colors.black.withOpacity(0.60),
              selectedColor: Colors.blue,
              selectedBorderColor: Colors.blue,
              isSelected: isSelected,
              borderRadius: BorderRadius.circular(4.0),
              onPressed: (index) {
                setState(() {
                  for (int buttonIndex = 0;
                      buttonIndex < isSelected.length;
                      buttonIndex++) {
                    if (buttonIndex == index) {
                      isSelected[buttonIndex] = true;
                    } else {
                      isSelected[buttonIndex] = false;
                    }
                  }
                });
              },
              children: [
                Icon(Icons.list),
                Icon(Icons.grid_view),
              ],
            ),
          ),
          Expanded(
            child: isSelected[0]
                ? GridView.count(
                    crossAxisCount: 1,
                    padding: EdgeInsets.all(16.0),
                    childAspectRatio: 8.0 / 2.5,
                    children: _buildListCards(),
                  )
                : OrientationBuilder(builder: (context, orientation) {
                    return GridView.count(
                      crossAxisCount:
                          orientation == Orientation.portrait ? 2 : 3,
                      padding: EdgeInsets.all(16.0),
                      childAspectRatio: 8.0 / 9.0,
                      children: _buildGridCards(),
                    );
                  }),
          ),
        ],
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}

void _launchURL() async =>
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
