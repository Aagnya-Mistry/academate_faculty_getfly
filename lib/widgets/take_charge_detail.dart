import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TakeChargeDetail extends StatelessWidget {
  const TakeChargeDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final String facultyName =
        ModalRoute.of(context)?.settings.arguments as String? ??
            "Faculty Name Not Found";

    final leaveDetails = {
      "Number of Days": "0.50",
      "Leave Type": "Compensation Leave",
      "Leave Reason": "Personal reason",
      "From": "09/01/2025",
      "To": "09/01/2025",
      "Applied Date": "01/01/1970",
    };

    return Scaffold(
      appBar: AppBar(
        title: Text("Leave Details", style: theme.appBarTheme.titleTextStyle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF6A5AE0), Color(0xFF8E79F5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [BoxShadow(blurRadius: 8, color: Colors.black26)],
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow("Faculty Name", facultyName),
              const SizedBox(height: 8),
              for (var entry in leaveDetails.entries)
                _buildDetailRow(entry.key, entry.value),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Approved Successfully')),
                      );
                    },
                    child: const Text("Approve"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Charge Denied')),
                      );
                    },
                    child: const Text("Deny"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              "$title:",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
