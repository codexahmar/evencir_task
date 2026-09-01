import 'package:evencir_task/constants/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HydrationCardWidget extends StatefulWidget {
  final double? height;

  const HydrationCardWidget({super.key, this.height});

  @override
  State<HydrationCardWidget> createState() => _HydrationCardWidgetState();
}

class _HydrationCardWidgetState extends State<HydrationCardWidget> {
  int currentMl = 1250;
  final int targetMl = 2500;

  void _addWater(int amount) {
    setState(() {
      currentMl = (currentMl + amount).clamp(0, 4000);
    });

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF16323B),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 1500),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Color(0xFF48A4E5), width: 1),
        ),
        content: Row(
          children: [
            const Icon(
              Icons.water_drop_rounded,
              color: Color(0xFF48A4E5),
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              "+$amount ml added to water log ($currentMl / $targetMl ml)",
              style: GoogleFonts.mulish(color: Colors.white, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double percentage = (currentMl / targetMl).clamp(0.0, 1.0);
    final int percentInt = (percentage * 100).toInt();

    // Dynamic wave spots based on intake
    final double p1 = (currentMl * 0.25).clamp(0, 700).toDouble();
    final double p2 = (currentMl * 0.60).clamp(0, 1500).toDouble();
    final double p3 = currentMl.toDouble();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.07),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left Column: Hydration Numbers & Quick Actions
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            "$percentInt%",
                            style: GoogleFonts.manrope(
                              color: const Color(0xFF48A4E5),
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -1,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              "($currentMl/$targetMl ml)",
                              style: GoogleFonts.mulish(
                                color: Colors.white.withValues(alpha: 0.5),
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Daily Hydration",
                        style: GoogleFonts.mulish(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Quick Add Buttons
                      Row(
                        children: [
                          _QuickAddButton(
                            label: "+250ml",
                            onTap: () => _addWater(250),
                          ),
                          const SizedBox(width: 8),
                          _QuickAddButton(
                            label: "+500ml",
                            onTap: () => _addWater(500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // Right Column: Smooth Fluid Wave Chart (FL Chart)
                Container(
                  width: 116,
                  height: 104,
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF101C24),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF48A4E5).withValues(alpha: 0.2),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "TIMELINE",
                              style: GoogleFonts.mulish(
                                color: Colors.white.withValues(alpha: 0.45),
                                fontSize: 8,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Icon(
                            Icons.water_drop_rounded,
                            size: 12,
                            color: Color(0xFF48A4E5),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      // FL Chart Smooth Curve
                      Expanded(
                        child: LineChart(
                          LineChartData(
                            minX: 0,
                            maxX: 3,
                            minY: 0,
                            maxY: targetMl.toDouble() * 1.1,
                            lineTouchData: LineTouchData(
                              enabled: true,
                              touchTooltipData: LineTouchTooltipData(
                                getTooltipColor: (touchedSpot) =>
                                    const Color(0xFF16323B),
                                tooltipPadding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 4,
                                ),
                                getTooltipItems: (touchedSpots) {
                                  return touchedSpots.map((spot) {
                                    return LineTooltipItem(
                                      "${spot.y.toInt()} ml",
                                      GoogleFonts.mulish(
                                        color: const Color(0xFF7DD3FC),
                                        fontSize: 9.5,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    );
                                  }).toList();
                                },
                              ),
                            ),
                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: false,
                              horizontalInterval: 1000,
                              getDrawingHorizontalLine: (value) => FlLine(
                                color: Colors.white.withValues(alpha: 0.04),
                                strokeWidth: 1,
                              ),
                            ),
                            titlesData: FlTitlesData(
                              topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              leftTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 1,
                                  getTitlesWidget: (value, meta) {
                                    const titles = ["8A", "12P", "4P", "8P"];
                                    final index = value.toInt();
                                    if (index < 0 || index >= titles.length) {
                                      return const SizedBox.shrink();
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 2.0),
                                      child: Text(
                                        titles[index],
                                        style: GoogleFonts.mulish(
                                          color: Colors.white.withValues(
                                            alpha: 0.4,
                                          ),
                                          fontSize: 7.5,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            borderData: FlBorderData(show: false),
                            lineBarsData: [
                              LineChartBarData(
                                spots: [
                                  FlSpot(0, p1),
                                  FlSpot(1, p2),
                                  FlSpot(2, p3),
                                  FlSpot(3, p3),
                                ],
                                isCurved: true,
                                curveSmoothness: 0.35,
                                preventCurveOverShooting: true,
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF2196F3),
                                    Color(0xFF00E5FF),
                                  ],
                                ),
                                barWidth: 2.2,
                                isStrokeCapRound: true,
                                dotData: FlDotData(
                                  show: true,
                                  checkToShowDot: (spot, barData) =>
                                      spot.x == 2, // Highlight current spot
                                  getDotPainter:
                                      (spot, percent, barData, index) =>
                                          FlDotCirclePainter(
                                            radius: 3.5,
                                            color: const Color(0xFF00E5FF),
                                            strokeWidth: 1.5,
                                            strokeColor: Colors.white,
                                          ),
                                ),
                                belowBarData: BarAreaData(
                                  show: true,
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      const Color(
                                        0xFF00E5FF,
                                      ).withValues(alpha: 0.32),
                                      const Color(
                                        0xFF2196F3,
                                      ).withValues(alpha: 0.02),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeInOut,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Quick Log Bar
          InkWell(
            onTap: () => _addWater(250),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 9),
              decoration: const BoxDecoration(
                color: Color(0xFF16323B),
                border: Border(
                  top: BorderSide(color: Color(0x3348A4E5), width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.add_circle_outline_rounded,
                    size: 14,
                    color: Color(0xFF7DD3FC),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "Tap to quick log +250 ml",
                    style: GoogleFonts.mulish(
                      color: const Color(0xFFBAE6FD),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
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

class _QuickAddButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _QuickAddButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4.5),
        decoration: BoxDecoration(
          color: const Color(0xFF48A4E5).withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: const Color(0xFF48A4E5).withValues(alpha: 0.35),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.mulish(
            color: const Color(0xFF7DD3FC),
            fontSize: 10.5,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
