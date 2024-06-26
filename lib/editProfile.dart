import 'package:docside_1/profile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfile extends StatefulWidget {
  final String userId;

  const EditProfile({Key? key, required this.userId}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _specializationController =
      TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  String? yearsOfExperience;
  List<String> experienceRanges = ['1-3', '3-6', '6-9', '9-12', '12-15', '15+'];

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _specializationController.dispose();
    _contactNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'EDIT PROFILE',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        elevation: 20,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              TextField(
                controller: _nameController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  hintText: "Full Name",
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _ageController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  hintText: "Age",
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 15),

              DropdownButtonFormField<String>(
                value: yearsOfExperience,
                onChanged: (String? newValue) {
                  setState(() {
                    yearsOfExperience = newValue;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  hintText: "Experience",
                  prefixIcon: const SizedBox(width: 160),
                ),
                items: experienceRanges.map((String yearsOfExperience) {
                  return DropdownMenuItem<String>(
                    value: yearsOfExperience,
                    child: Center(
                      child: Text(
                        yearsOfExperience,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 15),

              //SPECIALIZATION
              TextField(
                controller: _specializationController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  hintText: "Specialisation",
                ),
              ),
              const SizedBox(height: 15),

              //CONTACT NUMBER
              TextField(
                controller: _contactNumberController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  hintText: "Contact Number",
                ),
                keyboardType: TextInputType.phone,
              ),

              // NEED TO WORK ON
              const SizedBox(height: 15),
              TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  hintText: "Change Password",
                ),
                obscureText: true, // Hide text
              ),
              const SizedBox(height: 15),
              TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  hintText: "Confirm Password",
                ),
                obscureText: true,
              ),
              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    height: 50,
                    child: TextButton(
                        onPressed: () {
                          _updateProfileData();
                          Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Profile()));
                        },
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue),
                        child: const Text('Update')),
                  ),
                  SizedBox(
                    width: 100,
                    height: 50,
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue),
                        child: const Text('Cancel')),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateProfileData() async {
    try {
      await FirebaseFirestore.instance
          .collection('Dr.signup')
          .doc(widget.userId)
          .update({
        'name': _nameController.text,
        'age': _ageController.text,
        'yearsOfExperience': yearsOfExperience,
        'specialization': _specializationController.text,
        'contactNumber': _contactNumberController.text,
      });
      print("User details updated in Firestore");
    } catch (e) {
      print("Error updating user details: $e");
    }
  }
}
