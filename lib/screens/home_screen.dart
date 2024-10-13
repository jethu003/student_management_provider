import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:student_management/data_base_model/student_model.dart';
import 'package:student_management/provider.dart/student_provider.dart';
import 'student_detailscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String nameLabel = 'Enter name';
  String ageLabel = 'Enter age';
  String classLabel = 'Enter class';
  String fatherNameLabel = 'Enter father\'s name';
  String schoolNameLabel = 'Enter school name';
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController schoolNameController = TextEditingController();

  Future<void> imagePick() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      final XFile? pic = await _picker.pickImage(source: ImageSource.gallery);
      if (pic != null) {
        setState(() {
          _imageFile = File(pic.path);
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Permission denied")),
      );
    }
  }

  void resetFields() {
    setState(() {
      nameController.clear();
      ageController.clear();
      classController.clear();
      fatherNameController.clear();
      schoolNameController.clear();
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C2E3A),
        title: const Text(
          'ADD STUDENTS',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return StudentDetailscreen();
                }),
              );
            },
            child: const Icon(
              Icons.list,
              size: 36,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 3),
                  const SizedBox(height: 40),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                      color: Color(0xFF2C2E3A),
                      shape: BoxShape.circle,
                    ),
                    child: _imageFile == null
                        ? IconButton(
                            onPressed: imagePick,
                            icon: const Icon(Icons.camera_alt_rounded),
                            color: Colors.white,
                          )
                        : ClipOval(
                            child: Image.file(
                              _imageFile!,
                              fit: BoxFit.cover,
                              height: 100,
                              width: 100,
                            ),
                          ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    height: 600, // Adjusted height to fit all fields
                    width: 400,
                    color: const Color(0xFF2C2E3A),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: nameLabel,
                            fillColor: const Color(0xFFB3B48D),
                            filled: true,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: ageController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: ageLabel,
                            fillColor: const Color(0xFFB3B48D),
                            filled: true,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: classController,
                          decoration: InputDecoration(
                            labelText: classLabel,
                            fillColor: const Color(0xFFB3B48D),
                            filled: true,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: fatherNameController,
                          decoration: InputDecoration(
                            labelText: fatherNameLabel,
                            fillColor: const Color(0xFFB3B48D),
                            filled: true,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: schoolNameController,
                          decoration: InputDecoration(
                            labelText: schoolNameLabel,
                            fillColor: const Color(0xFFB3B48D),
                            filled: true,
                          ),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black12,
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 40.0),
                            minimumSize: const Size(200, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () {
                            try {
                              var student = Student(
                                id: 0, // You may want to modify how you handle IDs
                                name: nameController.text,
                                schoolname: schoolNameController.text,
                                fathername: fatherNameController.text,
                                age: int.parse(ageController.text),
                                profilePicturePath: _imageFile!.path,
                              );

                              // Use the Provider to add the student
                              Provider.of<StudentProvider>(context,
                                      listen: false)
                                  .addStudent(student);

                              resetFields(); // Clear fields after saving
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Student saved!')),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Error saving student'),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            'SAVE',
                            style: TextStyle(
                                fontSize: 18.0, // Adjust font size
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
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
}
