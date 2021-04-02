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

import 'model/products_repository.dart';
import 'model/product.dart';

const _url = 'https://www.handong.edu/';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final isSelected = <bool>[true, false];

  List<Card> _buildGridCards(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);

    if (products == null || products.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());

    return products.map((product) {
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18 / 11,
              child: Image.asset(
                product.assetName,
                package: product.assetPackage,
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
                      product.name,
                      style: theme.textTheme.headline6,
                      maxLines: 1,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      formatter.format(product.price),
                      style: theme.textTheme.subtitle2,
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
      body: OrientationBuilder(builder: (context, orientation) {
        return Column(
          children: <Widget>[
            ToggleButtons(
              color: Colors.black.withOpacity(0.60),
              selectedColor: Colors.blue,
              selectedBorderColor: Colors.blue,
              isSelected: isSelected,
              borderRadius: BorderRadius.circular(4.0),
              onPressed: (index) {
                setState(() {
                  isSelected[index] = !isSelected[index];
                });
              },
              children: [
                Icon(Icons.list),
                Icon(Icons.grid_view),
              ],
            ),
            GridView.count(
              crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
              padding: EdgeInsets.all(16.0),
              childAspectRatio: 8.0 / 9.0,
              children: _buildGridCards(context),
            ),
          ],
        );
      }),
      resizeToAvoidBottomInset: false,
    );
  }
}

void _launchURL() async =>
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
