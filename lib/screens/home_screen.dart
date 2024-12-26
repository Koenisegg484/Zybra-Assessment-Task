import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_manager/screens/create_task_screen.dart';
import 'package:task_manager/services/hive_services.dart';
import 'package:task_manager/widgets/no_tasks_yet.dart';

class TodoHomeScreen extends StatelessWidget {
  TodoHomeScreen({super.key});

  final greetings = "Hello";
  final username = HiveService.getName();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset("assets/images/happyface.png", fit: BoxFit.contain, width: 30, height: 30,),
            const SizedBox(width: 12,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(greetings, style:const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.black
                ),),
                Text("$username", style:const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                ),)
              ],
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              // TODO: Set create new task
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateTaskScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 10,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  side: BorderSide(color: Colors.black, width: 1)
                )
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Colors.black87
                      ),
                      child: const Icon(FontAwesomeIcons.plus, color: Colors.white, size: 18,),
                    ),
                  ),const SizedBox(width: 10,),
                  const Text("Create new Task", style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),)
                ],
              ),
            ),
          )
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          children: [
            Row(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // TODO: Create Sorting techniques
                      SortChip(title: "All", nums: 12),
                      SortChip(title: "Completed", nums: 12),
                      SortChip(title: "Pending", nums: 9),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: NoTasks(),
              // TODO: Set mapping for the listview builder
              // child: ListView.builder(itemBuilder: ),
            )
          ],
        ),
      )
    );
  }
}

class SortChip extends StatelessWidget {
  const SortChip({
    super.key,
    required this.title,
    required this.nums,
  });

  final String title;
  final int nums;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Chip(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        shape: const RoundedRectangleBorder(side: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(100))),
        label: Row(
          children: [
            Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
            const SizedBox(width: 20,),
            Container(
              height: 30,
              width: 30,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(100))
              ),
              child: Text(nums.toString(), style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400), textAlign: TextAlign.center,),
            )
          ],
        ),
      ),
    );
  }
}
