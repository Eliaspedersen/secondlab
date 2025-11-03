// lib/todo_provider.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http; // New: Import HTTP
import 'todo.dart'; // New: Import the Todo model

class TodoProvider extends ChangeNotifier {
  static const String _baseUrl = 'https://todoapp-api.k8s.gu.se';
  static const String _apiKeyKey = 'todoAppApiKey';

  // Changed from List<String> to List<Todo>
  List<Todo> _todoItems = []; 
  
  String? _apiKey;

  List<Todo> get todoItems => _todoItems; 
  String? get apiKey => _apiKey;
  bool get hasApiKey => _apiKey != null && _apiKey!.isNotEmpty;

  // --- API Key Persistence Methods ---

  Future<void> loadApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    _apiKey = prefs.getString(_apiKeyKey);
    // After loading the key, immediately fetch todos if key is present
    if (hasApiKey) {
      await fetchTodos();
    }
  }

  Future<void> saveApiKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_apiKeyKey, key);
    _apiKey = key;
    notifyListeners(); 
    // After saving, fetch the list associated with the new key
    await fetchTodos();
  }

  // --- API Methods (The core of Phase 2) ---

  // 1. GET /todos?key=[YOUR API KEY] - Fetch all Todos
  Future<void> fetchTodos() async {
    if (!hasApiKey) return; // Cannot fetch without a key

    try {
      final response = await http.get(Uri.parse('$_baseUrl/todos?key=$_apiKey'));

      if (response.statusCode == 200) {
        // Decode the JSON response (which is a list of todo maps)
        final List<dynamic> jsonList = jsonDecode(response.body);
        
        // Convert the list of JSON maps to a List<Todo>
        _todoItems = jsonList.map((json) => Todo.fromJson(json)).toList();
        
        notifyListeners(); // Tell widgets to rebuild with new data
      } else {
        // Handle error status codes
        debugPrint('Failed to load todos. Status code: ${response.statusCode}');
        // Optionally, show a message to the user
      }
    } catch (e) {
      // Handle network errors
      debugPrint('Network error during fetchTodos: $e');
    }
  }

  // 2. POST /todos?key=[YOUR API KEY] - Add a new Todo
  Future<void> addTodoItem(String title) async {
    if (!hasApiKey) return;
    
    // Create the body payload (title and done=false)
    final body = jsonEncode({'title': title, 'done': false});

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/todos?key=$_apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        // API returns the entire updated list on success (just like GET)
        final List<dynamic> jsonList = jsonDecode(response.body);
        _todoItems = jsonList.map((json) => Todo.fromJson(json)).toList();
        notifyListeners();
      } else {
        debugPrint('Failed to add todo. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Network error during addTodoItem: $e');
    }
  }

  // NOTE: You will still need to implement the PUT (toggle/update) and DELETE (remove) methods next.
  
  // --- List Methods (Update to use the API calls) ---
  

  void removeTodoItem(int index) {
    if (index >= 0 && index < _todoItems.length) {
      // In a real app, you would call the DELETE API method here
      // Example: deleteTodoItem(_todoItems[index].id);
      
      // For now, let's keep the internal remove until we implement DELETE
      _todoItems.removeAt(index);
      notifyListeners();
    }
  }
}