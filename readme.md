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

Head over to Flutter's [getting started page](https://flutter.dev/docs/get-started/install), to install the necessary things needed for this codelab.

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
double add(double num1, double num2) { return num1 + num2; }

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
  
  double addNumberResult = add(2,3);  // calling a method that return a double and puts that value into the variable
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

First of delete everything in the file `main.dart`. We don't need that code, instead put in this code.

The `main` method is the entry point for the application, so that's where we will run our app.

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp()); // entry point

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(), //TODO: Change to the task list view widget.
    );
  }
}
```

We will change the `home parameter later.

## Task: create Task class

As we are going to create a todo app we need to think about what is needed.
We need a screen with a list of tasks, so let us start of with creating a class called `Task` that has 3 variables: `name`, `details`, and `completed`. Furthermore, we will have to static variables that all Task objects can access.

As this class is what is called a model then let us put this class in a folder we call `models`.
This folder needs to be created in the `lib` folder.

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

## Task: create TaskListView class

We want this widget to be a list that shows all tasks. Let's start by creating a `StatelessWidget` and then update the `home` parameter in `main.dart`.

```dart
import 'package:flutter/material.dart';

class TaskListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: Container(), //TODO: Change this to a ListView
    );
  }
}

```

Now change the `home` parameter to take in the `TaskListView` widget:

```dart
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskListView(),
    );
  }
}

```

## Task: create a ListView of all the tasks

We want to show a list so let us use the `ListView` widget to display several `ListTile` elements depending on the amount of tasks. Each `ListTile` will show an icon, title and subtitle.

Here we have the `ListTile` widget with the task information we want to show:

```dart
...

ListTile(
  leading: IconButton(
    icon: (task.completed)
        ? Icon(Icons.check_circle)
        : Icon(Icons.radio_button_unchecked),
    onPressed: null, // TODO: handle toggling
  ),
  title: Text(task.name),
  subtitle: (task.details != null) ? Text(task.details) : null,
),

...

```

We will be putting this in the `children` parameter of our `ListView` widget.

But to display a `ListTile` for each task in all of our tasks, we need to utilize a for each loop.

We need to modify our `pubspec.yaml` so we can use this for each loop functionality.

```yaml
environment:
  sdk: ">=2.2.0 <3.0.0"
```

We will do it like this so we can iterate through our list of tasks:

```dart
for (final task in Task.tasks)
  ListTile(
    leading: IconButton(
      icon: (task.completed)
          ? Icon(Icons.check_circle)
          : Icon(Icons.radio_button_unchecked),
      onPressed: null, // TODO: handle toggling
    ),
    title: Text(task.name),
    subtitle: (task.details != null) ? Text(task.details) : null,
  ),

```

Now we can put it in our `body` parameter of our `Scaffold` widget. So the code will look like this now:

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

## Task: Make the TaskListView class stateful

Now we have the design of the list, so let us handle the toggling of done and not done state.

First we need to maket the class extend `StatefulWidget` so we can update and redraw the UI on the screen upon state changes.

In our `ListTile` we have an `onPressed` parameter that handles touch events on out icon. We want to change the task's state of completed and to do that we need to use a method called `setState`. This method notifies that there is a change in the state and will then invoke methods to redraw the UI again.

In `task_list_view.dart`:

Change `StatelessWidget` to `StatefulWidget` and have the class setup like this:

```dart
class TaskListView extends StatefulWidget {

  @override
  _TaskListViewState createState() => _TaskListViewState();

}

class _TaskListViewState extends State<TaskListView> {
  
  ...
  
}

 ```

Let us handle the touch event:

```dart
    ...

    onPressed: () => setState(() {
      task.completed = !task.completed;
    }),

    ...

```

## Task: Refactor the code

In the same class we will refactor the code by creating a method that takes in a Task as a parameter and will update its completed state.

```dart
  ...

  void toggleTask(Task task) {
    setState(() {
      task.completed = !task.completed;
    });
  }
  
  ...
  
 ```

Apply the mothod call in the `onPressed` parameter so it will look like this:

```dart
    ...

    onPressed: () => toggleTask(task),

    ...

```

This looks like a long list, but it would be nice if we seperated our list to avoid having a long `build` method.

We will extract the list in to its own list tile widget.

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

Now we can have a better looking code with it being one line and easy to read and understand.

```dart
for (final task in Task.tasks) _listTile(task),
```

## Task: Modify the Task class to have two lists

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

## Completed files

### main.dart

```dart
import 'package:flutter/material.dart';
import 'screens/task_list_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo Demo',
      theme: ThemeData.dark(),
      home: TaskListView(),
    );
  }
}

```

### modules/task.dart

```dart
class Task {
  String name, details;
  bool completed = false;

  static List<Task> _tasks = [
    Task('Choose topic', 'testing desc'),
    Task('Drink coffee', null),
    Task('Prepare codelab', null),
    Task('Update SDK', 'Flutter'),
  ];

  static List<Task> get tasks => _tasks;

  static List<Task> get currentTasks =>
      _tasks.where((task) => !task.completed).toList();

  static List<Task> get completedTasks =>
      _tasks.where((task) => task.completed).toList();

  Task(this.name, this.details);
}

```

### screens/task_list_view.dart

```dart
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_meetup/models/task.dart';

import 'add_task_dialog.dart';

class TaskListView extends StatefulWidget {
  @override
  _TaskListViewState createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  void _toggleTask(Task task) {
    setState(() {
      task.completed = !task.completed;
    });
  }

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

  void _addTask() async {
    final task = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTaskDialog(),
        fullscreenDialog: true,
      ),
    );

    if (task != null) {
      setState(() {
        Task.tasks.add(task);
      });
    }
  }

  Widget _listTile(Task task) {
    return ListTile(
      leading: IconButton(
        icon: (task.completed)
            ? Icon(Icons.check_circle)
            : Icon(Icons.radio_button_unchecked),
        onPressed: () => _toggleTask(task),
      ),
      title: Text(task.name),
      subtitle: (task.details != null) ? Text(task.details) : null,
      trailing: IconButton(
        icon: Icon(Icons.delete_forever),
        onPressed: () => _deleteTask(task),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: ListView(
        children: <Widget>[
          ExpansionTile(
            title: Text('Current tasks (${Task.currentTasks.length})'),
            initiallyExpanded: true,
            children: <Widget>[
              for (final task in Task.currentTasks) _listTile(task),
            ],
          ),
          Divider(),
          ExpansionTile(
            title: Text('Completed (${Task.completedTasks.length})'),
            children: <Widget>[
              for (final task in Task.completedTasks) _listTile(task),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: Icon(Icons.add),
      ),
    );
  }
}

```

### screens/add_task_dialog.dart

```dart
import 'package:flutter/material.dart';
import 'package:todo_app_meetup/models/task.dart';

class AddTaskDialog extends StatefulWidget {
  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
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
