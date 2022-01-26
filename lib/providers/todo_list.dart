import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:to_do_provider/models/todo_model.dart';

class TodoListState extends Equatable {
  final List<Todo> todos;

  TodoListState({
    required this.todos,
  });

  factory TodoListState.initial() {
    return TodoListState(todos: [
      Todo(id: '1', desc: '방 치우기'),
      Todo(id: '2', desc: '갱얼지 밥주기'),
      Todo(id: '3', desc: '밥먹기'),
    ]);
  }

  @override
  List<Object?> get props => [todos];

  @override
  bool get stringify => true;

  TodoListState copyWith({
    List<Todo>? todos,
  }) {
    return TodoListState(
      todos: todos ?? this.todos,
    );
  }
}

class TodoList with ChangeNotifier {
  TodoListState _state = TodoListState.initial();
  TodoListState get state => _state;
//새 투두리스트 추가
//...이 뭐지???
  void addTodo(String todoDesc) {
    final newTodo = Todo(desc: todoDesc);
    final newTodos = [..._state.todos, newTodo];
    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }

  void editTodo(String id, String todoDesc) {
    final newTodos = _state.todos.map((Todo todo) {
      if (todo.id == id) {
        return Todo(
          id: id,
          desc: todoDesc,
          completed: todo.completed,
        );
      }
      return todo;
    }).toList();
    //새로운 투두 state를 넣어주고 notifyListeners로 알려준다.
    _state = _state.copyWith(todos: newTodos);
    notifyListeners();  
  }

  void toggleTodo(String id) {
    final newTodos = _state.todos.map((Todo todo) {
      if (todo.id == id) {
        return Todo(
          id: id,
          desc: todo.desc,
          completed: !todo.completed,
        );
      }
      return todo;
    }).toList();

    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }

  void removeTodo(Todo todo) {
    final newTodos =
        _state.todos.where((Todo todo) => todo.id != todo.id).toList();
    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }
}
