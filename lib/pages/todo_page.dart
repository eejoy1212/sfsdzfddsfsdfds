import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_provider/models/todo_model.dart';
import 'package:to_do_provider/providers/active_todo_count.dart';
import 'package:to_do_provider/providers/providers.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TODO'),
          actions: const [
            TodoHeader(),
            SizedBox(
              width: 30,
            ),
          ],
        ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 40,
              ),
              child: Column(
                children: const [
                  CreateTodo(),
                  SizedBox(
                    height: 20.0,
                  ),
                  SearchAndFilterTodo(),
                  ShowTodos(),
                ],
              )),
        ),
      ),
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
      decoration: const InputDecoration(
        labelText: 'What to do?',
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
    return Column(
      children: [
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
          ? 'All'
          : filter == Filter.active
              ? 'Active'
              : 'Completed',
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
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemCount: todos.length,
      itemBuilder: (BuildContext context, int index) {
        return Text(todos[index].desc);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
