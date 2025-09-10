import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:habits_tracker_app/constraint/app_constraint.dart';
import 'package:habits_tracker_app/model/weekly_habit_data.dart';


class HabitChartWidget extends StatelessWidget {
  final List<WeeklyHabitData> weeklyData;
  final Animation<double> animation;
  final Function(int) onDayTapped;

  const HabitChartWidget({
    super.key,
    required this.weeklyData,
    required this.animation,
    required this.onDayTapped,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        _handleChartTap(details.localPosition);
      },
      child: LineChart(_buildLineChartData()),
    );
  }

  void _handleChartTap(Offset localPosition) {
    // Approximate calculation for chart tap detection
    final chartWidth = AppConstants.chartHeight - 40 - 50; // Container width - padding - left axis space
    final relativeX = (localPosition.dx - 50) / chartWidth; // Adjust for left axis space
    final dayIndex = (relativeX * 7).round().clamp(0, 6);
    
    if (dayIndex >= 0 && dayIndex < weeklyData.length) {
      onDayTapped(dayIndex);
    }
  }

/// fuction for bottom title //////
  Widget _bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: AppConstants.textSecondary,
      fontWeight: FontWeight.w600,
      fontSize: 13,
    );

    final int index = value.toInt();
    if (index < 0 || index >= AppConstants.weekdays.length) {
      return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8.0,
      child: Text(AppConstants.weekdays[index], style: style),
    );
  }

//// fucntion for left title widet //////
  Widget _leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: AppConstants.textSecondary,
      fontWeight: FontWeight.w600,
      fontSize: 12,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8.0,
      child: Text('${value.toInt()}%', style: style),
    );
  }

//// here is code for line chart //////
  LineChartData _buildLineChartData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: AppConstants.chartGridInterval,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xFF37434D),
            strokeWidth: 0.5,
          );
        },
      ),
      titlesData: FlTitlesData(
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 35,
            interval: 1,
            getTitlesWidget: _bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 50,
            interval: AppConstants.chartGridInterval,
            getTitlesWidget: _leftTitleWidgets,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Color(0xFF37434D), width: 1),
          left: BorderSide(color: Color(0xFF37434D), width: 1),
        ),
      ),
      minX: 0,
      maxX: 6, // 0 to 6 for 7 days
      minY: 0,
      maxY: 100, // 0 to 100%
      lineBarsData: [
        LineChartBarData(
          spots: weeklyData
              .map((data) => FlSpot(
                  data.dayIndex.toDouble(), 
                  data.completionPercentage * animation.value))
              .toList(),
          isCurved: true,
          gradient: const LinearGradient(
            colors: [AppConstants.primaryGradientEnd, AppConstants.primaryGradientStart],
          ),
          barWidth: AppConstants.chartBarWidth,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) =>
                FlDotCirclePainter(
              radius: AppConstants.chartDotRadius,
              color: Colors.white,
              strokeWidth: 3,
              strokeColor: AppConstants.primaryGradientStart,
            ),
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                // ignore: deprecated_member_use
                AppConstants.primaryGradientEnd.withOpacity(0.3),
                // ignore: deprecated_member_use
                AppConstants.primaryGradientStart.withOpacity(0.1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }

  
}