import 'package:evencir_task/constants/app_colors.dart';
import 'package:evencir_task/constants/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _healthSyncEnabled = true;
  bool _hapticsEnabled = true;
  bool _remindersEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        title: Text(
          AppTexts.profile,
          style: GoogleFonts.mulish(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: const Color(0xFF1E1E28),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  content: Text(
                    "Profile preferences saved.",
                    style: GoogleFonts.mulish(color: Colors.white, fontSize: 13),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Avatar Card with Pro Athlete Badge
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(16),
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
              child: Row(
                children: [
                  // Avatar with Gradient Ring
                  Container(
                    width: 64,
                    height: 64,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xFF4855DF), Color(0xFF00C896)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    padding: const EdgeInsets.all(2.5),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF18181C),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.person_rounded,
                          size: 34,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),

                  // Name & Level
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppTexts.userName,
                          style: GoogleFonts.manrope(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          AppTexts.userHandle,
                          style: GoogleFonts.mulish(
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00C896).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: const Color(0xFF00C896).withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            AppTexts.athleteLevel,
                            style: GoogleFonts.mulish(
                              color: const Color(0xFF00C896),
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 3-Stat Metric Bar
            Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
              child: Row(
                children: [
                  _buildStatItem("18", "Workouts", const Color(0xFF00C896)),
                  _buildStatDivider(),
                  _buildStatItem("3,420", "kcal Burned", const Color(0xFF48A4E5)),
                  _buildStatDivider(),
                  _buildStatItem("12 🔥", "Day Streak", const Color(0xFFF99955)),
                ],
              ),
            ),

            const SizedBox(height: 22),

            // Active Goals & Targets
            Text(
              "Active Targets",
              style: GoogleFonts.mulish(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),

            _buildGoalTile(
              icon: Icons.fitness_center_rounded,
              iconColor: const Color(0xFF4855DF),
              title: "Weekly Workouts",
              subtitle: "4 of 5 sessions completed",
              progress: 0.8,
            ),
            const SizedBox(height: 10),
            _buildGoalTile(
              icon: Icons.water_drop_rounded,
              iconColor: const Color(0xFF00D2FF),
              title: "Daily Hydration",
              subtitle: "1,250 ml of 2,500 ml target",
              progress: 0.5,
            ),
            const SizedBox(height: 10),
            _buildGoalTile(
              icon: Icons.monitor_weight_outlined,
              iconColor: const Color(0xFF20B76F),
              title: "Target Weight",
              subtitle: "75.0 kg -> Goal: 72.0 kg (-3.0 kg)",
              progress: 0.65,
            ),

            const SizedBox(height: 22),

            // Settings & Preferences
            Text(
              "Preferences & Sync",
              style: GoogleFonts.mulish(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),

            Container(
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
              child: Column(
                children: [
                  _buildSwitchTile(
                    icon: Icons.health_and_safety_outlined,
                    title: "Apple Health / Google Fit",
                    value: _healthSyncEnabled,
                    onChanged: (val) => setState(() => _healthSyncEnabled = val),
                  ),
                  Divider(
                    color: Colors.white.withValues(alpha: 0.06),
                    height: 1,
                    indent: 16,
                    endIndent: 16,
                  ),
                  _buildSwitchTile(
                    icon: Icons.vibration_rounded,
                    title: "Haptic Feedback & Sound",
                    value: _hapticsEnabled,
                    onChanged: (val) => setState(() => _hapticsEnabled = val),
                  ),
                  Divider(
                    color: Colors.white.withValues(alpha: 0.06),
                    height: 1,
                    indent: 16,
                    endIndent: 16,
                  ),
                  _buildSwitchTile(
                    icon: Icons.notifications_none_rounded,
                    title: "Workout Reminders",
                    value: _remindersEnabled,
                    onChanged: (val) => setState(() => _remindersEnabled = val),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Version info
            Center(
              child: Text(
                "EVENCIR Fitness v1.0.0 • Build 2026.09",
                style: GoogleFonts.mulish(
                  color: Colors.white.withValues(alpha: 0.3),
                  fontSize: 11,
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label, Color valueColor) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: GoogleFonts.manrope(
              color: valueColor,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.mulish(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatDivider() {
    return Container(
      width: 1,
      height: 28,
      color: Colors.white.withValues(alpha: 0.08),
    );
  }

  Widget _buildGoalTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required double progress,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.mulish(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.mulish(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "${(progress * 100).toInt()}%",
                style: GoogleFonts.manrope(
                  color: iconColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white.withValues(alpha: 0.08),
              valueColor: AlwaysStoppedAnimation<Color>(iconColor),
              minHeight: 5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(icon, color: Colors.white70, size: 18),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.mulish(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: const Color(0xFF00C896),
            activeTrackColor: const Color(0xFF00C896).withValues(alpha: 0.3),
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.white10,
          ),
        ],
      ),
    );
  }
}
