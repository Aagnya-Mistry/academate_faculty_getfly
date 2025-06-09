import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

// State Management Providers
final leaveTypeProvider = StateProvider<String?>((ref) => null);
final fromDateProvider = StateProvider<DateTime?>((ref) => null);
final toDateProvider = StateProvider<DateTime?>((ref) => null);
final alternateProvider = StateProvider<String?>((ref) => null);
final reasonProvider = StateProvider<String>((ref) => '');
final attachedFileProvider = StateProvider<File?>((ref) => null);
final isLoadingProvider = StateProvider<bool>((ref) => false);

class ApplyLeaveScreen extends ConsumerWidget {
  const ApplyLeaveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaveType = ref.watch(leaveTypeProvider);
    final fromDate = ref.watch(fromDateProvider);
    final toDate = ref.watch(toDateProvider);
    final alternate = ref.watch(alternateProvider);
    final reason = ref.watch(reasonProvider);
    final attachedFile = ref.watch(attachedFileProvider);
    final isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: CustomScrollView(
        slivers: [
          // Enhanced Header
          SliverAppBar(
            expandedHeight: 140,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF1E40AF),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF1E40AF),
                      Color(0xFF3B82F6),
                      Color(0xFF6366F1)
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: Colors.white.withOpacity(0.3)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Icon(Icons.assignment_outlined,
                                  color: Colors.white, size: 28),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Leave Request',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'Application Form',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                    color: Colors.white.withOpacity(0.3)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.today_outlined,
                                      color: Colors.white, size: 18),
                                  const SizedBox(width: 8),
                                  Text(
                                    '09 June 2025',
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            leading: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new,
                    color: Colors.white, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          // Form Content
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Main Form Card
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1E40AF).withOpacity(0.08),
                        blurRadius: 32,
                        offset: const Offset(0, 8),
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        // Header with status indicator
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Leave Application',
                                    style: GoogleFonts.poppins(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF1F2937),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Please fill in all required fields to submit your request',
                                    style: GoogleFonts.inter(
                                      fontSize: 15,
                                      color: const Color(0xFF6B7280),
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF3B82F6),
                                    Color(0xFF6366F1)
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF3B82F6)
                                        .withOpacity(0.3),
                                    blurRadius: 16,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: const Icon(Icons.description_outlined,
                                  color: Colors.white, size: 24),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),

                        // Form Fields
                        _buildFormField(
                          'Leave Type *',
                          _buildDropdown(
                            leaveType,
                            'Select Leave Type',
                            const [
                              DropdownMenuItem(
                                  value: 'sick', child: Text('Sick Leave')),
                              DropdownMenuItem(
                                  value: 'casual', child: Text('Casual Leave')),
                              DropdownMenuItem(
                                  value: 'annual', child: Text('Annual Leave')),
                              DropdownMenuItem(
                                  value: 'maternity',
                                  child: Text('Maternity Leave')),
                              DropdownMenuItem(
                                  value: 'emergency',
                                  child: Text('Emergency Leave')),
                              DropdownMenuItem(
                                  value: 'personal',
                                  child: Text('Personal Leave')),
                            ],
                            (value) => ref
                                .read(leaveTypeProvider.notifier)
                                .state = value,
                          ),
                          Icons.category_outlined,
                          isRequired: true,
                        ),

                        const SizedBox(height: 28),

                        // Date Row with improved layout
                        Row(
                          children: [
                            Expanded(
                              child: _buildFormField(
                                'From Date *',
                                _buildDateField(
                                  context,
                                  fromDate,
                                  'Select start date',
                                  (date) {
                                    ref.read(fromDateProvider.notifier).state =
                                        date;
                                    // Clear to date if it's before the new from date
                                    final currentToDate =
                                        ref.read(toDateProvider);
                                    if (currentToDate != null &&
                                        currentToDate.isBefore(date)) {
                                      ref.read(toDateProvider.notifier).state =
                                          null;
                                    }
                                  },
                                  firstDate: DateTime.now(),
                                ),
                                Icons.event_outlined,
                                isRequired: true,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 24),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFF3B82F6).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.arrow_forward,
                                  color: Color(0xFF3B82F6), size: 20),
                            ),
                            Expanded(
                              child: _buildFormField(
                                'To Date *',
                                _buildDateField(
                                  context,
                                  toDate,
                                  'Select end date',
                                  (date) => ref
                                      .read(toDateProvider.notifier)
                                      .state = date,
                                  firstDate: fromDate ?? DateTime.now(),
                                ),
                                Icons.event_outlined,
                                isRequired: true,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 28),

                        _buildFormField(
                          'Alternate Person',
                          _buildDropdown(
                            alternate,
                            'Select Alternate Person',
                            const [
                              DropdownMenuItem(
                                  value: 'john_doe', child: Text('John Doe')),
                              DropdownMenuItem(
                                  value: 'jane_smith',
                                  child: Text('Jane Smith')),
                              DropdownMenuItem(
                                  value: 'mike_johnson',
                                  child: Text('Mike Johnson')),
                              DropdownMenuItem(
                                  value: 'sarah_williams',
                                  child: Text('Sarah Williams')),
                              DropdownMenuItem(
                                  value: 'david_brown',
                                  child: Text('David Brown')),
                            ],
                            (value) => ref
                                .read(alternateProvider.notifier)
                                .state = value,
                          ),
                          Icons.person_outline,
                        ),

                        const SizedBox(height: 28),

                        _buildFormField(
                          'Reason for Leave *',
                          _buildTextArea(
                            'Please provide a detailed reason for your leave request...',
                            (value) =>
                                ref.read(reasonProvider.notifier).state = value,
                          ),
                          Icons.notes_outlined,
                          isRequired: true,
                        ),

                        const SizedBox(height: 28),

                        _buildFormField(
                          'Supporting Documents',
                          _buildFileUpload(attachedFile, () => _pickFile(ref)),
                          Icons.attach_file_outlined,
                        ),

                        const SizedBox(height: 40),

                        // Submit Button
                        _buildSubmitButton(
                          isLoading,
                          () => _submitLeave(context, ref),
                          _isFormValid(leaveType, fromDate, toDate, reason),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(String label, Widget child, IconData icon,
      {bool isRequired = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 12, left: 4),
          child: Row(
            children: [
              Icon(icon, size: 18, color: const Color(0xFF3B82F6)),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1F2937),
                ),
              ),
              if (isRequired)
                const Text(
                  ' *',
                  style: TextStyle(color: Color(0xFFDC2626), fontSize: 16),
                ),
            ],
          ),
        ),
        child,
      ],
    );
  }

  Widget _buildDropdown(
    String? value,
    String hint,
    List<DropdownMenuItem<String>> items,
    Function(String?) onChanged,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
              value != null ? const Color(0xFF3B82F6) : const Color(0xFFD1D5DB),
          width: value != null ? 2 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: (value != null
                    ? const Color(0xFF3B82F6)
                    : const Color(0xFF9CA3AF))
                .withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 16,
          ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        ),
        icon: Container(
          margin: const EdgeInsets.only(right: 16),
          child: const Icon(Icons.expand_more, color: Color(0xFF3B82F6)),
        ),
        items: items,
        onChanged: onChanged,
        dropdownColor: Colors.white,
        style: GoogleFonts.inter(
          color: const Color(0xFF1F2937),
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildDateField(
    BuildContext context,
    DateTime? selectedDate,
    String placeholder,
    Function(DateTime) onDateSelected, {
    required DateTime firstDate,
  }) {
    return GestureDetector(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? firstDate,
          firstDate: firstDate,
          lastDate: DateTime.now().add(const Duration(days: 365)),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color(0xFF3B82F6),
                  onPrimary: Colors.white,
                  surface: Colors.white,
                ),
              ),
              child: child!,
            );
          },
        );
        if (date != null) onDateSelected(date);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selectedDate != null
                ? const Color(0xFF3B82F6)
                : const Color(0xFFD1D5DB),
            width: selectedDate != null ? 2 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: (selectedDate != null
                      ? const Color(0xFF3B82F6)
                      : const Color(0xFF9CA3AF))
                  .withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              color: selectedDate != null
                  ? const Color(0xFF3B82F6)
                  : const Color(0xFF9CA3AF),
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                selectedDate != null
                    ? '${selectedDate.day.toString().padLeft(2, '0')}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.year}'
                    : placeholder,
                style: GoogleFonts.inter(
                  color: selectedDate != null
                      ? const Color(0xFF1F2937)
                      : const Color(0xFF9CA3AF),
                  fontSize: 16,
                  fontWeight:
                      selectedDate != null ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextArea(String hint, Function(String) onChanged) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD1D5DB), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF9CA3AF).withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        maxLines: 4,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 16,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(20),
        ),
        style: GoogleFonts.inter(
          fontSize: 16,
          color: const Color(0xFF1F2937),
        ),
      ),
    );
  }

  Widget _buildFileUpload(File? file, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: file != null
                ? const Color(0xFF10B981)
                : const Color(0xFFD1D5DB),
            width: file != null ? 2 : 1.5,
            style: file == null ? BorderStyle.solid : BorderStyle.solid,
          ),
          boxShadow: [
            BoxShadow(
              color: (file != null
                      ? const Color(0xFF10B981)
                      : const Color(0xFF9CA3AF))
                  .withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: (file != null
                        ? const Color(0xFF10B981)
                        : const Color(0xFF3B82F6))
                    .withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                file != null
                    ? Icons.check_circle_outline
                    : Icons.cloud_upload_outlined,
                color: file != null
                    ? const Color(0xFF10B981)
                    : const Color(0xFF3B82F6),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    file != null ? 'File Selected' : 'Choose File',
                    style: GoogleFonts.inter(
                      color: file != null
                          ? const Color(0xFF10B981)
                          : const Color(0xFF3B82F6),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    file != null
                        ? file.path.split('/').last
                        : 'PDF, DOC, DOCX, JPG, JPEG, PNG (Max 5MB)',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            if (file != null)
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Color(0xFF10B981),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 16),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton(
      bool isLoading, VoidCallback onPressed, bool isEnabled) {
    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        gradient: isEnabled
            ? const LinearGradient(
                colors: [Color(0xFF1E40AF), Color(0xFF3B82F6)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : null,
        color: isEnabled ? null : const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(18),
        boxShadow: isEnabled
            ? [
                BoxShadow(
                  color: const Color(0xFF1E40AF).withOpacity(0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: ElevatedButton(
        onPressed: (isLoading || !isEnabled) ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2.5),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.send_outlined,
                    color: isEnabled ? Colors.white : const Color(0xFF9CA3AF),
                    size: 22,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Submit Application',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: isEnabled ? Colors.white : const Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  bool _isFormValid(
      String? leaveType, DateTime? fromDate, DateTime? toDate, String reason) {
    return leaveType != null &&
        fromDate != null &&
        toDate != null &&
        reason.trim().isNotEmpty;
  }

  Future<void> _pickFile(WidgetRef ref) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
      );
      if (result != null) {
        ref.read(attachedFileProvider.notifier).state =
            File(result.files.single.path!);
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  Future<void> _submitLeave(BuildContext context, WidgetRef ref) async {
    final leaveType = ref.read(leaveTypeProvider);
    final fromDate = ref.read(fromDateProvider);
    final toDate = ref.read(toDateProvider);
    final reason = ref.read(reasonProvider);

    if (!_isFormValid(leaveType, fromDate, toDate, reason)) {
      _showSnackBar(context, 'Please fill in all required fields',
          const Color(0xFFDC2626));
      return;
    }

    if (toDate!.isBefore(fromDate!)) {
      _showSnackBar(context, 'End date must be after start date',
          const Color(0xFFDC2626));
      return;
    }

    ref.read(isLoadingProvider.notifier).state = true;

    try {
      await Future.delayed(const Duration(seconds: 2));
      ref.read(isLoadingProvider.notifier).state = false;

      // Show success dialog
      _showSuccessDialog(context, ref);
    } catch (e) {
      ref.read(isLoadingProvider.notifier).state = false;
      _showSnackBar(
          context, 'Failed to submit application', const Color(0xFFDC2626));
    }
  }

  void _showSuccessDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Color(0xFF10B981),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Application Submitted!',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Your leave application has been submitted successfully. You will receive a confirmation email shortly.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: const Color(0xFF6B7280),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _resetForm(ref);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Continue',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _resetForm(WidgetRef ref) {
    ref.read(leaveTypeProvider.notifier).state = null;
    ref.read(fromDateProvider.notifier).state = null;
    ref.read(toDateProvider.notifier).state = null;
    ref.read(alternateProvider.notifier).state = null;
    ref.read(reasonProvider.notifier).state = '';
    ref.read(attachedFileProvider.notifier).state = null;
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
