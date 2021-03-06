import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:to_do_provider/ctrl/home_ctrl.dart';
import 'package:to_do_provider/pages/todo_page.dart';
import 'package:to_do_provider/providers/active_todo_count.dart';
import 'package:to_do_provider/providers/filtered_todos.dart';
import 'package:to_do_provider/providers/theme_ctrl.dart';
import 'package:to_do_provider/providers/theme_setting.dart';
import 'package:to_do_provider/providers/todo_filter.dart';
import 'package:to_do_provider/providers/todo_list.dart';
import 'package:to_do_provider/providers/todo_search.dart';

void main() {
  Get.put(ThemeSettingCtrl());
  Get.put(HomeCtrl());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMaterialChanged = false;
    if (isMaterialChanged != Get.find<ThemeSettingCtrl>().isChanged.value) {
      isMaterialChanged = Get.find<ThemeSettingCtrl>().isChanged.value;
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeSettingProvider>(
          create: (context) => ThemeSettingProvider(),
        ),
        ChangeNotifierProvider<TodoFilter>(
          create: (context) => TodoFilter(),
        ),
        ChangeNotifierProvider<TodoSearch>(
          create: (context) => TodoSearch(),
        ),
        ChangeNotifierProvider<TodoList>(
          create: (context) => TodoList(),
        ),
        ChangeNotifierProxyProvider<TodoList, ActiveTodoCount>(
          create: (context) => ActiveTodoCount(),
          update: (
            BuildContext context,
            TodoList todoList,
            ActiveTodoCount? activeTodoCount,
          ) =>
              activeTodoCount!..update(todoList),
        ),
        ChangeNotifierProxyProvider3<TodoFilter, TodoSearch, TodoList,
            FilteredTodos>(
          create: (context) => FilteredTodos(),
          update: (context, TodoFilter todoFilter, TodoSearch todoSearch,
                  TodoList todoList, FilteredTodos? filteredTodos) =>
              filteredTodos!..update(todoFilter, todoSearch, todoList),
        )
      ],
      child: MaterialApp(
        title: 'TODOS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(

            // appBarTheme: const AppBarTheme(
            //     backgroundColor: Colors.transparent,
            //     elevation: 0,
            //     iconTheme: IconThemeData(
            //       color: Colors.black,
            //     ),
            //     titleTextStyle: TextStyle(
            //       color: Colors.black,
            //       fontSize: 20,
            //       fontWeight: FontWeight.bold,
            //     )),
            // primarySwatch: Colors.blue,
            ),
        darkTheme: ThemeData.dark().copyWith(
          appBarTheme: AppBarTheme(
            color: Colors.transparent,
            elevation: 0,
          ),
          scaffoldBackgroundColor: const Color(0xFF15202B),
        ),
        themeMode: isMaterialChanged == true ? ThemeMode.light : ThemeMode.dark,
        home: TodosPage(),
      ),
    );
  }
}
