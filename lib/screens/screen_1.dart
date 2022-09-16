import 'package:assignment_1/model/user.dart';
import 'package:assignment_1/screens/screen_2.dart';
import 'package:assignment_1/utils/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Screen1 extends StatelessWidget {
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _birthDateTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  Screen1({Key? key}) : super(key: key);

  saveDataInSharePreference(User user) async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();

    // Fetch and decode data
    final String? userString = prefs.getString('User_key');
    if (userString != null) {
      final List<User> users = User.decode(userString);
      users.add(user);
      final String encodeData = User.encode(users);
      await prefs.setString('User_key', encodeData);
    } else {
      final String encodeData = User.encode([user]);
      await prefs.setString('User_key', encodeData);
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(DateTime.now());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 66.0, horizontal: 26.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "Welcome User",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26.0,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: "\nPlease enter your details",
                    style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      // fontSize: 26.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            TextInputField(
              controller: _nameTextEditingController,
              name: "Name",
              hint: "Enter Your Name",
              textInputType: TextInputType.name,
            ),
            const SizedBox(
              height: 35,
            ),
            GestureDetector(
              onTap: () async {
                DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100));
                if (date != null) {
                  _birthDateTextEditingController.text =
                      "${DateFormat("MMMM", "en_US").format(date)} ${date.day} ${date.year}";
                }
              },
              child: TextInputField(
                controller: _birthDateTextEditingController,
                name: "Birth Date",
                hint: "Birth Date",
                textInputType: TextInputType.datetime,
                enable: false,
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            TextInputField(
              controller: _emailTextEditingController,
              name: "Email Id",
              hint: "Enter Your Email Id",
              textInputType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 35,
            ),
            InkWell(
              onTap: () {
                if (_nameTextEditingController.text.isNotEmpty &&
                    _birthDateTextEditingController.text.isNotEmpty &&
                    _emailTextEditingController.text.isNotEmpty) {
                  User user = User(
                    name: _nameTextEditingController.text,
                    birthDate: _birthDateTextEditingController.text,
                    email: _emailTextEditingController.text,
                  );

                  saveDataInSharePreference(user);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const Screen2(),
                  ));
                }
              },
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.orange,
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
