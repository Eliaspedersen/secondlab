import 'package:flutter/material.dart';
import 'list.dart';
import 'add_to_list.dart';

void main() {
  runApp(const MyApp()); 
}

const kTodoHome = '/';
const kTodoAdd = '/second'; 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: kTodoHome,
      routes: {
        kTodoHome: (context) => const TodoHome(), // Add const to the constructor call
        kTodoAdd: (context) => const TodoAdd(),   // Add const to the constructor call
      },
    );
  }
}

class TodoHome extends StatefulWidget {
  const TodoHome({super.key});

  @override
  State<TodoHome> createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome> {
  final List<String> _todoItems = [
    'Write a book',
    'Do homework', 
    'Tidy room',
    'Watch TV',
    'Nap',
    'Shop Groceries',
    'Have fun',
    'Meditate'
  ];

  void _removeTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  // 2. Asynchronous function to handle navigation and result
  void _navigateToAddTodoScreen() async {
    // 3. Navigate and AWAIT the result (the string returned by Navigator.pop)
    // We use 'as String?' to correctly cast the result.
    final String? newTask = await Navigator.pushNamed(context, kTodoAdd) as String?;

    // The screen only shifts back to TodoHome AFTER Navigator.pop is called in TodoAdd.

    // 4. Check if a valid string was returned
    if (newTask != null && newTask.isNotEmpty) {
      setState(() {
        _todoItems.add(newTask); // 5. Add the new task to the list
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
        title: const Text('CLS055 TODO'),
        actions:[
          PopupMenuButton (
            icon: const Icon(Icons.more_vert),
            onSelected: (String result){

            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
              value: 'all',
              child: Text('all'),
            ),
            const PopupMenuItem<String>(
              value: 'done',
              child: Text('done'),
            ),
            const PopupMenuItem<String>(
              value: 'undone',
              child: Text('undone'),
            ),
            ]
          )
        ],
      ),
      body: InteractiveList(
        items: _todoItems,
        onRemove: _removeTodoItem,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddTodoScreen, 
        foregroundColor: Colors.amberAccent,
        backgroundColor: Colors.grey,
        child: const Icon(Icons.add),
      ),
    );
  }
}