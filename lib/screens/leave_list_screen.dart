import 'package:flutter/material.dart';
import '../models/leave_request.dart';
import 'leave_detail_screen.dart';

class LeaveListScreen extends StatefulWidget {
  const LeaveListScreen({super.key});

  @override
  State<LeaveListScreen> createState() => _LeaveListScreenState();
}

class _LeaveListScreenState extends State<LeaveListScreen> with SingleTickerProviderStateMixin {
  final List<LeaveRequest> requests = [
    LeaveRequest(
      facultyName: 'Dr. GAYATRI DASHRATH BACHHAV',
      numberOfDays: 0.5,
      leaveType: 'Outdoor Duty',
      leaveReason: 'Education Summit',
      from: '05/12/2024',
      to: '05/12/2024',
      appliedDate: '01/01/1970',
    ),
    LeaveRequest(
      facultyName: 'Mr. ATUL HINDURAO SHINTRE',
      numberOfDays: 0.5,
      leaveType: 'Compensation Leave',
      leaveReason: 'Relative expired',
      from: '06/01/2025',
      to: '06/01/2025',
      appliedDate: '01/01/1970',
    ),
    LeaveRequest(
      facultyName: 'Dr. MAHAVIR ARJUN DEVMANE',
      numberOfDays: 1.0,
      leaveType: 'Compensation Leave',
      leaveReason: 'My son is ill...require medical treatment',
      from: '10/01/2025',
      to: '10/01/2025',
      appliedDate: '01/01/1970',
    ),
    LeaveRequest(
      facultyName: 'MRS. MANJIRI CHAITANYA KARANDIKAR',
      numberOfDays: 0.5,
      leaveType: 'Compensation Leave',
      leaveReason: 'Personal reason',
      from: '09/01/2025',
      to: '09/01/2025',
      appliedDate: '01/01/1970',
    ),
  ];

  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Take Charge', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        elevation: 4,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE1BEE7), Color(0xFFF8BBD0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final req = requests[index];
              return _InteractiveLeaveCard(
                leaveRequest: req,
                textTheme: textTheme,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LeaveDetailScreen(request: req),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _InteractiveLeaveCard extends StatefulWidget {
  final LeaveRequest leaveRequest;
  final TextTheme textTheme;
  final VoidCallback onTap;

  const _InteractiveLeaveCard({
    required this.leaveRequest,
    required this.textTheme,
    required this.onTap,
  });

  @override
  State<_InteractiveLeaveCard> createState() => __InteractiveLeaveCardState();
}

class __InteractiveLeaveCardState extends State<_InteractiveLeaveCard> with SingleTickerProviderStateMixin {
  late AnimationController _pressController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.05,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _pressController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _pressController.reverse();
  }

  void _onTapCancel() {
    _pressController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(16),
          elevation: 6,
          shadowColor: Colors.deepPurple.withOpacity(0.3),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            splashColor: Colors.deepPurple.withOpacity(0.2),
            onTap: widget.onTap,
            onTapDown: _onTapDown,
            onTapCancel: _onTapCancel,
            onTapUp: _onTapUp,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              leading: CircleAvatar(
                radius: 22,
                backgroundColor: Colors.deepPurple.shade100,
                child: const Icon(Icons.person, color: Colors.deepPurple),
                // Add subtle shadow for depth
              ),
              title: Text(
                widget.leaveRequest.facultyName,
                style: widget.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              subtitle: Text(
                "${widget.leaveRequest.leaveType} - ${widget.leaveRequest.numberOfDays} day(s)",
                style: widget.textTheme.bodyMedium,
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.deepPurple),
            ),
          ),
        ),
      ),
    );
  }
}
