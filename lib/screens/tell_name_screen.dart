import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_manager/models/user_preferences_model.dart';
import 'package:task_manager/services/hive_services.dart';
import 'package:task_manager/screens/home_screen.dart';

class TellNameScreen extends StatelessWidget {
  TellNameScreen({super.key});

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "What can we\n call you ?",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: nameController,
                maxLines: 1,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    hintText: "Name...",
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black87, width: 2),
                        borderRadius: BorderRadius.circular(50)),
                    prefixIcon: const Icon(
                      FontAwesomeIcons.faceSmile,
                      color: Colors.grey,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(50))),
              ),
              const SizedBox(
                height: 200,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // TODO: Fix the ui
                  ElevatedButton(
                    onPressed: () {
                      // Saving the name to Hive
                      var name = nameController.text;
                      if (name != "") {
                        UserPreferences userprefs = UserPreferences(username: name);
                        HiveService.saveName(name);
                        print("Your name is ${HiveService.getName()}");
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TodoHomeScreen()));
                      } else {
                        const snackbar = SnackBar(
                          content: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Oh Snappp!!!",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black87),
                                ),
                                Text("The name was left Empty.",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        color: Colors.black87)),
                              ],
                            ),
                          ),
                          duration: Duration(seconds: 2),
                          elevation: 5,
                          backgroundColor: Colors.teal,
                          showCloseIcon: true,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration:
                              const BoxDecoration(color: Colors.black54),
                          child: const Icon(
                            FontAwesomeIcons.arrowRight,
                            color: Colors.white,
                            size: 30,
                          )),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
