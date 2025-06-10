import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/info_card.dart';
import '../widgets/in_out_time_card.dart';
import '../widgets/punch_record_list.dart';
import '../widgets/leaves_summary.dart';
import '../models/leave_request.dart';
import 'leave_detail_screen.dart';
import 'package:go_router/go_router.dart';
import 'punch_record_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String getTodaysDate() {
    return DateFormat('dd MMMM yyyy').format(DateTime.now());
  }

  final List<Map<String, String>> punchRecords = const [
    {
      'name': 'Faculty Demo',
      'punchIn': '-----',
      'punchOut': '-----',
      'date': '18-09-2024'
    },
    {
      'name': 'Faculty Demo',
      'punchIn': '-----',
      'punchOut': '-----',
      'date': '17-09-2024'
    },
    {
      'name': 'Faculty Demo',
      'punchIn': '-----',
      'punchOut': '-----',
      'date': '16-09-2024'
    },
    {
      'name': 'Faculty Demo',
      'punchIn': '-----',
      'punchOut': '-----',
      'date': '15-09-2024'
    },
    {
      'name': 'Faculty Demo',
      'punchIn': '-----',
      'punchOut': '-----',
      'date': '14-09-2024'
    },
  ];

  final List<LeaveRequest> leaveRequests = [
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
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: buildSideDrawer(),
      appBar: AppBar(
        title: Text('Academate', style: theme.appBarTheme.titleTextStyle),
        backgroundColor: theme.appBarTheme.backgroundColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            color: theme.appBarTheme.iconTheme?.color,
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary.withOpacity(0.1),
              theme.colorScheme.secondary.withOpacity(0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: buildDashboardContent(context),
        ),
      ),
    );
  }

  Widget buildDashboardContent(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "👋 Hello, Faculty Demo",
          style:
              theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          getTodaysDate(),
          style: theme.textTheme.bodyMedium!.copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 20),
        const InOutTimeCard(),
        const SizedBox(height: 16),
        Row(
          children: const [
            Expanded(
              child: InfoCard(
                icon: FontAwesomeIcons.clock,
                label: 'Total Hours',
                value: '0 hrs',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: InfoCard(
                icon: FontAwesomeIcons.calendarWeek,
                label: 'Week Total',
                value: '0 hrs & 0.0 min',
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          "🕑 Recent Punch Records",
          style: theme.textTheme.titleMedium!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        PunchRecordList(punchRecords: punchRecords),
        const SizedBox(height: 20),
        Text(
          "📋 Pending Leaves Count",
          style: theme.textTheme.titleMedium!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        const LeavesSummary(),
        const SizedBox(height: 30),
        Text(
          "📌 Pending Faculty Leaves",
          style: theme.textTheme.titleMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ...leaveRequests.map(
          (request) => Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.primary,
                child: const Icon(Icons.person, color: Colors.white),
              ),
              title: Text(
                request.facultyName,
                style: theme.textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                "Type: ${request.leaveType} | Days: ${request.numberOfDays}",
                style: theme.textTheme.bodyMedium,
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LeaveDetailScreen(request: request),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSideDrawer() {
    final theme = Theme.of(context);
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12),
        children: [
          Text("📚 Menu", style: theme.textTheme.titleLarge),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text("Dashboard"),
              onTap: () {}),
          ExpansionTile(
            leading: const Icon(Icons.event_note),
            title: const Text("Leaves"),
            children: const [
              ListTile(title: Text("Apply Leave")),
              ListTile(title: Text("Leave History")),
              ListTile(title: Text("Cancelled Leaves")),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.swap_calls),
            title: const Text("Alternate Leaves"),
            children: const [
              ListTile(title: Text("Alternate Leave Approval")),
              ListTile(title: Text("Alternate Approved Leaves")),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.access_time),
            title: const Text("Punch Record"),
            onTap: () {
              Navigator.pushNamed(
                  context, '/punch_record'); // Navigate using route path
            },
          ),
          ExpansionTile(
            leading: const Icon(Icons.swap_calls),
            title: const Text("Courses"),
            children: [
              ListTile(
                  title: Text("Your Courses"),
                  onTap: () {
                    Navigator.pushNamed(
                        context, '/your_courses'); // Navigate using route path
                  }),
              ListTile(title: Text("POs")),
              ListTile(title: Text("COPO Mapping")),
            ],
          ),
          const ListTile(
              leading: Icon(Icons.checklist), title: Text("Assessment")),
          ExpansionTile(
            leading: const Icon(Icons.swap_calls),
            title: const Text("LMS"),
            children: [
              ListTile(
                  title: Text("Classrooms"),
                  onTap: () {
                    Navigator.pushNamed(context,
                        '/your_classrooms'); // Navigate using route path
                  }),
              ListTile(
                title: Text("Manage Classrooms"),
                onTap: () {
                  Navigator.pushNamed(context,
                      '/manage_classrooms'); // Navigate using route path
                },
              ),
              ListTile(title: Text("Mark Attendance")),
              ListTile(title: Text("Attendance History")),
              ListTile(title: Text("My Mentees")),
            ],
          ),
          const ListTile(leading: Icon(Icons.fact_check), title: Text("Exam")),
          const ListTile(leading: Icon(Icons.extension), title: Text("Add-on")),
        ],
      ),
    );
  }
}
