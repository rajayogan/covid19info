import 'package:covid19tracker/models/all_continents.dart';
import 'package:covid19tracker/screens/detail_section.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContinentSection extends StatelessWidget {
  final List continentSectionData;

  ContinentSection({this.continentSectionData});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      width: MediaQuery.of(context).size.width - 20.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ...continentSectionData
              .map((continent) => _buildCountryTile(continent, context))
              .toList()
        ],
      ),
    );
  }

  _buildCountryTile(continent, context) {
    String imageUrl;
    if (continent['continent'] != 'Australia/Oceania')
      imageUrl = 'assets/continents/' + continent['continent'] + '.png';
    else
      imageUrl = 'assets/continents/' + 'Australia.png';
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailScreen(
                  continent: continent,
                  continentName: continent['continent'],
                )));
      },
      child: Padding(
        padding: EdgeInsets.only(left: 5.0, right: 5.0),
        child: Container(
          height: 125.0,
          width: 150.0,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4), offset: Offset(0, 6)),
              ]),
          child: Column(children: [
            SizedBox(height: 10.0),
            Hero(
              tag: continent['continent'],
              child: Text(
                continent['continent'],
                style: GoogleFonts.raleway(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 15.0),
            Image.asset(imageUrl, height: 125.0, width: 150.0)
          ]),
        ),
      ),
    );
  }
}
