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

const _url = 'https://www.handong.edu/';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final isSelected = <bool>[false, true];

  List<Card> _buildGridCards(BuildContext context) {
    List<Hotel> hotels = HotelsRepository.loadHotels();

    if (hotels == null || hotels.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);

    return hotels.map((hotel) {
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18 / 11,
              child: Image.asset(
                hotel.assetName,
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      hotel.name,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      hotel.location,
                      style: TextStyle(
                        fontSize: 8,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ],
                ),
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
            child: OrientationBuilder(builder: (context, orientation) {
              return GridView.count(
                crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
                padding: EdgeInsets.all(16.0),
                childAspectRatio: 8.0 / 9.0,
                children: _buildGridCards(context),
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
