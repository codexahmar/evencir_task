import 'package:evencir_task/constants/app_images.dart';
import 'package:evencir_task/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class WorkoutContainer extends StatelessWidget {
  final String type;
  final Color color;
  final String iconPath;
  final String title;
  final String duration;
  final VoidCallback? onTap;

  const WorkoutContainer({
    super.key,
    required this.type,
    required this.color,
    required this.iconPath,
    required this.title,
    required this.duration,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF19191E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.08),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Left Colored Accent Strip
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: 0.4),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 14, 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Dice / Drag Handle Icon
                    Opacity(
                      opacity: 0.6,
                      child: Image.asset(
                        AppImages.diceIcon,
                        width: 16,
                        height: 16,
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Workout Details
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Workout Type Tag
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 2.5,
                            ),
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: color.withValues(alpha: 0.3),
                                width: 0.8,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  iconPath,
                                  height: 13,
                                  width: 13,
                                  color: color,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  type,
                                  style: AppTextStyles.custom(
                                    context: context,
                                    color: color,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Title and Duration
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  title,
                                  style: AppTextStyles.custom(
                                    context: context,
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                duration,
                                style: AppTextStyles.custom(
                                  context: context,
                                  color: Colors.white.withValues(alpha: 0.65),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
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
            ],
          ),
        ),
      ),
    );
  }
}
