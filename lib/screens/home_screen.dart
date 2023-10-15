import 'package:flutter/material.dart';
import 'package:flutter_radio/screens/player_screen.dart';
import 'package:flutter_radio/utils/const.dart';
import 'package:flutter_radio/utils/radio_station_list.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          "Carvaan Radio",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(10),
        itemCount: radioStations.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: primaryColor, width: 1),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: radioStations[index]["imageUrl"] != ""
                  ? Image.network(radioStations[index]["imageUrl"])
                  : Image.asset(APPLOGO),
              title: Text(radioStations[index]["title"]),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayerScreen(
                        radioStation: radioStations[index],
                      ),
                    ));
              },
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 20);
        },
      ),
    );
  }
}
