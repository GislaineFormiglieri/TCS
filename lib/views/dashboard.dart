import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard de Finanças'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(child: FinanceBox(title: 'Alimentação', amount: 250.0)),
                  Expanded(child: FinanceBox(title: 'Saúde', amount: 100.0)),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(child: FinanceBox(title: 'Entradas', amount: 5000.0)),
                  Expanded(child: FinanceBox(title: 'Saídas', amount: 3000.0)),
                ],
              ),
            ),
            Expanded(
              child: MyChart(), // Gráfico mostrando controle de entrada e saída
            ),
          ],
        ),
      ),
    );
  }
}

class FinanceBox extends StatelessWidget {
  final String title;
  final double amount;

  FinanceBox({required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade100,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'R\$ $amount',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}

class MyChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(text: 'Controle Financeiro'),
      legend: Legend(isVisible: true),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <ChartSeries>[
        ColumnSeries<SalesData, String>(
          dataSource: getChartData(),
          xValueMapper: (SalesData sales, _) => sales.year,
          yValueMapper: (SalesData sales, _) => sales.sales,
          name: 'Saídas',
          color: Colors.red,
        ),
        ColumnSeries<SalesData, String>(
          dataSource: getChartData(),
          xValueMapper: (SalesData sales, _) => sales.year,
          yValueMapper: (SalesData sales, _) => sales.sales + 1000, // Exemplo para entradas
          name: 'Entradas',
          color: Colors.green,
        )
      ],
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(),
    );
  }

  List<SalesData> getChartData() {
    final List<SalesData> chartData = [
      SalesData('Jan', 1000),
      SalesData('Feb', 1500),
      SalesData('Mar', 1200),
      SalesData('Apr', 1700),
      SalesData('May', 1400),
    ];
    return chartData;
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
