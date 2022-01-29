import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:to_do_provider/ctrl/home_ctrl.dart';
import 'package:to_do_provider/ctrl/mode.dart';
import 'package:to_do_provider/models/todo_model.dart';
import 'package:to_do_provider/providers/providers.dart';
import 'package:to_do_provider/providers/theme_ctrl.dart';
import 'package:toggle_switch/toggle_switch.dart';

class TodosPage extends StatelessWidget {
  TodosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> profileList = ['계정 관리', '공지사항', '문의하기'];

    return GetMaterialApp(
      title: 'TODOS',
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      home: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              actions: [
                // TodoHeader(),
                GestureDetector(
                  onTap: () {
                    // ThemeService().switchTheme();
                  },
                  child:

                      // Icon(
                      //   Get.isDarkMode
                      //       ? Icons.toggle_on_outlined
                      //       : Icons.toggle_off_outlined,
                      // ),
                      Padding(
                    padding: const EdgeInsets.all(20),
                    child: ToggleSwitch(
                      minWidth: 40,
                      minHeight: 2,
                      initialLabelIndex: 0,
                      cornerRadius: 20.0,
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      totalSwitches: 2,
                      fontSize: 8,
                      labels: ['Light', 'Dark'],
                      activeBgColors: [
                        [Colors.blue],
                        [Colors.deepPurple]
                      ],
                      onToggle: (index) {
                        print('switched to: $index');
                        // index == 0 ? null : ThemeMode.dark;
                        ThemeService().switchTheme(index!);
                      },
                    ),
                  ),
                ),

                const SizedBox(
                  width: 30,
                ),
              ],
              title: const Text('TODO'),
            ),
            bottomNavigationBar: Obx(() {
              return SalomonBottomBar(
                key: Get.find<HomeCtrl>().bottomNavKey,
                currentIndex: Get.find<HomeCtrl>().currentIndex.value,
                onTap: (v) {
                  debugPrint(
                      '현재 네비바 인덱스 : ${Get.find<HomeCtrl>().currentIndex.value}');
                  Get.find<HomeCtrl>().currentIndex.value = v;
                  Get.find<HomeCtrl>().pageCtrl.jumpToPage(v);
                },
                items: [
                  SalomonBottomBarItem(
                    icon: const Icon(Icons.home),
                    title: const Text("홈"),
                    selectedColor: Colors.purple,
                  ),

                  /// Search
                  SalomonBottomBarItem(
                    icon: const Icon(Icons.settings),
                    title: const Text("설정"),
                    selectedColor: Colors.orange,
                  ),

                  /// Profile
                  SalomonBottomBarItem(
                    icon: const Icon(Icons.person),
                    title: const Text("마이페이지"),
                    selectedColor: Colors.teal,
                  ),
                ],
              );
            }),
            body: PageView(
              children: [
                //Home
                SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 40,
                      ),
                      child: Column(
                        children: const [
                          DatePickTimeLine(),
                          CreateTodo(),
                          SizedBox(
                            height: 20.0,
                          ),
                          //월별 주별 일별 리스트 보기

                          SearchAndFilterTodo(),
                          ShowTodos(),
                        ],
                      )),
                ),
                Container(
                    child: Center(
                  child: Text('설정'),
                )),
                //프로필
                ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(profileList[index]),
                        trailing: IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return AccountManagePg();
                                },
                              ));
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                            )),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const Divider(color: Colors.black),
                    itemCount: profileList.length)
              ],
              controller: Get.find<HomeCtrl>().pageCtrl,
            )),
      ),
    );
  }
}

// class ShowMethod extends StatelessWidget {
//   const ShowMethod({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return CoolDropdown(dropdownList: [], onChange: () {});
//   }
// }

class AccountManagePg extends StatelessWidget {
  const AccountManagePg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

// class ThemeSetting extends StatelessWidget {
//   ThemeSetting({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return DayNightSwitcherIcon(
//         isDarkModeEnabled: Get.find<ThemeSettingCtrl>().isChanged.value,
//         onStateChanged: (isDarkModeEnabled) {
//           Get.find<ThemeSettingCtrl>().isChanged.value = isDarkModeEnabled;
//           isDark = Get.find<ThemeSettingCtrl>().isChanged.value;
//         },
//       );
//     });
//   }

// void onStateChanged(bool isDarkModeEnabled) {
//   setState(() {
//     isMaterialChanged = isDarkModeEnabled;
//   });
// }
// }

class DatePickTimeLine extends StatelessWidget {
  const DatePickTimeLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DatePicker(
      DateTime.now(),
    );
  }
}

