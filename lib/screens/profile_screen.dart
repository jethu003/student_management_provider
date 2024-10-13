import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider package
import 'package:student_management/provider.dart/student_provider.dart';
// import 'package:student_management/providers/student_provider.dart'; // Import your StudentProvider

class ProfileScreen extends StatelessWidget {
  final int index;

  const ProfileScreen({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context); // Access the StudentProvider
    final student = studentProvider.students[index]; // Retrieve the student using the index

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${student.name}'s Profile", // Display actual student name
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: const Color(0xFF2C2E3A),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: student.profilePicturePath.isNotEmpty
                        ? FileImage(File(student.profilePicturePath))
                        : const AssetImage('assets/default_profile.png'), // Replace with your default image asset if no image
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                student.name, // Display actual student name
                style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Text(
                'School: ${student.schoolname}', // Display actual school name
                style: const TextStyle(fontSize: 30, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Text(
                'Age: ${student.age}', // Display actual age
                style: const TextStyle(fontSize: 30, color: Colors.grey),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
