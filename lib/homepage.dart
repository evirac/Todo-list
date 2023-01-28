import 'taskcard.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final tasks = Task.Tasks();
  final _taskController = TextEditingController();
  List<Task> _searchResults = [];
  @override
  void initState() {
    _searchResults = tasks;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50, bottom: 20),
                        child: const Text(
                          'My taks',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 30),
                        ),
                      ),
                      for (Task task in _searchResults.reversed)
                        TaskCard(
                          mytask: task,
                          onTaskToggle: _toggleTask,
                          onDelete: _deleteTask,
                        )
                    ],
                  ),
                )
              ]),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(children: [
                Expanded(
                    child: Container(
                  margin:
                      const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      boxShadow: [
                        BoxShadow(
                            color:
                                Theme.of(context).colorScheme.tertiaryContainer,
                            blurRadius: 10.0),
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                        hintText: 'Add a task  eg: buy groceries',
                        border: InputBorder.none),
                  ),
                )),
                Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      addTask(_taskController.text);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.tertiaryContainer,
                        minimumSize: const Size(60, 60),
                        elevation: 10),

                    child: Icon(Icons.add,
                        size: 30,
                        color: Theme.of(context)
                            .colorScheme
                            .onTertiaryContainer), // change later to ontertiary
                  ),
                ),
              ]),
            )
          ],
        ));
  }

  void _toggleTask(Task task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
    });
  }

  void _deleteTask(int id) {
    setState(() {
      tasks.removeWhere((element) => element.id == id);
    });
  }

  void addTask(String task) {
    setState(() {
      tasks.add(Task(id: DateTime.now().second.toInt(), taskText: task));
    });
    _taskController.clear();
  }

  void _runFilter(String keyword) {
    List<Task> results = [];
    if (keyword.isEmpty) {
      results = tasks;
    } else {
      results = tasks
          .where((element) =>
              element.taskText.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _searchResults = results;
    });
  }

  Container searchBox() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.secondaryContainer),
              child: TextField(
                onChanged: (value) => _runFilter(value),
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    prefixIcon: Icon(Icons.search),
                    prefixIconConstraints:
                        BoxConstraints(maxHeight: 20, maxWidth: 25),
                    border: InputBorder.none,
                    hintText: 'Search'),
              ),
            )
          ],
        ));
  }
}
