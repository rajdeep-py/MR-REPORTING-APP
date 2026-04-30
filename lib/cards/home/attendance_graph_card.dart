import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../theme/app_theme.dart';

class AttendanceGraphCard extends StatelessWidget {
  const AttendanceGraphCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.coolGrey.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ATTENDANCE TREND',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
            ),
          ),
          AppGaps.largeV,
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 22,
                      getTitlesWidget: (value, meta) {
                        const months = ['J', 'F', 'M', 'A', 'M', 'J', 'J', 'A', 'S', 'O', 'N', 'D'];
                        if (value.toInt() >= 0 && value.toInt() < 12) {
                          return Text(months[value.toInt()], style: const TextStyle(fontSize: 10, color: AppColors.coolGrey));
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 20),
                      FlSpot(1, 22),
                      FlSpot(2, 18),
                      FlSpot(3, 25),
                      FlSpot(4, 21),
                      FlSpot(5, 24),
                      FlSpot(6, 23),
                      FlSpot(7, 26),
                      FlSpot(8, 22),
                      FlSpot(9, 25),
                      FlSpot(10, 24),
                      FlSpot(11, 27),
                    ],
                    isCurved: true,
                    color: AppColors.black,
                    barWidth: 4,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppColors.black.withAlpha(20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AppGaps.mediumV,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegend('Present days', AppColors.black),
              AppGaps.mediumH,
              _buildLegend('Monthly Avg: 24.2', AppColors.coolGrey),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegend(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        AppGaps.smallH,
        Text(label, style: const TextStyle(fontSize: 10, color: AppColors.coolGrey)),
      ],
    );
  }
}
