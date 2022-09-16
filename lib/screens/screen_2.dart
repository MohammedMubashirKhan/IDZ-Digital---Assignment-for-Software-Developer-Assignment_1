import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

class Screen2 extends StatefulWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  List<User> _users = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    // Fetch and decode data
    final String? userString = prefs.getString('User_key');
    final List<User> users = User.decode(userString!);
    _users = users;
    // for (var user in _users) {
    //   print(user.name);
    // }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 56.0, horizontal: 26.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "Registration Successful",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26.0,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: "\n\nYour Details are Submitted successfully",
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
                  height: 15,
                ),
                Table(
                  border: TableBorder.all(),
                  // children: [
                  //   buildRow(["Name", "Birthday", "Email Id"], isHeader: true),
                  //   buildRow([user.name, user.birthDate, user.email]),
                  //   displayData(_users);
                  // ],
                  children: displayData(_users),
                ),
                // Text(user.name),
                // Text(user.birthDate),
                // Text(user.email),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TableRow buildRow(List<String> cells, {bool isHeader = false}) {
    return TableRow(
        children: cells.map(
      (cell) {
        TextStyle style = TextStyle(
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              cell,
              style: style,
            ),
          ),
        );
      },
    ).toList());
  }

  List<TableRow> displayData(List<User> users) {
    List<TableRow> data = [];
    TableRow tableTitle =
        buildRow(["Name", "Birthday", "Email Id"], isHeader: true);
    data.add(tableTitle);
    for (User user in users) {
      TableRow row = buildRow([user.name, user.birthDate, user.email]);
      data.add(row);
    }
    return data;
  }
}
