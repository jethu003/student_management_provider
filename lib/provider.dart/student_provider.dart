import 'package:flutter/material.dart';
import 'package:student_management/data_base_model/student_model.dart';

class StudentProvider with ChangeNotifier {
  List<Student> _students = [];

  List<Student> get students => _students;

  void addStudent(Student student) {
    _students.add(student);
    notifyListeners(); // Notify listeners to rebuild the UI
  }

  void updateStudent(int index, Student updatedStudent) {
    if (index >= 0 && index < _students.length) {
      _students[index] = updatedStudent;
      notifyListeners();
    }
  }

  void removeStudent(int index) {
    if (index >= 0 && index < _students.length) {
      _students.removeAt(index);
      notifyListeners();
    }
  }
}
