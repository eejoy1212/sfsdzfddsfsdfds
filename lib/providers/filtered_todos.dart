import 'package:flutter/cupertino.dart';
import 'package:to_do_provider/models/todo_model.dart';

class FilteredTodosState {
  final List<Todo> filteredTodos;

  FilteredTodosState({
    required this.filteredTodos,
  });

  factory FilteredTodosState.initial() {
    return FilteredTodosState(filteredTodos: []);
  }

  @override
  List<Object> get props => [filteredTodos];

  @override
  bool get stringify => true;

  FilteredTodosState copyWith({
    List<Todo>? filteredTodos,
  }) {
    return FilteredTodosState(
      filteredTodos: filteredTodos ?? this.filteredTodos,
    );
  }
}

class FilteredTodos with ChangeNotifier {
  FilteredTodosState _state = FilteredTodosState.initial();
  FilteredTodosState get state => _state;
  
}
