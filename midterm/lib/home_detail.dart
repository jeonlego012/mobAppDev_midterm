import 'package:flutter/material.dart';
//import 'package:overlay/overlay.dart';

import 'model/hotel.dart';

class HotelDetailPage extends StatefulWidget {
  final Hotel hotel;

  HotelDetailPage({Key key, @required this.hotel}) : super(key: key);

  @override
  _HotelDetailPageState createState() => _HotelDetailPageState();
}

class _HotelDetailPageState extends State<HotelDetailPage> {
  @override
  Widget build(BuildContext context) {
    Widget imageSection = Stack(
      children: <Widget>[
        InkWell(
          onDoubleTap: () {
            setState(() {
              widget.hotel.isFavorite = !widget.hotel.isFavorite;
            });
          },
          child: Hero(
            tag: widget.hotel.id,
            child: Image.asset(
              widget.hotel.assetName,
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.topRight,
          child: Icon(
            widget.hotel.isFavorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
          ),
        ),
      ],
    );
    Widget starSection = Container(
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 10.0),
      child: Row(
        children: [
          for (int i = 0; i < widget.hotel.stars; i++)
            Icon(
              Icons.star,
              color: Colors.yellow,
              size: 25.0,
            ),
        ],
      ),
    );
    Widget nameSection = Container(
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 10.0),
      child: Text(
        widget.hotel.name,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    Widget iconSection = Container(
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildIconRow(Icons.location_on, widget.hotel.location),
          _buildIconRow(Icons.phone, widget.hotel.phoneNumber),
        ],
      ),
    );
    Widget textSection = Container(
      padding: EdgeInsets.all(20.0),
      child: Text(
        widget.hotel.description,
        style: TextStyle(
          height: 1.5,
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: ListView(
        children: [
          imageSection,
          starSection,
          nameSection,
          iconSection,
          _buildDivider(),
          textSection,
        ],
      ),
    );
  }

  Row _buildIconRow(IconData icon, String phoneNumber) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10.0),
          child: Icon(icon),
        ),
        Text(
          phoneNumber,
        ),
      ],
    );
  }

  Divider _buildDivider() {
    return const Divider(
      height: 10.0,
      indent: 20.0,
      endIndent: 20.0,
      color: Colors.black,
    );
  }
}
