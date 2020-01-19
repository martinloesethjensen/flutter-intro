summary: Introduction to Mobile App Development with Flutter
id: flutter-introduction-workshop
categories: Flutter, Mobile App Development
tags: Flutter
status: Draft
authors: Martin Løseth Jensen
Feedback Link: https://github.com/martinloesethjensen/flutter-intro/issues/new

# Introduction to Mobile App Development with Flutter

## Overview

With this codelab, you'll get a basic understanding of how Flutter works. You'll know just how easy it can be to do prototyping with Flutter. 

We'll have a look at the programming language used with Flutter - Dart.  
Then we will start creating a simple todo app with very little functionality. 

You'll find the completed code files at the end of this codelab.

## Prerequsits

Before getting started, you need to have Flutter, and a supported IDE installed. 

Head over to Flutters [getting started page](https://flutter.dev/docs/get-started/install), to install the necessary things needed for this codelab.

Link to my slides can be found [here](https://docs.google.com/presentation/d/1109B3fQyqNO5zVxh4j4mRO9A9I-5KumPpqgcd6xDKOA/edit?usp=sharing).

When you have installed Flutter and your prefered IDE, then it's time to start. 

## Trying out Dart

[Dartpad](https://dartpad.dartlang.org/) is a great way to learning the basics of dart and testing out Dart code on the browser.

Along with the Flutter 1.12 release in December 11th 2019, dartpad now supports Flutter. Try it out here: [Counter Example](https://dartpad.dev/b6409e10de32b280b8938aa75364fa7b).

**Simple Dart Sample:**

```dart
class Person {
  String name = 'John Doe';  // string variable
  int age = 30;  // integer variable
}

// Method the takes in two double parameters and return a double
double addNumbers(double num1, double num2) { return num1 + num2; }

void main() {
  
  // For each loop with index
  for (int i = 1; i <= 5; i++) {
    print('hello $i');
  }
  
  var p1 = Person();  // creating an object of class 'Persion' and assigning it to a variable
  var p2 = Person();
  p2.name = 'John Johnson';  // setting the name of the person object
  
  print(p1.name);  // get the name of the person object and prints out the value
  print(p2.name);
  
  double addNumberResult = addNumbers(2,3);  // calling a method that return a double and puts that value into the variable
  print(addNumberResult);
}
```

## Create and run the project

Run this command to check that everything is good with flutter.

```bash
flutter doctor
```

When ready then it is time to create a flutter project. You can easily create one through the commandline with this command.

```bash
flutter create todo_app
```

Now try and run the app.

```bash
cd todo_app
flutter run
```

I have made a file where you can see some useful commands: [Useful Terminal Commands](https://gist.github.com/martinloesethjensen/8b53ec97834aaea2622d57ec94d3fb5e#file-flutter-commands-md)

## Getting Started 

For that we need a `task_list`
create a folder model
To start with lets create a model name it task.dart

```dart
class Task {
  String name, details;
  bool completed = false;

  static List<Task> _tasks = [ // The _ in the variable name makes it private.
    Task('Choose topic', 'testing desc'),
    Task('Drink coffee', null),
    Task('Prepare codelab', null),
    Task('Update SDK', 'Flutter'),
  ];

  static List<Task> get tasks => _tasks;

  Task(this.name, this.details);  // Constructor with parameters for creating a Task object
}
```

Lets delete every thing in `main.dart`
`main.dart` is the starting point
Talk about the main function -> is the entry point

```dart
import 'package:flutter/material.dart';
import 'task_list_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: TaskListView(),
    );
  }
}
```

So the home points to `TaskListView`, lets create a `task_list_view.dart`

Talk about scaffold

```dart
import 'package:flutter/material.dart';

import 'model/task.dart';

class TaskListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: ListView(
        children: <Widget>[
          for (final task in Task.tasks)
            ListTile(
              leading: IconButton(
                icon: (task.completed)
                    ? Icon(Icons.check_circle)
                    : Icon(Icons.radio_button_unchecked),
                onPressed: null,
              ),
              title: Text(task.name),
              subtitle: (task.details != null) ? Text(task.details) : null,
            ),
        ],
      ),
    );
  }
}
```

We are using a for loop so modify `pubspec.yaml`

```yaml
sdk: ">=2.2.2 <3.0.0"
```


Talk about hotreload, and restart 

Now you got the checkbox, lets see if we can reflect these toggle in code
Talk about stateful vs stateless widgets

In `task_list_view.dart`

Change `onPressed: () => toggleTask(task),`

Change the class  extend to StatefulWidget

```dart
@override
  _TaskListViewState createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  void toggleTask(Task task) {
    setState(() {
      task.completed = !task.completed;
    });
  }
  
  ...
  
}
 ```

------------------------  thats pretty easy and awesome check if its break time-----------------


This looks like a long list would be nice if we can seperate our list to the ones completed different 

We extract the list in its own list tile widget 

```dart
Widget _listTile(Task task) {
    return ListTile(
      leading: IconButton(
        icon: (task.completed)
            ? Icon(Icons.check_circle)
            : Icon(Icons.radio_button_unchecked),
        onPressed: () => toggleTask(task),
      ),
      title: Text(task.name),
      subtitle: (task.details != null) ? Text(task.details) : null,
    );
  }
```


`for (final task in Task.tasks) _listTile(task),


Lets modify the model "model.dart" and add method to ... Not the best practice, les make it work.

```dart
static List<Task> get currentTasks =>
      _tasks.where((task) => !task.completed).toList();

static List<Task> get completedTasks =>
      _tasks.where((task) => task.completed).toList();
```


Now we seperate the current task and completed tasks in the list view

```dart
for (final task in Task.currentTasks) _listTile(task),
for (final task in Task.currentTasks) _listTile(task),
          Divider(),
          ExpansionTile(
            key: _completedKey,
            title: Text('Completed (${Task.completedTasks.length})'),
            children: <Widget>[
              for (final task in Task.completedTasks) _listTile(task),
            ],
          )
        ],
```

under class _TaskListViewState extends State<TaskListView> {
```dart
  final GlobalKey<State> _completedKey = GlobalKey<State>();
```

---------------- So we would like to add some tasks to the list --------------
Lets create a new dart file `add_task_dialog.dart` -> stateful widget, I will copy some code and explain as i go along.....

```dart
import 'package:flutter/material.dart';

import 'model.dart';

class AddTaskDialog extends StatefulWidget {
  @override
  _TaskDialogState createState() => _TaskDialogState();
}

class _TaskDialogState extends State<AddTaskDialog> {
  String _taskName = '';
  String _taskDetails;

  void _save() {
    final task = _taskName.isNotEmpty ? Task(_taskName, _taskDetails) : null;
    Navigator.of(context).pop(task);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('New Task'),
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              alignment: Alignment.bottomLeft,
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                  filled: true,
                ),
                style: theme.textTheme.headline,
                onChanged: (value) => _taskName = value,
                autofocus: true,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              alignment: Alignment.bottomLeft,
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Details',
                  filled: true,
                ),
                onChanged: (value) => _taskDetails = value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

We modify our `task_list` add a floating action button

```dart
floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
      ),

void _addTask() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDialog(),
        fullscreenDialog: true,
      ),
    );
  }
```

Lets also change `toggleTask` to be private for consistency `_toggleTask`

We can navigate from tasklist to add task dialog, finally lets add a button to save.

```dart
actions: <Widget>[
          FlatButton(
            child: Text(
              'SAVE',
              style: theme.textTheme.body1.copyWith(color: Colors.white),
            ),
            onPressed: _save,
          ),
        ],
      ),
```

When save returns we have to wait for the dialog as it returns task. So lets change the _add task to async and save it to the list

```dart
void _addTask() async {
    final task = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDialog(),
        fullscreenDialog: true,
      ),
    );

    if (task != null) {
      setState(() {
        Task.tasks.add(task);
      });
    }
  }
```
--------- finally if we have time lets look at theming and delete

In `main.dart`
We see `theme:` , lets add the dark theme

```dart
theme: ThemeData.dark(),
```

--------
Delete task -> we can play with platform specific dialogs here

Lets add an trailing ICON

```dart
subtitle: (task.details != null) ? Text(task.details) : null,
      trailing: IconButton(
        icon: Icon(Icons.delete_forever),
        onPressed: () => _deleteTask(task),
      ),
```

```dart
import 'dart:io';

import 'package:flutter/cupertino.dart';

void _deleteTask(Task task) async {
    final confirmed = (Platform.isIOS)
        ? await showCupertinoDialog<bool>(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: const Text('Delete Task?'),
              content: const Text('This task will be permanently deleted.'),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: const Text('Delete'),
                  isDestructiveAction: true,
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
                CupertinoDialogAction(
                  child: const Text('Cancel'),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ],
            ),
          )
        : await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Delete Task?'),
              content: const Text('This task will be permanently deleted.'),
              actions: <Widget>[
                FlatButton(
                  child: const Text("CANCEL"),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                FlatButton(
                  child: const Text("DELETE"),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            ),
          );

    if (confirmed ?? false) {
      setState(() {
        Task.tasks.remove(task);
      });
    }
  }
```


For consistency lets change floating button to:

```dart
floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addTask,
      ),
```
