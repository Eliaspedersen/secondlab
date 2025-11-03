import 'package:flutter/material.dart';


// Main list widget, blueprint
class InteractiveList extends StatefulWidget{
  final List<String> items;

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
        final String itemLabel = widget.items[index];
        return Item(
          key: ValueKey(itemLabel),
          label: itemLabel,
          onRemove: () => widget.onRemove(index),
        );
      }
    );
  }


}

class Item extends StatefulWidget{
  final String label;

  final VoidCallback onRemove;

  const Item({
    super.key, 
    required this.label,
    required this.onRemove
    });

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  bool _isChecked = false;


  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.only(top: 1),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 228, 228, 228),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10.0), // Adjust padding
        // Leading is the Checkbox
        leading: Checkbox(
          checkColor: Colors.amberAccent,
          activeColor: Colors.grey,
          value: _isChecked, 
          onChanged: (bool? newValue){
            setState(() {
              _isChecked = newValue ?? false;
            });
          }
        ),
        title: Text(
          widget.label,
          style: TextStyle(
            decoration: _isChecked ? TextDecoration.lineThrough : null,
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
