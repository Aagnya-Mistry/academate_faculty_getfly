import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../themes/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'dart:developer';

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
  // const ApplyLeaveScreen({super.key});
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
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Enhanced Header
          SliverAppBar(
            expandedHeight: 100,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.primary,
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
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary,
                      AppColors.accent,
                      AppColors.accent.withOpacity(0.8),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                    color: Colors.white.withOpacity(0.3)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    offset: const Offset(0, 4),
                                    blurRadius: 8,
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
                                      fontSize: 24,
                                      color: Colors.white.withOpacity(0.9),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'Application Form',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Form Content
          SliverPadding(
            padding: const EdgeInsets.all(15),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Main Form Card
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withAlpha((0.08 * 255).toInt()),
                        blurRadius: 32,
                        offset: const Offset(0, 8),
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: Colors.black.withAlpha((0.04 * 255).toInt()),
                        blurRadius: 16,
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Please fill in all required fields to submit your request',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: AppColors.textSecondary,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.primary,
                                    AppColors.accent,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withAlpha((0.3 * 255).toInt()),
                                    blurRadius: 12,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: const Icon(Icons.description_outlined,
                                  color: Colors.white, size: 24),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Form Fields
                        _buildFormField(
                          'Leave Type',
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

                        const SizedBox(height: 15),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // From Date Field
                            _buildFormField(
                              'From Date',
                              _buildDateField(
                                context,
                                fromDate,
                                'Select start date',
                                (selectedDate) {
                                  ref.read(fromDateProvider.notifier).state =
                                      selectedDate;

                                  // Clear 'To Date' if it's before the new 'From Date'
                                  final currentToDate =
                                      ref.read(toDateProvider);
                                  if (currentToDate != null &&
                                      currentToDate.isBefore(selectedDate)) {
                                    ref.read(toDateProvider.notifier).state =
                                        null;
                                  }
                                },
                                firstDate: DateTime.now(),
                              ),
                              Icons.event_outlined,
                              isRequired: true,
                            ),
                            const SizedBox(height: 15),
                            // To Date Field
                            _buildFormField(
                              'To Date',
                              _buildDateField(
                                context,
                                toDate,
                                'Select end date',
                                (selectedDate) {
                                  ref.read(toDateProvider.notifier).state =
                                      selectedDate;
                                },
                                firstDate: fromDate ?? DateTime.now(),
                              ),
                              Icons.event_outlined,
                              isRequired: true,
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

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

                        const SizedBox(height: 20),

                        _buildFormField(
                          'Reason for Leave',
                          _buildTextArea(
                            'Please provide a detailed reason for your leave request...',
                            (value) =>
                                ref.read(reasonProvider.notifier).state = value,
                          ),
                          Icons.notes_outlined,
                          isRequired: true,
                        ),

                        const SizedBox(height: 20),

                        _buildFormField(
                          'Supporting Documents',
                          _buildFileUpload(attachedFile, () => _pickFile(ref)),
                          Icons.attach_file_outlined,
                        ),

                        const SizedBox(height: 30),

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
            Icon(icon, size: 18, color: AppColors.accent),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            if (isRequired)
              Text(
                ' *',
                style: TextStyle(color: AppColors.error, fontSize: 16),
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
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: value != null ? AppColors.accent : AppColors.secondary.withOpacity(0.3),
        width: value != null ? 2 : 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: (value != null ? AppColors.accent : AppColors.secondary)
              .withAlpha((0.1 * 255).toInt()),
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
          color: AppColors.textSecondary,
          fontSize: 16,
        ),
        border: InputBorder.none,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      ),
      icon: Container(
        margin: const EdgeInsets.only(right: 16),
        child: Icon(Icons.expand_more, color: AppColors.accent),
      ),
      items: items,
      onChanged: onChanged,
      dropdownColor: AppColors.surface,
      style: GoogleFonts.inter(
        color: AppColors.textPrimary,
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
              colorScheme: ColorScheme.light(
                primary: AppColors.primary,
                onPrimary: Colors.white,
                surface: AppColors.surface,
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
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: selectedDate != null
              ? AppColors.accent
              : AppColors.secondary.withOpacity(0.3),
          width: selectedDate != null ? 2 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: (selectedDate != null ? AppColors.accent : AppColors.secondary)
                .withAlpha((0.1 * 255).toInt()),
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
                ? AppColors.accent
                : AppColors.textSecondary,
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
                    ? AppColors.textPrimary
                    : AppColors.textSecondary,
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
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppColors.secondary.withOpacity(0.3), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: AppColors.secondary.withAlpha((0.1 * 255).toInt()),
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
          color: AppColors.textSecondary,
          fontSize: 16,
        ),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.all(20),
      ),
      style: GoogleFonts.inter(
        fontSize: 16,
        color: AppColors.textPrimary,
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
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: file != null ? AppColors.success : AppColors.secondary.withOpacity(0.3),
          width: file != null ? 2 : 1.5,
          style: BorderStyle.solid,
        ),
        boxShadow: [
          BoxShadow(
            color: (file != null ? AppColors.success : AppColors.secondary)
                .withAlpha((0.1 * 255).toInt()),
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
              color: (file != null ? AppColors.success : AppColors.accent)
                  .withAlpha((0.1 * 255).toInt()),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              file != null
                  ? Icons.check_circle_outline
                  : Icons.cloud_upload_outlined,
              color: file != null ? AppColors.success : AppColors.accent,
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
                  style: GoogleFonts.poppins(
                    color: file != null ? AppColors.success : AppColors.accent,
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
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          if (file != null)
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.success,
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
          ? LinearGradient(
              colors: [AppColors.primary, AppColors.accent],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            )
          : null,
      color: isEnabled ? null : AppColors.secondary.withOpacity(0.3),
      borderRadius: BorderRadius.circular(18),
      boxShadow: isEnabled
          ? [
              BoxShadow(
                color: AppColors.primary.withAlpha((0.3 * 255).toInt()),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
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
                  color: isEnabled ? Colors.white : AppColors.textSecondary,
                  size: 22,
                ),
                const SizedBox(width: 12),
                Text(
                  'Submit Application',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: isEnabled ? Colors.white : AppColors.textSecondary,
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
    log('Error picking file: $e');
  }
}

Future<void> _submitLeave(BuildContext context, WidgetRef ref) async {
  final leaveType = ref.read(leaveTypeProvider);
  final fromDate = ref.read(fromDateProvider);
  final toDate = ref.read(toDateProvider);
  final reason = ref.read(reasonProvider);

  if (!_isFormValid(leaveType, fromDate, toDate, reason)) {
    _showSnackBar(
        context, 'Please fill in all required fields', const Color(0xFFDC2626));
    return;
  }

  if (toDate!.isBefore(fromDate!)) {
    _showSnackBar(
        context, 'End date must be after start date', const Color(0xFFDC2626));
    return;
  }

  ref.read(isLoadingProvider.notifier).state = true;

  try {
    await Future.delayed(const Duration(seconds: 2));
    await Future.delayed(
        const Duration(seconds: 2)); // Can be removed if redundant
    ref.read(isLoadingProvider.notifier).state = false;

    if (context.mounted) {
      _showSuccessDialog(context, ref);
    }
  } catch (e) {
    ref.read(isLoadingProvider.notifier).state = false;
    if (context.mounted) {
      _showSnackBar(
          context, 'Failed to submit application', const Color(0xFFDC2626));
    }
  }
}

// Shows a success dialog
void _showSuccessDialog(BuildContext context, WidgetRef ref) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle_outline, color: Colors.green, size: 48),
                const SizedBox(height: 16),
                Text(
                  'Leave Submitted',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your leave request has been successfully submitted.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(color: Colors.black54),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _resetForm(ref);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E40AF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

// Resets the form fields
void _resetForm(WidgetRef ref) {
  ref.read(leaveTypeProvider.notifier).state = null;
  ref.read(fromDateProvider.notifier).state = null;
  ref.read(toDateProvider.notifier).state = null;
  ref.read(alternateProvider.notifier).state = null;
  ref.read(reasonProvider.notifier).state = '';
  ref.read(attachedFileProvider.notifier).state = null;
}

// Shows a snackbar with the provided message and color
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
