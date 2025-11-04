import 'package:evencir_task/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class HydrationCardWidget extends StatelessWidget {
  final double height;

  const HydrationCardWidget({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF18181C),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: height * 0.05,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "0%",
                          style: AppTextStyles.custom(
                            context: context,
                            color: const Color(0xFF48A4E5),
                            fontSize: screenWidth * 0.1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hydration",
                              style: AppTextStyles.custom(
                                context: context,
                                color: Colors.white,
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: height * 0.01),
                            Text(
                              "Log Now",
                              style: AppTextStyles.custom(
                                context: context,
                                color: Colors.white.withOpacity(0.6),
                                fontSize: screenWidth * 0.03,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  buildHydrationGraph(context, screenWidth, height),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: height * 0.22,
            decoration: const BoxDecoration(
              color: Color(0xFF1B3D45),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
            ),
            alignment: Alignment.center,
            child: Text(
              "500 ml added to water log",
              style: AppTextStyles.custom(
                context: context,
                color: Colors.white,
                fontSize: screenWidth * 0.03,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHydrationGraph(BuildContext context, double screenWidth, double height) {
    final graphWidth = screenWidth * 0.38;
    final graphHeight = height * 0.6;

    return SizedBox(
      width: graphWidth,
      height: graphHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "2 L",
                    style: AppTextStyles.custom(
                      context: context,
                      color: Colors.white,
                      fontSize: screenWidth * 0.025,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.015),
                  Container(
                    width: 6,
                    height: 0,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF48A4E5),
                        width: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
              ...List.generate(
                4,
                (index) => Row(
                  children: [
                    SizedBox(width: screenWidth * 0.05),
                    Container(
                      width: 2,
                      height: 4,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 56, 110, 149),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    "0 L",
                    style: AppTextStyles.custom(
                      context: context,
                      color: Colors.white,
                      fontSize: screenWidth * 0.025,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.015),
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        width: graphWidth * 0.6,
                        height: 1,
                        color: Colors.white.withOpacity(0.4),
                      ),
                      Container(
                        width: 6,
                        height: 0,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF48A4E5),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Text(
              "0 ml",
              style: AppTextStyles.custom(
                context: context,
                color: Colors.white,
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}