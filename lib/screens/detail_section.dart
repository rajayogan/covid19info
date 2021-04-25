import 'package:covid19tracker/models/country.dart';
import 'package:covid19tracker/screens/countrypiechart.dart';
import 'package:covid19tracker/services/apicalls.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailScreen extends StatefulWidget {
  final continentName, continent;

  DetailScreen({this.continentName, this.continent});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<DropdownMenuItem<Country>> countryChoices = [];
  List<Country> allCountries = [];

  Country selectedCountry;
  bool countriesLoaded = false;
  bool countriesDataLoaded = false;

  var countryData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCountryData();
  }

  loadCountryData() {
    widget.continent['countries'].forEach((e) {
      allCountries.add(Country(name: e));
    });
    _buildDropDownMenu(allCountries);
  }

  _buildDropDownMenu(List<Country> allCountries) {
    for (Country country in allCountries) {
      countryChoices.add(DropdownMenuItem(
        child: Text(
          country.name,
          style:
              GoogleFonts.mPlusRounded1c(fontSize: 12.0, color: Colors.black),
        ),
        value: country,
      ));
    }
    setState(() {
      selectedCountry = countryChoices[0].value;
      fetchCountryData();
      countriesLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final phoneSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(children: [
        Container(
          height: phoneSize.height,
          width: phoneSize.width,
          color: Colors.teal,
          child: Column(
            children: [
              SizedBox(height: 45.0),
              Hero(
                tag: widget.continentName,
                child: Text(
                  widget.continentName,
                  style: GoogleFonts.mPlusRounded1c(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
            top: 100.0,
            child: Container(
              height: phoneSize.height - 100.0,
              width: phoneSize.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0)),
              ),
              child: Column(
                children: [
                  SizedBox(height: 10.0),
                  Text(
                    'Choose a country',
                    style: GoogleFonts.mPlusRounded1c(
                        fontSize: 12.0, color: Colors.black),
                  ),
                  SizedBox(height: 10.0),
                  countriesLoaded
                      ? DropdownButtonHideUnderline(
                          child: DropdownButton(
                              onChanged: (val) {
                                setState(() {
                                  selectedCountry = val;
                                  countriesDataLoaded = false;
                                  fetchCountryData();
                                });
                              },
                              items: countryChoices,
                              value: selectedCountry))
                      : Container(),
                  countriesDataLoaded
                      ? CountryPieChart(
                          active: countryData['active'],
                          recovered: countryData['recovered'],
                          totalCases: countryData['cases'])
                      : Container(),
                  countriesDataLoaded
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.0),
                            Text(
                              'Deaths :' + countryData['deaths'].toString(),
                              style: GoogleFonts.mPlusRounded1c(
                                  fontSize: 14.0, color: Colors.red),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Tests :' + countryData['tests'].toString(),
                              style: GoogleFonts.mPlusRounded1c(
                                  fontSize: 14.0, color: Colors.blue),
                            )
                          ],
                        )
                      : CircularProgressIndicator(),
                  SizedBox(height: 15.0),
                  SizedBox(
                    width: 150.0,
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Center(
                          child: Text(
                            'View more details',
                            style: GoogleFonts.mPlusRounded1c(
                                textStyle: GoogleFonts.mPlusRounded1c(
                                    color: Colors.white, fontSize: 11.0)),
                          ),
                        )),
                  )
                ],
              ),
            ))
      ]),
    );
  }

  fetchCountryData() async {
    countryData = await DataService().getSelectedCountry(selectedCountry.name);
    setState(() {
      print(countryData);
      countriesDataLoaded = true;
    });
  }
}
