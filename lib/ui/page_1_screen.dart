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
      body: BlocBuilder<ReadTodoListCubit, ReadTodoListState>(
        builder: (context, state) {
          if (state is ReadTodoListSuccess) {
            //Create a to-do list if successfully obtain data from the database.
            return ListView.separated(
                itemCount: state.todoList.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      //navigate to second screen with argument
                      // {
                      //         "title" : state.todoList[index].todoTitle,
                      //         "start_date" : state.todoList[index].startDate,
                      //         "end_date" : state.todoList[index].endDate,
                      //       }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Page2Screen(
                                  args: {
                                    "title": state.todoList[index].todoTitle,
                                    "start_date":
                                        state.todoList[index].startDate,
                                    "end_date": state.todoList[index].endDate,
                                  },
                                )),
                      );
                    },
                    child: Container(
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 3,
                            blurRadius: 8,
                            offset: const Offset(
                              0,
                              3,
                            ),
                          ),
                        ],
                      ),
                      height: 150,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.todoList[index].todoTitle,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    buildTimeInformation(
                                      content: state.todoList[index].startDate
                                          .toString(),
                                      title: "Start Date",
                                    ),
                                    buildTimeInformation(
                                      content: state.todoList[index].endDate
                                          .toString(),
                                      title: "End Date",
                                    ),
                                    const buildTimeInformation(
                                        title: "Time Left",
                                        content: "23 hrs 22 min")
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Container(
                            height: 35,
                            width: double.infinity,
                            padding: EdgeInsets.only(left: 20, right: 10),
                            decoration: const BoxDecoration(
                              color: Color(0xFFe7e3cf),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            child: Row(
                              children: [
                                const Text(StringConstants.status),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Incompleted"),
                                Spacer(),
                                Text(StringConstants.tickIfComplete),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.check_box_outline_blank_sharp,
                                  size: 15,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          }

          return Container();
        },
      ),
      //build the center floating button
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

//build the reuse widget for the time section
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
