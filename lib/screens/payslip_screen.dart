import 'package:academate_faculty/widgets/custom_appBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SalarySlipScreen extends StatefulWidget {
  const SalarySlipScreen({Key? key}) : super(key: key);

  @override
  State<SalarySlipScreen> createState() => _SalarySlipScreenState();
}

class _SalarySlipScreenState extends State<SalarySlipScreen> {
  String? selectedMonth;
  bool isLoading = false;

  final List<Map<String, String>> months = [
    {'value': '2025-06', 'display': 'June 2025'},
    {'value': '2025-05', 'display': 'May 2025'},
    {'value': '2025-04', 'display': 'April 2025'},
    {'value': '2025-03', 'display': 'March 2025'},
    {'value': '2025-02', 'display': 'February 2025'},
    {'value': '2025-01', 'display': 'January 2025'},
    {'value': '2024-12', 'display': 'December 2024'},
    {'value': '2024-11', 'display': 'November 2024'},
    {'value': '2024-10', 'display': 'October 2024'},
    {'value': '2024-09', 'display': 'September 2024'},
    {'value': '2024-08', 'display': 'August 2024'},
    {'value': '2024-07', 'display': 'July 2024'},
  ];

  void _downloadSalarySlip() async {
    if (selectedMonth == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select a month first'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Salary slip for ${_getSelectedMonthDisplay()} downloaded successfully!'),
        backgroundColor: const Color(0xFF2E7D32), // AppColors.success
        duration: const Duration(seconds: 3),
      ),
    );
  }

  String _getSelectedMonthDisplay() {
    if (selectedMonth == null) return '';
    return months.firstWhere((month) => month['value'] == selectedMonth)['display'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8), // AppColors.background
      appBar: CustomAppBar(
        title: "View Salary Slip", 
        subtitle: "Select a month to download your salary slip"
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            
            // Main Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF), // AppColors.surface
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Month Dropdown
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF5A4FCF)), // AppColors.accent
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedMonth,
                        hint: Text(
                          'Select Month',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: const Color(0xFF5C5C5C), // AppColors.textSecondary
                          ),
                        ),
                        isExpanded: true,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: const Color(0xFF2A1070), // AppColors.primary
                        ),
                        items: months.map((month) {
                          return DropdownMenuItem<String>(
                            value: month['value'],
                            child: Text(
                              month['display']!,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                color: const Color(0xFF1C1C1E), // AppColors.textPrimary
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedMonth = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Download Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _downloadSalarySlip,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2A1070), // AppColors.primary
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        disabledBackgroundColor: const Color(0xFF5C5C5C).withOpacity(0.3),
                      ),
                      child: isLoading
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Downloading...',
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.download_outlined,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'View my Salary Slip',
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ),
            
            const Spacer(),
          ],
        ),
      ),
    );
  }
}