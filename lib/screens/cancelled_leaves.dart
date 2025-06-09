import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CancelledLeave {
  final int id;
  final String type;
  final int days;
  final DateTime from;
  final DateTime to;
  final String userReason;
  final String hodRemark;

  CancelledLeave({
    required this.id,
    required this.type,
    required this.days,
    required this.from,
    required this.to,
    required this.userReason,
    required this.hodRemark,
  });
}

// Dummy data — replace with actual HOD-cancelled leaves
final cancelledByHodProvider = Provider<List<CancelledLeave>>((ref) {
  return [
    CancelledLeave(
      id: 1,
      type: 'Casual Leave',
      days: 2,
      from: DateTime(2024, 11, 20),
      to: DateTime(2024, 11, 22),
      userReason: 'Family function',
      hodRemark: 'Academic workload. Leave not approved.',
    ),
    CancelledLeave(
      id: 2,
      type: 'Medical Leave',
      days: 1,
      from: DateTime(2024, 12, 15),
      to: DateTime(2024, 12, 15),
      userReason: 'Mild fever',
      hodRemark: 'Medical certificate not sufficient.',
    ),
  ];
});

class CancelledLeaveScreen extends ConsumerWidget {
  const CancelledLeaveScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cancelledLeaves = ref.watch(cancelledByHodProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cancelled by HOD',
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        elevation: 0,
      ),
      body: cancelledLeaves.isEmpty
          ? Center(
              child: Text(
                'No cancelled leaves from HOD.',
                style: GoogleFonts.inter(fontSize: 16),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: cancelledLeaves.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final leave = cancelledLeaves[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.cancel, color: Colors.redAccent),
                            const SizedBox(width: 8),
                            Text(
                              leave.type,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.red.shade100,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                "CANCELLED",
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _dateColumn("From", leave.from),
                            _dateColumn("To", leave.to),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Days",
                                    style: GoogleFonts.inter(fontSize: 12)),
                                Text(
                                  "${leave.days} day(s)",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text("Your Reason",
                            style: GoogleFonts.inter(fontSize: 12)),
                        Text(
                          leave.userReason,
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        Text("HOD Remark",
                            style: GoogleFonts.inter(fontSize: 12)),
                        Text(
                          leave.hodRemark,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.red.shade400,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _dateColumn(String label, DateTime date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.inter(fontSize: 12)),
        Text(
          "${date.day}/${date.month}/${date.year}",
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
