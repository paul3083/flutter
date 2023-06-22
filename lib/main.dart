import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoApp(),
    );
  }
}

class Todo {
  final String title;
  final String description;

  Todo({required this.title, required this.description});
}

class TodoApp extends StatefulWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  String title = "";
  String description = "";

  List<Todo> todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text('나의 할일'),
                actions: [
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        title = value;
                      });
                    },
                    decoration: const InputDecoration(hintText: "글 제목"),
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        description = value;
                      });
                    },
                    decoration: const InputDecoration(hintText: "글 내용"),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          todos.add(Todo(
                            title: title,
                            description: description,
                          ));
                        });
                      },
                      child: const Text(" 추가하기"),
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemBuilder: (_, index) {
          return Dismissible(
            key: Key(index.toString()),
            onDismissed: (direction) {
              setState(() {
                todos.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("삭제되었습니다.")),
              );
            },
            child: ListTile(
              title: Text(todos[index].title),
              subtitle: Text(todos[index].description),
            ),
          );
        },
        itemCount: todos.length,
      ),
    );
  }
}
