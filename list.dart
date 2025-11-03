// lib/list.dart

import 'package:flutter/material.dart';
import 'todo.dart'; // <--- NEW: Import the Todo model

// Main list widget, blueprint
class InteractiveList extends StatefulWidget{
  // 1. Change type from List<String> to List<Todo>
  final List<Todo> items; 

  // 2. The onRemove function now accepts the Todo ID (String) instead of the index
  // NOTE: For now, we will use index, but we should change this to ID for API DELETE
  final Function(int index) onRemove; 

  const InteractiveList({
    super.key, 
    required this.items,
    required this.onRemove,
  });

  @override
  State<InteractiveList> createState() => _InteractiveListState();
}


//MAIN LIST STATE (builder)
class _InteractiveListState extends State<InteractiveList>{
  
  @override
  Widget build(BuildContext context){
    return ListView.builder(
      itemCount: widget.items.length,
      itemBuilder: (BuildContext context, int index) {
        // 3. Get the full Todo object
        final Todo todo = widget.items[index]; 

        return Item(
          // 4. Use the Todo ID as the key for better list performance
          key: ValueKey(todo.id), 
          todo: todo, // 5. Pass the whole Todo object
          onRemove: () => widget.onRemove(index),
        );
      }
    );
  }
}

// Item Widget
class Item extends StatefulWidget{
  // 6. Change from String label to Todo object
  final Todo todo; 

  final VoidCallback onRemove;

  const Item({
    super.key, 
    required this.todo, // 7. Require Todo instead of label
    required this.onRemove
    });

  @override
  // NOTE: We don't need a separate state for the checkbox anymore, 
  // since the 'done' status is now managed by the Todo object and the Provider.
  // We will keep the State class for now but update the logic.
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  // 8. Remove _isChecked as it's now in the Todo model

  @override
  Widget build(BuildContext context){
    // NOTE: In a real app, you would use Provider.of<TodoProvider>(context, listen: false) 
    // to call the toggle function here. For now, we just read the data.
    
    return Container(
      margin: const EdgeInsets.only(top: 1),
      decoration: const BoxDecoration( // Add const
        color: Color.fromARGB(255, 228, 228, 228),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
        
        // Leading is the Checkbox
        leading: Checkbox(
          checkColor: Colors.amberAccent,
          activeColor: Colors.grey,
          // 9. Use the 'done' status from the Todo object
          value: widget.todo.done, 
          onChanged: (bool? newValue){
            // 10. You need to implement the API PUT request (toggle status) here.
            // For now, let's keep it simple to fix the error:
            // This will NOT update the Provider/API yet, just show where the logic goes.
            // The next step is to implement the PUT method in TodoProvider.
            
            // Example of what to do next: 
            // Provider.of<TodoProvider>(context, listen: false).toggleTodoStatus(widget.todo.id); 
            setState(() {
              widget.todo.done = newValue ?? false; // This changes local state, not the API/Provider
            });
          }
        ),
        title: Text(
          widget.todo.title, // 11. Use the 'title' property
          style: TextStyle(
            decoration: widget.todo.done ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.close),
          color: Colors.black54,
          onPressed: widget.onRemove,
        ),
      ),
    );
  }
}