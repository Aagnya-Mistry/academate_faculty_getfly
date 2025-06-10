import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Classroom {
  final String id;
  final String name;
  final String description;
  final DateTime createdAt;

  Classroom({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
  });
}

class ClassroomWidget extends StatefulWidget {
  @override
  _ClassroomWidgetState createState() => _ClassroomWidgetState();
}

class _ClassroomWidgetState extends State<ClassroomWidget> {
  List<Classroom> _classrooms = [];
  List<Classroom> _filteredClassrooms = [];

  @override
  void initState() {
    super.initState();
    // Initialize with some sample data
    _classrooms = [
      Classroom(
        id: '1',
        name: 'Mathematics 101',
        description: 'Basic mathematics course for beginners',
        createdAt: DateTime.now().subtract(Duration(days: 5)),
      ),
      Classroom(
        id: '2',
        name: 'Physics Advanced',
        description: 'Advanced physics concepts and applications',
        createdAt: DateTime.now().subtract(Duration(days: 10)),
      ),
    ];
    _filterClassrooms();
  }

  void _filterClassrooms() {
    setState(() {
      _filteredClassrooms = List.from(_classrooms);
    });
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;
    
    if (difference == 0) {
      return 'today';
    } else if (difference == 1) {
      return 'yesterday';
    } else if (difference < 7) {
      return '$difference days ago';
    } else {
      return DateFormat('MMM dd, yyyy').format(date);
    }
  }

  Widget _buildClassroomCard(Classroom classroom) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.dividerColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.class_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      classroom.name,
                      style: theme.textTheme.titleMedium,
                    ),
                    if (classroom.description.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        classroom.description,
                        style: theme.textTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'delete') {
                    _deleteClassroom(classroom);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline, size: 18, color: colorScheme.error),
                        const SizedBox(width: 8),
                        Text('Delete', style: TextStyle(color: colorScheme.error)),
                      ],
                    ),
                  ),
                ],
                child: Icon(Icons.more_vert, color: theme.textTheme.bodyMedium?.color),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Text(
                  'Active',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.green.shade700,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                'Created ${_formatDate(classroom.createdAt)}',
                style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _deleteClassroom(Classroom classroom) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Classroom', style: theme.textTheme.titleLarge),
        content: Text('Are you sure you want to delete "${classroom.name}"?', 
                     style: theme.textTheme.bodyLarge),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: theme.textTheme.bodyLarge?.color)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _classrooms.removeWhere((c) => c.id == classroom.id);
                _filterClassrooms();
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Classroom "${classroom.name}" deleted!'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.error,
              foregroundColor: colorScheme.onError,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Classrooms'),
      ),
      body: ListView.builder(
        itemCount: _filteredClassrooms.length,
        itemBuilder: (context, index) {
          return _buildClassroomCard(_filteredClassrooms[index]);
        },
      ),
    );
  }
}