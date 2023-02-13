import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maybank_assessment/constants/app_colors.dart';
import 'package:flutter_maybank_assessment/constants/string_constants.dart';
import 'package:flutter_maybank_assessment/cubit/read_todo_list/read_todo_list_cubit.dart';
import 'package:flutter_maybank_assessment/ui/ui.dart';

import '../utils/custom_app_bar.dart';

class Page1Screen extends StatefulWidget {
  const Page1Screen({super.key});

  static const routeName = "page-1-screen";

  @override
  State<Page1Screen> createState() => _Page1ScreenState();
}

class _Page1ScreenState extends State<Page1Screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ReadTodoListCubit>(context).readTodoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyColor,
      appBar: const CustomAppBar(
        title: StringConstants.todolist,
        // leading: null,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 7,
              blurRadius: 12,
              offset: const Offset(
                0,
                -1,
              ),
            ),
          ],
        ),
        height: 150,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Automated Testing Script",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTimeInformation(
                  content: "2021-11-20",
                  title: "Start Date",
                ),
                buildTimeInformation(
                  content: "2021-11-20",
                  title: "End Date",
                ),
                buildTimeInformation(
                    title: "Time Left", content: "23 hrs 22 min")
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Page2Screen.routeName);
        },
        backgroundColor: AppColors.buttonColor,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class buildTimeInformation extends StatelessWidget {
  const buildTimeInformation({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(title), Text(content)],
    );
  }
}
