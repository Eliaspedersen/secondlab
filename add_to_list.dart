import 'package:flutter/material.dart';

class TodoAdd extends StatefulWidget {
  const TodoAdd({super.key});

  @override
  State<TodoAdd> createState() => _TodoAddState();
}

class _TodoAddState extends State<TodoAdd> {
  // 1. Controller to manage the text field input
  final TextEditingController _controller = TextEditingController();

  // Function to send the task back to TodoHome
  void _submitTask() {
    final String newTask = _controller.text.trim();
    
    if (newTask.isNotEmpty) {
      // 2. Send the string back and close the screen
      Navigator.pop(context, newTask); 
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text('CLS055 TODO'),
      ),
      body: Padding(
        // 3. Use standard EdgeInsets.symmetric and corrected the class name
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26), 
        child: Column(
          children: [
            TextField(
              controller: _controller, // 4. Assign the controller
              autofocus: true,        // Optional: Open keyboard immediately
              onSubmitted: (_) => _submitTask(), // Allows submission via keyboard 'done' button
              decoration: InputDecoration(
                hintText: 'What are you going to do?',
                border: OutlineInputBorder(
                  // 5. Standard border appearance
                  borderRadius: BorderRadius.circular(8), 
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 1.0, // Reduced thickness to 1.0
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Spacing
            ElevatedButton.icon(
              onPressed: _submitTask, // 6. Call the submit function
              icon: const Icon(Icons.add),
              label: const Text('ADD'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(100, 40),
                foregroundColor: Colors.amberAccent,
                backgroundColor: Colors.grey
              ),
            ),
          ],
        ),
      ),
    );
  }
}