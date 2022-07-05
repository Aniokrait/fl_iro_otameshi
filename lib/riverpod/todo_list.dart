import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'todo.dart';

class TodoListView extends ConsumerWidget {
  TodoListView({Key? key}) : super(key: key);

  void onPressed(Reader read) {
    final inputText = read(inputTextProvider);
    if (read(inputTextProvider).isNotEmpty) {
      read(todosProvider.notifier).addTodo(inputText);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todosProvider);

    final _key = GlobalKey<FormFieldState>();
    final _controller = TextEditingController();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => onPressed(ref.read),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (value) =>
                  ref.read(inputTextProvider.notifier).state = value,
              //               decoration: InputDecoration(
              //                 errorText: _errorText,
              //               ),
            ),
            TextFormField(
              key: _key,
              controller: _controller,
              validator: (String? value) {
                return value!.isEmpty ? "Can't be null" : null;
              },
            ),
            ElevatedButton(
              onPressed: () => onclickTextController_riyobutton(
                  _key, ref.read, _controller, context),
              child: const Text('textController利用 ボタン'),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  for (final todo in todos)
                    CheckboxListTile(
                      value: todo.completed,
                      onChanged: (value) =>
                          ref.read(todosProvider.notifier).toggle(todo.id),
                      title: Text(todo.description),
                    )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => {},
              child: const Text('hoge'),
            ),
          ],
        ),
      ),
    );
  }

  void onclickTextController_riyobutton(GlobalKey<FormFieldState> key,
      Reader read, TextEditingController controller, BuildContext context) {
    if (key.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
      read(todosProvider.notifier).addTodo(controller.text);
    }
  }
}

final todosProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  return TodoNotifier();
});

final inputTextProvider = StateProvider<String>((ref) => '');
