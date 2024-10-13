import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart'; // Import the Provider package
import 'package:student_management/provider.dart/student_provider.dart';
// import 'package:student_management/providers/student_provider.dart'; // Update with your correct path
import 'package:student_management/data_base_model/student_model.dart';

class EditStudentScreen extends StatefulWidget {
  final int index;

  const EditStudentScreen({super.key, required this.index});

  @override
  _EditStudentScreenState createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends State<EditStudentScreen> {
  final ImagePicker _picker = ImagePicker();

  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController fatherNameController;
  late TextEditingController schoolNameController;

  File? _imageFile;

  @override
  void initState() {
    super.initState();
    final student = Provider.of<StudentProvider>(context, listen: false)
        .students[widget.index];

    // Initialize the controllers with the existing student details
    nameController = TextEditingController(text: student.name);
    ageController = TextEditingController(text: student.age.toString());
    fatherNameController = TextEditingController(text: student.fathername);
    schoolNameController = TextEditingController(text: student.schoolname);
    _imageFile = File(student.profilePicturePath);
  }

  Future<void> pickImage() async {
    final XFile? pic = await _picker.pickImage(source: ImageSource.gallery);
    if (pic != null) {
      setState(() {
        _imageFile = File(pic.path);
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    fatherNameController.dispose();
    schoolNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C2E3A),
        title: const Text(
          'EDIT STUDENT',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : const AssetImage('assets/placeholder.jpg')
                            as ImageProvider,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    fillColor: Color(0xFFB3B48D),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                    fillColor: Color(0xFFB3B48D),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: fatherNameController,
                  decoration: const InputDecoration(
                    labelText: "Father's Name",
                    fillColor: Color(0xFFB3B48D),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: schoolNameController,
                  decoration: const InputDecoration(
                    labelText: 'School Name',
                    fillColor: Color(0xFFB3B48D),
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
                        id: Provider.of<StudentProvider>(context, listen: false)
                            .students[widget.index]
                            .id,
                        name: nameController.text,
                        schoolname: schoolNameController.text,
                        fathername: fatherNameController.text,
                        age: int.parse(ageController.text),
                        profilePicturePath:
                            _imageFile != null ? _imageFile!.path : '',
                      );
                      Provider.of<StudentProvider>(context, listen: false)
                          .updateStudent(widget.index, student);
                      Navigator.pop(context); // Navigate back after saving
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Student updated!')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Error updating student'),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'SAVE CHANGES',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