class TodoHeader extends StatelessWidget {
  const TodoHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${context.watch<ActiveTodoCount>().state.activeTodoCount} items left',
          style: const TextStyle(
            fontSize: 20,
            color: Colors.redAccent,
          ),
        )
      ],
    );
  }
}

class CreateTodo extends StatefulWidget {
  const CreateTodo({Key? key}) : super(key: key);

  @override
  _CreateTodoState createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  final newTodoCtrl = TextEditingController();

  @override
  void dispose() {
    newTodoCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: newTodoCtrl,
      decoration: InputDecoration(
        icon: IconButton(
          onPressed: () {},
          icon: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {},
          ),
        ),
        hintText: '할 일 추가',
      ),
      onSubmitted: (String? todoDescVal) {
        if (todoDescVal != null && todoDescVal.trim().isNotEmpty) {
          context.read<TodoList>().addTodo(todoDescVal);
          newTodoCtrl.clear();
        }
      },
    );
  }
}

class SearchAndFilterTodo extends StatelessWidget {
  const SearchAndFilterTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dropdownVal = Get.find<HomeCtrl>().dropdownList.first;
    return Column(
      children: [
        Row(
          children: [
            CoolDropdown(
              placeholder: dropdownVal,
              resultWidth: 100,
              resultHeight: 30,
              dropdownHeight: 60,
              resultPadding: EdgeInsets.all(0),
              gap: 0,
              dropdownList: [],
              isDropdownLabel: true,
              onChange: () {},
              isTriangle: false,
            ),
            // DropdownButton(
            //   items: Get.find<HomeCtrl>()
            //       .dropdownList
            //       .map<DropdownMenuItem<String>>((String value) {
            //     return DropdownMenuItem<String>(
            //       value: dropdownVal,
            //       child: Text(
            //         value,
            //         style: TextStyle(color: Colors.black),
            //       ),
            //     );
            //   }).toList(),
            //   onChanged: (value) {
            //     debugPrint('dropdown value : $value');
            //     dropdownVal = value.toString();
            //   },
            // )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          decoration: const InputDecoration(
            labelText: 'Search to do',
            border: InputBorder.none,
            filled: true,
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (String? newSearchTermVal) {
            if (newSearchTermVal != null) {
              context.read<TodoSearch>().setSearchTerm(newSearchTermVal);
            }
          },
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            filterBtn(context, Filter.all),
            filterBtn(context, Filter.active),
            filterBtn(context, Filter.completed),
          ],
        )
      ],
    );
  }
}

Widget filterBtn(BuildContext context, Filter filter) {
  return TextButton(
    onPressed: () {
      context.read<TodoFilter>().changeFilter(filter);
    },
    child: Text(
      filter == Filter.all
          ? '전체'
          : filter == Filter.active
              ? '할 것'
              : '완료된 할 일',
      style: TextStyle(fontSize: 18.0, color: textColor(context, filter)),
    ),
  );
}

Color textColor(BuildContext context, Filter filter) {
  final currentFilter = context.watch<TodoFilter>().state.filter;
  return currentFilter == filter ? Colors.blue : Colors.grey;
}

class ShowTodos extends StatelessWidget {
  const ShowTodos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodos>().state.filteredTodos;
    Widget showBackground(int direction) {
      return Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        color: Colors.red,
        alignment:
            direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          size: 30,
          color: Colors.white,
        ),
      );
    }

    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemCount: todos.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: ValueKey(todos[index].id),
          child: TodoItem(todo: todos[index]),
          background: showBackground(0),
          secondaryBackground: showBackground(1),
          onDismissed: (_) {
            context.read<TodoList>().removeTodo(todos[index]);
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        color: Colors.black,
      ),
    );
  }
}

class TodoItem extends StatefulWidget {
  final Todo todo;
  const TodoItem({Key? key, required this.todo}) : super(key: key);

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        onChanged: (bool? isChecked) {
          context.read<TodoList>().toggleTodo(widget.todo.id);
        },
        value: widget.todo.completed,
      ),
      title: Text(widget.todo.desc),
    );
  }
}
