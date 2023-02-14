import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maybank_assessment/constants/app_colors.dart';
import 'package:flutter_maybank_assessment/constants/string_constants.dart';
import 'package:flutter_maybank_assessment/cubit/add_new_todo_list/add_new_todo_list_cubit.dart';
import 'package:flutter_maybank_assessment/cubit/read_todo_list/read_todo_list_cubit.dart';
import 'package:flutter_maybank_assessment/db/tododb.dart';
import 'package:flutter_maybank_assessment/utils/custom_app_bar.dart';
import 'package:intl/intl.dart';

class Page2Screen extends StatefulWidget {
  const Page2Screen({super.key, this.args});

  static const routeName = "page-2-screen";

  final Map? args;

  @override
  State<Page2Screen> createState() => _Page2ScreenState();
}

class _Page2ScreenState extends State<Page2Screen> {
  final OutlineInputBorder outlineInputBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.textColor),
  );

  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final todoTitleController = TextEditingController();
  static final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log(widget.args!["title"].toString());
  }

  @override
  void dispose() {
    super.dispose();
    startDateController.dispose();
    endDateController.dispose();
    todoTitleController.dispose();
  }

  Future<void> selectDate(TextEditingController controller) async {
    // log(DateTime.now().toString());
    await showDatePicker(
      context: context,
      initialDate: controller.text.isNotEmpty
          ? DateTime.parse(controller.text)
          : DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    ).then((selectedDate) {
      if (selectedDate != null) {
        controller.text = DateFormat('yyyy-MM-dd').format(selectedDate);
        // controller.text = selectedDate.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: StringConstants.addNewToDoList),
      body: Container(
        margin: EdgeInsets.only(top: 40, left: 20, right: 20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //build to do title
              const TextWidget(
                title: StringConstants.toDoTitle,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value == "") {
                    return StringConstants.toDoTitleError;
                  }
                  return null;
                },
                controller: todoTitleController,
                onChanged: (value) {},
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    focusedBorder: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    errorBorder: outlineInputBorder,
                    focusedErrorBorder: outlineInputBorder,
                    hintText: StringConstants.keyInYourToDoTitle,
                    hintStyle: const TextStyle(color: AppColors.hintColor)),
              ),
              const SizedBox(
                height: 25,
              ),
              //build start date
              const TextWidget(title: StringConstants.startDate),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                readOnly: true,
                onChanged: (value) {},
                keyboardType: TextInputType.datetime,
                controller: startDateController,
                onTap: () => selectDate(startDateController),
                validator: (value) {
                  if (value == "") {
                    return StringConstants.startDateError;
                  }
                },
                decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.keyboard_arrow_down),
                    focusedBorder: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    errorBorder: outlineInputBorder,
                    focusedErrorBorder: outlineInputBorder,
                    hintText: StringConstants.selectADate,
                    hintStyle: const TextStyle(color: AppColors.hintColor)),
              ),
              //build end date
              const SizedBox(
                height: 25,
              ),
              const TextWidget(title: StringConstants.endDate),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (value) {},
                keyboardType: TextInputType.datetime,
                onTap: () => selectDate(endDateController),
                controller: endDateController,
                validator: (value) {
                  if (value == "") {
                    return StringConstants.endDateError;
                  }
                  if (startDateController.text != "" &&
                      DateTime.parse(startDateController.text)
                          .isAfter(DateTime.parse(value ?? ""))) {
                    return StringConstants.endDateError2;
                  }
                },
                decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.keyboard_arrow_down),
                    focusedBorder: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    errorBorder: outlineInputBorder,
                    focusedErrorBorder: outlineInputBorder,
                    hintText: StringConstants.selectADate,
                    errorMaxLines: 2,
                    hintStyle: const TextStyle(color: AppColors.hintColor)),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 60,
        width: double.infinity,
        color: Colors.black,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              BlocProvider.of<AddNewTodoListCubit>(context).insertIntoDatabase(
                  todoTitleController.text,
                  startDateController.text,
                  endDateController.text);

              BlocProvider.of<ReadTodoListCubit>(context).readTodoList();
              Navigator.pop(context);
            }
          },
          child: const Text(
            StringConstants.createNow,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 16, color: Color(0xFFa7a7a7), fontWeight: FontWeight.bold),
    );
  }
}
