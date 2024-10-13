import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider package
import 'package:student_management/provider.dart/student_provider.dart';

import 'package:student_management/screens/edit_student_screen.dart';
import 'package:student_management/screens/profile_screen.dart';

class StudentDetailscreen extends StatelessWidget {
  StudentDetailscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final studentProvider =
        Provider.of<StudentProvider>(context); // Access the StudentProvider

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C2E3A),
        title: const Text(
          'STUDENT LIST',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView.builder(
            itemCount:
                studentProvider.students.length, // Use the actual student count
            itemBuilder: (context, index) {
              final student =
                  studentProvider.students[index]; // Get the student data

              return Card(
                child: ListTile(
                  onTap: () {
                    // Navigate to ProfileScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(index: index),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundImage: student.profilePicturePath.isNotEmpty
                        ? FileImage(File(student.profilePicturePath))
                        : null, // Show image if available
                    child: student.profilePicturePath.isEmpty
                        ? const Icon(Icons.person) // Default icon if no image
                        : null,
                  ),
                  title: Text(student.name), // Display student's name
                  subtitle: Text(
                      'School: ${student.schoolname}'), // Display school name
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Navigate to EditStudentScreen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditStudentScreen(index: student.id),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          // Show confirmation dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Delete Student'),
                                content: const Text(
                                    'Are you sure you want to delete this student?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      // Perform delete operation here
                                      studentProvider.removeStudent(
                                          index); // Remove student from provider
                                      Navigator.pop(
                                          context); // Close the dialog
                                    },
                                    child: const Text('Delete'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(
                                          context); // Close the dialog
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
