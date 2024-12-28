import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/tasks_model.dart';
import '../providers/tasks_list_providers.dart';

class UpdateTaskFormWidget extends ConsumerStatefulWidget{
  final Task existingTask;
  final Function(Map<String, dynamic>) onUpdate;

  const UpdateTaskFormWidget({
    Key? key,required this.existingTask,required this.onUpdate,}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpdateTaskFormWidgetState();
}

class _UpdateTaskFormWidgetState extends ConsumerState<UpdateTaskFormWidget> {
  final updateTaskFormKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController customTagController;
  late TextEditingController startTimeController;

  DateTime? _startDate;
  DateTime? _dueDate;
  int? selectedPriorityIndex;
  int? selectedTagsIndex;
  bool showCustomField = false;

  final List<String> priorities = ["Low", "Medium", "High", "Critical"];
  final List<String> commonTags = ["Home", "School", "Personal", "Custom"];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.existingTask.title);
    _descriptionController = TextEditingController(text: widget.existingTask.description);
    customTagController = TextEditingController();
    startTimeController = TextEditingController(text: widget.existingTask.startTime);

    _startDate = widget.existingTask.startDate;
    _dueDate = widget.existingTask.dueDate;

    selectedPriorityIndex = priorities.indexOf(widget.existingTask.priority ?? "");
    selectedTagsIndex = commonTags.indexOf(widget.existingTask.tags ?? "");
  }

  void _updateForm(BuildContext context, WidgetRef ref) {
    if (updateTaskFormKey.currentState?.validate() ?? false) {
      final updatedTask = Task(
        id: widget.existingTask.id,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        startDate: _startDate,
        dueDate: _dueDate,
        priority: selectedPriorityIndex != null
            ? ["Low", "Medium", "High", "Critical"][selectedPriorityIndex!]
            : null,
        tags: selectedTagsIndex != null
            ? ["Home", "School", "Personal", "Custom"][selectedTagsIndex!]
            : null,
        startTime: startTimeController.text.trim(),
      );

      // Call the updateTask method from Riverpod provider
      ref.read(tasksNotifierProvider.notifier).updateTask(updatedTask);

      // Close the form
      Navigator.pop(context);
    } else {
      print("Form validation failed.");
    }
  }


  Future<void> selectStartTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child ?? const SizedBox(),
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        startTimeController.text = pickedTime.format(context);
      });
    }
  }

  void addCustomTag(String customTag) {
    setState(() {
      commonTags.insert(commonTags.length - 1, customTag);
      selectedTagsIndex = commonTags.length - 2;
      showCustomField = false;
    });
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _dueDate = picked;
        }
      });
    }
  }

  final InputDecoration inputDecoration = InputDecoration(
    hintStyle: TextStyle(
        fontSize: 22,
        color: Colors.grey.shade400,
        fontWeight: FontWeight.w600
    ),
    filled: true,
    fillColor: Colors.grey.shade50,
    contentPadding:
    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(22),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(22),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(22),
      borderSide: BorderSide.none,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: updateTaskFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Update \nTask",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xfffa60f6),
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Icon(FontAwesomeIcons.flag, size: 15, color: Colors.black,),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Title",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 25,
                        color: Colors.black),
                  )
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: inputDecoration.copyWith(hintText: "Title"),
                validator: (value) => value == null || value.isEmpty ? "Please enter a title" : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Color(0xff6ffa60),
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Icon(FontAwesomeIcons.flag, size: 15, color: Colors.black,),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Description",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 25,
                        color: Colors.black),
                  )
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: inputDecoration.copyWith(hintText: "Description"),
                maxLines: 5,
                validator: (value) => value == null || value.isEmpty ? "Please enter a description" : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Color(0xff606dfa),
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Icon(FontAwesomeIcons.flag, size: 15, color: Colors.black,),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Duration",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 25,
                        color: Colors.black),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectDate(context, true),
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: inputDecoration.copyWith(hintText: "Start Date"),
                          controller: TextEditingController(
                            text: _startDate?.toLocal().toString().split(' ')[0] ?? "",
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectDate(context, false),
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: inputDecoration.copyWith(hintText: "Due Date"),
                          controller: TextEditingController(
                            text: _dueDate?.toLocal().toString().split(' ')[0] ?? "",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Color(0xfffa6363),
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Icon(FontAwesomeIcons.flag, size: 15, color: Colors.black,),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Priority",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 25,
                        color: Colors.black),
                  )
                ],
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(priorities.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ChoiceChip(
                        label: Text(
                          priorities[index],
                          style: TextStyle(
                            color: selectedPriorityIndex == index ? Colors.white : Colors.black,
                          ),
                        ),
                        selected: selectedPriorityIndex == index,
                        onSelected: (bool selected) {
                          setState(() {
                            selectedPriorityIndex = selected ? index : null;
                          });
                        },
                        selectedColor: Colors.red,
                        backgroundColor: Colors.grey.shade100,
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Color(0xfffadb60),
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Icon(FontAwesomeIcons.flag, size: 15, color: Colors.black,),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Tags",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 25,
                        color: Colors.black),
                  )
                ],
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(commonTags.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ChoiceChip(
                        label: Text(
                          commonTags[index],
                          style: TextStyle(
                            color: selectedTagsIndex == index
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        selected: selectedTagsIndex == index,
                        onSelected: (bool selected) {
                          if (commonTags[index] == "Custom") {
                            setState(() {
                              showCustomField = true;
                            });
                          } else {
                            setState(() {
                              selectedTagsIndex = selected ? index : null;
                            });
                          }
                        },
                        selectedColor: Colors.blue,
                        backgroundColor: Colors.grey.shade100,
                      ),
                    );
                  }),
                ),
              ),
              if (showCustomField)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextFormField(
                    controller: customTagController,
                    decoration:
                    inputDecoration.copyWith(hintText: "Your custom tag"),
                    onFieldSubmitted: (value) {
                      if (value.trim().isNotEmpty) {
                        addCustomTag(value.trim());
                        customTagController.clear();
                      }
                    },
                  ),
                ),
              const SizedBox(height: 16),
              TextFormField(
                controller: startTimeController,
                readOnly: true,
                onTap: () => selectStartTime(context),
                decoration:
                inputDecoration.copyWith(hintText: "Select start time"),
              ),
              const SizedBox(height: 32),
              Center(
                  child: ElevatedButton(
                      onPressed: () {
                        _updateForm(context, ref);
                      },
                      style: ElevatedButton.styleFrom(
                          overlayColor: Colors.blue,
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        width: double.infinity,
                        child: const Text("Be Productive",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      )))
            ],
          ),
        ),
      );
  }
}
