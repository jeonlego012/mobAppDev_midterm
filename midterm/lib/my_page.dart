import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:rive/rive.dart' as rive;
import 'package:flutter/services.dart';

import 'model/hotel.dart';
import 'home_detail.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  rive.Artboard _artboard;
  rive.RiveAnimationController _nightController;
  bool _night = false;

  @override
  void initState() {
    _loadRiveFile();
    super.initState();
  }

  void _loadRiveFile() async {
    final bytes = await rootBundle.load('assets/knight063.riv');
    final file = rive.RiveFile();
    if (file.import(bytes)) {
      setState(() => _artboard = file.mainArtboard
        ..addController((rive.SimpleAnimation('idle'))));
    }
  }

  void _nightChange(bool nightOn) {
    _night = !_night;
    if (_night) {
      _artboard.addController(
        _nightController = rive.SimpleAnimation('day_night'),
      );
    } else {
      _artboard.addController(
        _nightController = rive.SimpleAnimation('night_day'),
      );
    }
    setState(() => _night = nightOn);
  }

  Widget build(BuildContext context) {
    final List<Hotel> hotels =
        ModalRoute.of(context).settings.arguments as List<Hotel>;
    List<Hotel> favoriteHotels = List<Hotel>();

    for (int i = 0; i < hotels.length; i++) {
      if (hotels[i].isFavorite) {
        favoriteHotels.add(hotels[i]);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('My Page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 30.0, left: 120.0),
            child: _artboard != null
                ? ClipOval(
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: rive.Rive(
                        artboard: _artboard,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : SizedBox(),
          ),
          Row(
            children: [
              SizedBox(width: 145.0),
              Icon(Icons.wb_sunny),
              Container(
                child: Switch(
                  value: _night,
                  onChanged: _nightChange,
                  inactiveThumbColor: Colors.yellow,
                  inactiveTrackColor: Colors.yellow[200],
                  activeColor: Colors.purple,
                ),
              ),
              Icon(Icons.nightlight_round),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 145.0, bottom: 30.0),
            child: Column(
              children: [
                Text(
                  'Youngone Jeon',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('21700643'),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 30.0),
            child: Text(
              'My Favorite Hotel List',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (final favoriteHotel in favoriteHotels)
                    FavoriteListItem(
                      hotel: favoriteHotel,
                      assetName: favoriteHotel.assetName,
                      name: favoriteHotel.name,
                      location: favoriteHotel.location,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FavoriteListItem extends StatefulWidget {
  FavoriteListItem({
    Key key,
    @required this.hotel,
    @required this.assetName,
    @required this.name,
    @required this.location,
  }) : super(key: key);

  final Hotel hotel;
  final String assetName;
  final String name;
  final String location;

  @override
  _FavoriteListItemState createState() => _FavoriteListItemState();
}

class _FavoriteListItemState extends State<FavoriteListItem> {
  final GlobalKey _backgroundImageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              _buildParallaxBackground(context),
              _buildGradient(),
              _buildTitleAndSubtitle(),
              _buildTap(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParallaxBackground(BuildContext context) {
    return Flow(
      delegate: ParallaxFlowDelegate(
        scrollable: Scrollable.of(context),
        listItemContext: context,
        backgroundImageKey: _backgroundImageKey,
      ),
      children: [
        Image.asset(
          widget.assetName,
          key: _backgroundImageKey,
          fit: BoxFit.cover,
        ),
      ],
    );
  }

  Widget _buildGradient() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.6, 0.95],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndSubtitle() {
    return Positioned(
      left: 20,
      bottom: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            widget.location,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTap(BuildContext context) {
    return InkWell(onTap: () {
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HotelDetailPage(hotel: widget.hotel)),
        );
      });
    });
  }
}

class ParallaxFlowDelegate extends FlowDelegate {
  ParallaxFlowDelegate({
    @required this.scrollable,
    @required this.listItemContext,
    @required this.backgroundImageKey,
  }) : super(repaint: scrollable.position);

  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
        listItemBox.size.centerLeft(Offset.zero),
        ancestor: scrollableBox);

    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction =
        (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);

    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    final backgroundSize =
        (backgroundImageKey.currentContext.findRenderObject() as RenderBox)
            .size;
    final listItemSize = context.size;
    final childRect =
        verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    context.paintChild(
      0,
      transform: Transform.translate(
        offset: Offset(0.0, childRect.top),
      ).transform,
    );
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}
