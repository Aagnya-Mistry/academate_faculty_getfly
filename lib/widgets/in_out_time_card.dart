import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class InOutTimeCard extends StatelessWidget {
  const InOutTimeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 6,
      shadowColor: theme.colorScheme.primary.withOpacity(0.3),
      color: theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            _InOutColumn(
              icon: FontAwesomeIcons.signInAlt,
              label: 'IN Time',
              time: '-----',
              gradientColors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
            ),
            _InOutColumn(
              icon: FontAwesomeIcons.signOutAlt,
              label: 'OUT Time',
              time: '-----',
              gradientColors: [Color(0xFF00C9FF), Color(0xFF92FE9D)],
            ),
          ],
        ),
      ),
    );
  }
}

class _InOutColumn extends StatelessWidget {
  final IconData icon;
  final String label;
  final String time;
  final List<Color> gradientColors;

  const _InOutColumn({
    required this.icon,
    required this.label,
    required this.time,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Icon(icon, color: Colors.white, size: 20),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          time,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
