import 'package:flutter/material.dart';
import 'package:todolist/analyze.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const analyze()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String title = "";
  String description = "";

  List<Todo> todos = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Padding(
              padding: EdgeInsets.only(right: 240),
              child: Text(
                "투두프렌즈",
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                ),
              ),
            ),
            leading: const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Icon(
                Icons.messenger_outline,
                color: Colors.lightBlueAccent,
              ),
            ),
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
                        decoration: const InputDecoration(hintText: "할일"),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            description = value;
                          });
                        },
                        decoration: const InputDecoration(hintText: "기간"),
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
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.edit),
                label: 'Edit'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
                label: 'Chart'
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.lightBlueAccent,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
