import 'package:covid19tracker/models/all_continents.dart';
import 'package:covid19tracker/models/global_statistics.dart';
import 'package:covid19tracker/screens/continentSection.dart';
import 'package:covid19tracker/screens/pie_chart.dart';
import 'package:covid19tracker/services/apicalls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardPage extends StatefulHookWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  GlobalStatistics allData;
  List allContinents;
  bool dataLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  //Fetch all initial Data
  loadData() async {
    allData = await DataService().getAll();
    allContinents = await DataService().getContinents();
    print(allContinents);
    setState(() {
      dataLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'COVID STATISTICS',
          style: GoogleFonts.mPlusRounded1c(
              fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(children: [
        Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              height: 150.0,
              decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(7.0)),
            )),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            dataLoaded
                ? PieChart(
                    active: allData.active,
                    recovered: allData.recovered,
                    totalCases: allData.cases,
                  )
                : Container()
          ],
        ),
        SizedBox(height: 15.0),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            'By Continents',
            style: GoogleFonts.mPlusRounded1c(
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: 15.0),
        dataLoaded
            ? ContinentSection(
                continentSectionData: allContinents,
              )
            : Container()
      ]),
    );
  }
}
