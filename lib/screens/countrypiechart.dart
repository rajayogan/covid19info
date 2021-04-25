import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class CountryPieChart extends StatelessWidget {
  final int totalCases, recovered, active;

  CountryPieChart({this.totalCases, this.recovered, this.active});

  @override
  Widget build(BuildContext context) {
    List chartData = [];
    chartData.add({'value': totalCases, 'name': 'Total'});
    chartData.add({'value': recovered, 'name': 'Recovered'});
    chartData.add({'value': active, 'name': 'Active'});

    return Container(
      height: 350.0,
      width: MediaQuery.of(context).size.width - 50.0,
      child: Center(
        child: Echarts(option: '''
            {
                  
                tooltip: {
                    trigger: 'item',
                    right: 'right',

                },
                legend: {
                    orient: 'vertical',
                    bottom: 'bottom'
                    
                },
                series: [
                    {
                        name: 'Cases',
                        type: 'pie',
                        roseType: 'area',
                        radius: '60%',
                        label: false,
                        data: [
                            {value: $totalCases, name: 'Total'},
                            {value: $recovered, name: 'Recovered'},
                            {value: $active, name: 'Active'}
                        ],
                        emphasis: {
                            itemStyle: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            }
          '''),
      ),
    );
  }
}
