import 'package:evencir_task/constants/app_colors.dart';
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
            const Icon(Icons.water_drop_rounded, color: Color(0xFF48A4E5), size: 18),
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

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14),
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left Column: Percentage & Title
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
                              fontSize: 30,
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
                      const SizedBox(height: 10),

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

                // Right Column: Stylized Hydration Level Gauge
                Container(
                  width: 90,
                  height: 78,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF101C24),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFF48A4E5).withValues(alpha: 0.2),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "2.5L",
                            style: GoogleFonts.mulish(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Icon(
                            Icons.water_drop_rounded,
                            size: 14,
                            color: const Color(0xFF48A4E5).withValues(
                              alpha: 0.8,
                            ),
                          ),
                        ],
                      ),
                      // Progress Bar Inside
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Stack(
                          children: [
                            Container(
                              height: 14,
                              width: double.infinity,
                              color: Colors.white.withValues(alpha: 0.08),
                            ),
                            FractionallySizedBox(
                              widthFactor: percentage,
                              child: Container(
                                height: 14,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF2196F3),
                                      Color(0xFF00E5FF),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "0L",
                            style: GoogleFonts.mulish(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 8.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              "$currentMl ml",
                              style: GoogleFonts.mulish(
                                color: const Color(0xFF48A4E5),
                                fontSize: 9.5,
                                fontWeight: FontWeight.w700,
                              ),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Bar
          InkWell(
            onTap: () => _addWater(250),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: const BoxDecoration(
                color: Color(0xFF16323B),
                border: Border(
                  top: BorderSide(color: Color(0x3348A4E5), width: 1),
                ),
              ),
              alignment: Alignment.center,
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}