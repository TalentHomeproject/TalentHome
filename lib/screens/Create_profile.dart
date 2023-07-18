import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firstapp/model/students_model.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({super.key});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref();
  final TextEditingController _edtNameController = TextEditingController();
  final TextEditingController _edtAgeController = TextEditingController();
  final TextEditingController _edtCourseController = TextEditingController();
  final TextEditingController _edtRegNoController = TextEditingController();

  List<Students> studentsList = [];
  bool updateStudent = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrievestudentsData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dialog"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          for (int i = 0; i < studentsList.length; i++)
            studentsWidget(studentsList[i])
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _edtNameController.text = "";
          _edtAgeController.text = "";
          _edtCourseController.text = "";
          _edtRegNoController.text = "";
          updateStudent = false;
          studentDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void retrievestudentsData() {
    dbRef.child("Students").onChildAdded.listen((data) {
      StudentsData studentsData =
          StudentsData.fromJson(data.snapshot.value as Map);

      Students students =
          Students(key: data.snapshot.key, studentData: studentsData);
      studentsList.add(students);
      setState(() {});
    });
  }

  Widget studentsWidget(Students students) {
    return InkWell(
      onTap: () {
        _edtNameController.text = students.studentData!.name!;
        _edtAgeController.text = students.studentData!.age!;
        _edtCourseController.text = students.studentData!.course!;
        _edtRegNoController.text = students.studentData!.regno!;
        updateStudent = true;
        studentDialog(key: students.key);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        //height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black)),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(students.studentData!.name!),
              Text(students.studentData!.age!),
              Text(students.studentData!.course!),
              Text(students.studentData!.regno!),
            ],
          ),
          InkWell(
            onTap: () {
              dbRef
                  .child("Students")
                  .child(students.key!)
                  .remove()
                  .then((value) {
                int index = studentsList
                    .indexWhere((element) => element.key == students.key);
              });
            },
            child: const Icon(
              Icons.delete,
              color: Colors.red,
              size: 25,
            ),
          )
        ]),
      ),
    );
  }

  void studentDialog({String? key}) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(children: [
                TextField(
                  decoration: const InputDecoration(helperText: "Name"),
                  controller: _edtNameController,
                ),
                TextField(
                  decoration: const InputDecoration(helperText: "Age"),
                  controller: _edtAgeController,
                ),
                TextField(
                  decoration: const InputDecoration(helperText: "Course"),
                  controller: _edtCourseController,
                ),
                TextField(
                  decoration: const InputDecoration(helperText: "RegNo"),
                  controller: _edtRegNoController,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      Map<String, dynamic> data = {
                        "name": _edtNameController.text.toString(),
                        "age": _edtAgeController.text.toString(),
                        "course": _edtCourseController.text.toString(),
                        "regno": _edtRegNoController.text.toString(),
                      };
                      if (updateStudent) {
                        dbRef
                            .child("Students")
                            .child(key!)
                            .update(data)
                            .then((value) {
                          int index = studentsList
                              .indexWhere((element) => element.key == key);
                          studentsList.removeAt(index);
                          studentsList.insert(
                              index,
                              Students(
                                  key: key,
                                  studentData: StudentsData.fromJson(data)));
                        });
                      }
                      dbRef.child("Students").push().set(data).then((value) {
                        Navigator.of(context).pop();
                      });
                    },
                    child: Text(updateStudent ? 'update' : 'Save Data'))
              ]),
            ),
          );
        });
  }
}
