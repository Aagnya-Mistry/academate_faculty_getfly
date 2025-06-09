import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final String courseName;
  final String semester;
  final String academicYear;
  final String branch;
  final int coCount;

  const CourseCard({
    super.key,
    required this.courseName,
    required this.semester,
    required this.academicYear,
    required this.branch,
    required this.coCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(courseName,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 4,
              children: [
                Text("Semester: $semester"),
                Text("Year: $academicYear"),
                Text("Branch: $branch"),
                Text("CO Count: $coCount"),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
