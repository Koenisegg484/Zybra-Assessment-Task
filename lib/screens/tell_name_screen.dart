import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_manager/app/bottom_navigation_page.dart';
import 'package:task_manager/config/themes/animated_page_router.dart';
import 'package:task_manager/config/themes/constants.dart';
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
          padding: mediumPadding,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset("assets/images/icon.png", height: 130, width: 130, fit: BoxFit.contain,),
                  ),
                  const Text(
                    "What can I call you ?",
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
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black87
                        ),
                        child: IconButton(
                            onPressed: () {
                              // Saving the name to Hive
                              var name = nameController.text;
                              if (name != "") {
                                HiveService.saveName(name);
                                HiveService.saveAppTheme("system");
                                HiveService.saveNotifications(true);
                                Navigator.pushReplacement(
                                    context,
                                    EntranceSlidePageRoute(
                                      page: const BottomNavigationPage(),
                                    ));
                              } else {
                                var snackbar = SnackBar(
                                  content: const Padding(
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
                                  duration: const Duration(seconds: 2),
                                  elevation: 5,
                                  backgroundColor: lightPurple,
                                  showCloseIcon: true,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackbar);
                              }
                            },focusColor: Colors.black87,

                            padding: mediumPadding,
                            color: Colors.black87,
                            icon: whiteSimpleIcon(icondata: Icons.keyboard_double_arrow_right_rounded)
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
