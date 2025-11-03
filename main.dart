import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // New Import!
import 'list.dart';
import 'add_to_list.dart';
import 'todo_provider.dart'; // New Import!

const kTodoHome = '/';
const kTodoAdd = '/second';
const kRegistration = '/register';

void main() {
  // 1. Wrap the entire application with the ChangeNotifierProvider
  runApp(
    ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: const MyApp(), 
    )
  ); 
}

// ... (kTodoHome and kTodoAdd constants remain the same)

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: kTodoHome,
      routes: {
        kTodoHome: (context) => const TodoHome(),
        kTodoAdd: (context) => const TodoAdd(),
      },
    );
  }
}

// 2. Refactor TodoHome to be a StatelessWidget 
//    and load the API key on startup.
class TodoHome extends StatelessWidget {
  const TodoHome({super.key});

  // Since we need to run an async operation (loadApiKey), 
  // we'll use a StatefulWidget temporarily or call it in an init state.
  // The simplest way to refactor for now is to move the logic out.
  @override
  Widget build(BuildContext context) {
    // Access the provider instance
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);

    // Load API key once when the widget is built for the first time
    // We call loadApiKey() on every build for simplicity, but it's okay
    // since the key persistence is fast and idempotent.
    todoProvider.loadApiKey(); 

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
        title: const Text('CLS055 TODO'),
        actions:[
          PopupMenuButton (
            icon: const Icon(Icons.more_vert),
            onSelected: (String result){
              // TODO: Logic for filtering will go here
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
      body: Consumer<TodoProvider>( // 3. Use Consumer to listen for changes
        builder: (context, provider, child) {
          // The body rebuilds ONLY when the provider calls notifyListeners()
          return InteractiveList(
            items: provider.todoItems,
            onRemove: provider.removeTodoItem,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Use the provider's navigation handler
        onPressed: () => _navigateToAddTodoScreen(context, todoProvider), 
        foregroundColor: Colors.amberAccent,
        backgroundColor: Colors.grey,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Move the navigation logic out of the State class
void _navigateToAddTodoScreen(BuildContext context, TodoProvider provider) async {
  // Navigate and AWAIT the result (the string returned by Navigator.pop)
  final String? newTask = await Navigator.pushNamed(context, kTodoAdd) as String?;

  // Check if a valid string was returned
  if (newTask != null && newTask.isNotEmpty) {
    // 4. Call the Provider's method to add the task
    provider.addTodoItem(newTask); 
    // The provider handles calling notifyListeners()
  }
}

// NOTE: The original _TodoHomeState class can now be completely removed.
// You should also delete the unused TodoHome state and move the navigation 
// function out of the class.