import 'package:flutter/material.dart';
import '../models/leave_request.dart';

class LeaveDetailScreen extends StatefulWidget {
  final LeaveRequest request;

  const LeaveDetailScreen({super.key, required this.request});

  @override
  State<LeaveDetailScreen> createState() => _LeaveDetailScreenState();
}

class _LeaveDetailScreenState extends State<LeaveDetailScreen>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.0;
  late final AnimationController _buttonAnimController;

  @override
  void initState() {
    super.initState();

    _buttonAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.1,
    );

    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  void dispose() {
    _buttonAnimController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _buttonAnimController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _buttonAnimController.reverse();
  }

  void _onTapCancel() {
    _buttonAnimController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Leave Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 4,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(milliseconds: 600),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 254, 254, 254), Color.fromARGB(255, 255, 255, 255)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildAnimatedDetailCard(
                "👤 Faculty Name",
                widget.request.facultyName,
                textTheme,
              ),
              _buildAnimatedDetailCard(
                "📅 Number of Days",
                "${widget.request.numberOfDays}",
                textTheme,
              ),
              _buildAnimatedDetailCard(
                "🏷️ Leave Type",
                widget.request.leaveType,
                textTheme,
              ),
              _buildAnimatedDetailCard(
                "📝 Reason",
                widget.request.leaveReason,
                textTheme,
              ),
              _buildAnimatedDetailCard(
                "📆 From",
                widget.request.from,
                textTheme,
              ),
              _buildAnimatedDetailCard("📆 To", widget.request.to, textTheme),
              _buildAnimatedDetailCard(
                "📌 Applied Date",
                widget.request.appliedDate,
                textTheme,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildInteractiveButton(
                    label: "Approve",
                    icon: Icons.check_circle_outline,
                    backgroundColor: Colors.green,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("✅ Approved Successfully"),
                        ),
                      );
                    },
                  ),
                  _buildInteractiveButton(
                    label: "Deny",
                    icon: Icons.cancel_outlined,
                    backgroundColor: Colors.redAccent,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("❌ Charge Denied")),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedDetailCard(
    String label,
    String value,
    TextTheme textTheme,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
        builder: (context, opacity, child) {
          return Opacity(opacity: opacity, child: child);
        },
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadowColor: Colors.deepPurple.withOpacity(0.3),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            splashColor: Colors.deepPurple.withOpacity(0.2),
            onTap: () {
              // Optionally: Add interaction on tap if needed
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      label,
                      style: textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      value,
                      style: textTheme.bodyMedium!.copyWith(
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInteractiveButton({
    required String label,
    required IconData icon,
    required Color backgroundColor,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: 0.9).animate(
          CurvedAnimation(parent: _buttonAnimController, curve: Curves.easeOut),
        ),
        child: ElevatedButton.icon(
          icon: Icon(icon, color: Colors.white),
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 6,
            shadowColor: Colors.black45,
          ),
          onPressed: onPressed,
          label: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
