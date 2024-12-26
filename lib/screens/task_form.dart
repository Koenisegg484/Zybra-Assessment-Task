import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TaskFormWidget extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;

  const TaskFormWidget({super.key, required this.onSubmit});

  @override
  _TaskFormWidgetState createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  final createTaskFormKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final TextEditingController customTagController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();

  DateTime? _startDate;
  DateTime? _dueDate;
  int? selectedPriorityIndex;
  int? selectedTagsIndex;
  bool showCustomField = false;

  final List<String> priorities = ["Low", "Medium", "High", "Critical"];
  final List<String> commonTags = ["Home", "School", "Personal", "Custom"];

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
      commonTags.insert(
          commonTags.length - 1, customTag);
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

  void _submitForm() {
    if (createTaskFormKey.currentState?.validate() ?? false) {
      widget.onSubmit({
        'title': _titleController.text,
        'description': _descriptionController.text,
        'startDate': _startDate,
        'dueDate': _dueDate,
      });
    }
  }

  final InputDecoration inputDecoration = InputDecoration(
    hintStyle: TextStyle(
      fontSize: 18,
      color: Colors.grey.shade700,
    ),
    filled: true,
    fillColor: Colors.grey.shade300,
    contentPadding:
        const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(22),
      borderSide: BorderSide.none, // Set border width to 0
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
      child: Form(
        key: createTaskFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Create \nnew Task",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 35,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 16,
            ),

            // For Title
            TextFormField(
              controller: _titleController,
              decoration: inputDecoration.copyWith(hintText: "Title"),
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _descriptionController,
              decoration: inputDecoration.copyWith(hintText: "Description"),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(context, true),
                    child: AbsorbPointer(
                      child: TextFormField(
                        decoration:
                            inputDecoration.copyWith(hintText: "Start Date"),
                        controller: TextEditingController(
                          text: _startDate != null
                              ? _startDate!.toLocal().toString().split(' ')[0]
                              : '',
                        ),
                        validator: (value) {
                          if (_startDate == null) {
                            return 'Please select a start date';
                          }
                          return null;
                        },
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
                        decoration:
                            inputDecoration.copyWith(hintText: "Due Date"),
                        controller: TextEditingController(
                          text: _dueDate != null
                              ? _dueDate!.toLocal().toString().split(' ')[0]
                              : '',
                        ),
                        validator: (value) {
                          if (_dueDate == null) {
                            return 'Please select a due date';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Icon(FontAwesomeIcons.flag, size: 15),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Priority",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
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
                          color: selectedPriorityIndex == index
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      selected: selectedPriorityIndex == index,
                      onSelected: (bool selected) {
                        setState(() {
                          selectedPriorityIndex = selected ? index : null;
                        });
                      },
                      selectedColor: Colors.blue,
                      backgroundColor: Colors.grey.shade300,
                    ),
                  );
                }),
              ),
            ),

            const Row(
              children: [
                Icon(FontAwesomeIcons.flag, size: 15),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Tags",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
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
                      backgroundColor: Colors.grey.shade300,
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
                  decoration: inputDecoration.copyWith(hintText: "Your custom tag"),
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
              decoration: inputDecoration.copyWith(hintText: "Select start time"),
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: _submitForm,
                child: Text('Create Task'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
