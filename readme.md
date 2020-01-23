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

TODO: Add image of what we will create!

You'll find the completed code files at the end of this codelab.

TODO: Add links to the completed files!

## Prerequsits

Before getting started, you need to have Flutter, and a supported IDE installed.

Head over to Flutter's [getting started page](https://flutter.dev/docs/get-started/install), to install the necessary things needed for this codelab.

Link to my slides can be found [here](https://docs.google.com/presentation/d/1109B3fQyqNO5zVxh4j4mRO9A9I-5KumPpqgcd6xDKOA/edit?usp=sharing).

When you have installed Flutter and your prefered IDE, then it's time to start.

Remember to [run flutter doctor](https://flutter.dev/docs/get-started/install/macos#run-flutter-doctor) to check that you are not missing anything.

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

As this class is what is called a model then let us put this class in a folder we call `model`.
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

First create a dart file called `task_list_view`.

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

Now we will create two static lists of tasks: `currentTasks` and `completedTasks`.
With them being static we are able to get the two lists anywhere without creating a Task object.

```dart
static List<Task> get currentTasks =>
      _tasks.where((task) => !task.completed).toList();

static List<Task> get completedTasks =>
      _tasks.where((task) => task.completed).toList();

```

This is not best practise in the way of sharing data, but we will keep it simple.

Now that we have two different lists we can seperate them in the way we want to show them. In the view of current tasks and completed tasks.

```dart
...

children: <Widget>[
  ExpansionTile(title: Text("Current Tasks"),
    initiallyExpanded: true,
    children: <Widget>[
      for (final task in Task.currentTasks) _listTile(task),
    ],
  ),
  Divider(),
  ExpansionTile(title: Text("Completed Tasks"),
    children: <Widget>[
      for (final task in Task.completedTasks) _listTile(task),
    ],
  )
],

...

```

## Task: Create new screen to adding a new task

Lets create a new dart file `add_task_dialog.dart` which will be a stateful widget. The reason we want it stateful is because it will have a `TextField` widget that takes some input and displays it in the app.

The class will have two private variables to save the two inputs from the user: `_taskName` & `_taskDetails`.
There will be a private `_save` method which task is to create a task object with the value input and then navigate back to the previous screen with the task object.
It will be a `Form` widget that have two `TextField`s and in those two we will save the user input to the to variables we have in the class.

```dart
class AddTaskDialog extends StatefulWidget {
  @override
  _TaskDialogState createState() => _TaskDialogState();
}

class _TaskDialogState extends State<AddTaskDialog> {
  String _taskName = '';
  String _taskDetails;

  void _save() {
    final task = _taskName.isNotEmpty ? Task(_taskName, _taskDetails) : null;
    Navigator.of(context).pop(task); // will send task back
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
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              alignment: Alignment.bottomLeft,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                onChanged: (value) => _taskName = value,
                autofocus: true,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              alignment: Alignment.bottomLeft,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Details',
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

## Task: Add a floating action button

Now let us update our `MyApp` class by adding a floating action button.
We will add a `FloatingActionButton` widget to a `floatingActionButton` parameter in the `Scaffold` widget.
The button will navigate to our `TaskDialog` screen.

```dart
floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addTask,
      ),

```

Now create the `_addTask` as shown below.

```dart
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

Lets also change the current `toggleTask` method to be private for consistency `_toggleTask`.

We can navigate from tasklist to add task dialog, finally lets add a button to save.

## Task: Add a save button

Let's navigate back to `TaskDialog` and add a `FlatButton` that will call our private method, `_save`, to save the task and navigate back.

In the `AppBar` widget add the button and handle the `onPressed` parameter to call `_save`.

```dart
...

actions: <Widget>[
  FlatButton(
    child: Text(
      'SAVE',
      style: TextStyle(color: Colors.white),
    ),
    onPressed: _save,
  ),
],

...

```

## Task: Handle asynchronous call

As we now know the task will get back with us we need to change the code to wait for the task. Only then can we save the new task to the list of current tasks.

So let's change the `_addTask` method to be an `async` code block and add `await` before the `Navigator.push(...)`. We know that it will return something when we are navigating back from the `TaskDialog` screen.

The `final task` variable can be `null` therefore, we need to do a null check before saving the task.

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

## Task: Change to dark mode

In `main.dart`
We see the `theme` parameter and here we will change it to `ThemeData.dark()`. This will bring the theme of the whole app into dark mode.

```dart
theme: ThemeData.dark(),

```

## Task: Add funktionality to delete a task

Now we also want to delete tasks from our list.

This could also be a case where we'd want a native feel to our delete dialogs.

Let us first add a trailing icon to our `ListTile` widget.

```dart
...

trailing: IconButton(
  icon: Icon(Icons.delete_forever),
  onPressed: () => _deleteTask(task),
),

...

```

As Flutter is platform aware, we have the ability to let the app decide on which widgets to show. This is useful if we want a native feel to our app.

Because we are sending a `bool` with our navigator then we have to ake the code block asynchronous with `async` & `await`.

For iOS dialog we will be using `CupertinoAlertDialog` along with two actions of the `CupertinoDialogAction` widget.
For android dialog we will be using `AlertDialog` with two `FlatButton`s to handle the actions.

In the end we will be removing the task from the list depending on the `confirmed` variable which is a boolean.

```dart
import 'package:flutter/cupertino.dart'; // for the use of cupertino widgets

void _deleteTask(Task task) async {
    final confirmed = (Platform.isIOS) // checking to see which widget we will be showing
        ? await showCupertinoDialog<bool>(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: Text('Delete Task?'),
              content: Text('This task will be permanently deleted.'),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('Cancel'),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                CupertinoDialogAction(
                  child: Text('Delete'),
                  isDestructiveAction: true,
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            ),
          )
        : await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Delete Task?'),
              content: Text('This task will be permanently deleted.'),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                FlatButton(
                  child: Text("Delete"),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            ),
          );

    if (confirmed ?? false) { // ?? is a check to see if null then do something else
      setState(() {
        Task.tasks.remove(task);
      });
    }
  }

```

## Completed files

### main.dart

```dart
import 'package:flutter/material.dart';
import 'package:todo_app_ex/task_list_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: TaskListView(),
    );
  }
}


```

### model/task.dart

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

  static List<Task> get currentTasks => _tasks.where((task) => !task.completed).toList();

  static List<Task> get completedTasks => _tasks.where((task) => task.completed).toList();

  Task(this.name, this.details);  // Constructor with parameters for creating a Task object
}

```

### screens/task_list_view.dart

```dart
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_ex/screens/add_task_dialog.dart';

import '../model/task.dart';

class TaskListView extends StatefulWidget {
  @override
  _TaskListViewState createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: ListView(
        children: <Widget>[
          ExpansionTile(
            title: Text("Completed Tasks"),
            initiallyExpanded: true,
            children: <Widget>[
              for (final task in Task.currentTasks) _listTile(task),
            ],
          ),
          Divider(),
          ExpansionTile(
            title: Text("Completed Tasks"),
            children: <Widget>[
              for (final task in Task.completedTasks) _listTile(task),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addTask,
      ),
    );
  }

  ListTile _listTile(Task task) {
    return ListTile(
      leading: IconButton(
        icon: (task.completed)
            ? Icon(Icons.check_circle)
            : Icon(Icons.radio_button_unchecked),
        onPressed: () => toggleTask(task),
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete_forever),
        onPressed: () => _deleteTask(task),
      ),
      title: Text(task.name),
      subtitle: (task.details != null) ? Text(task.details) : null,
    );
  }

  void toggleTask(Task task) {
    setState(() {
      task.completed = !task.completed;
    });
  }

  void _addTask() async {
    final Task newTask = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDialog(),
        fullscreenDialog: true,
      ),
    );

    if (newTask ?? false) {
      setState(() {
        Task.tasks.add(newTask);
      });
    }
  }

  void _deleteTask(Task task) async {
    final confirmed =
        (Platform.isIOS) // checking to see which widget we will be showing
            ? await showCupertinoDialog<bool>(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: Text('Delete Task?'),
                  content: Text('This task will be permanently deleted.'),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: Text('Cancel'),
                      isDefaultAction: true,
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                    CupertinoDialogAction(
                      child: Text('Delete'),
                      isDestructiveAction: true,
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ],
                ),
              )
            : await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Delete Task?'),
                  content: Text('This task will be permanently deleted.'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Cancel"),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                    FlatButton(
                      child: Text("Delete"),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ],
                ),
              );

    if (confirmed ?? false) {
      // ?? is a check to see if null then do something else
      setState(() {
        Task.tasks.remove(task);
      });
    }
  }
}

```

### screens/add_task_dialog.dart

```dart
import 'package:flutter/material.dart';

import '../model/task.dart';

class TaskDialog extends StatefulWidget {
  @override
  _TaskDialogState createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  String _taskName = "";
  String _taskDesc;

  void _save() {
    final task = _taskName.isNotEmpty ? Task(_taskName, _taskDesc) : null;
    Navigator.of(context).pop(task); // will send task back
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Task"),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: _save,
          )
        ],
      ),
      body: Form(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Task name",
                ),
                autofocus: true,
                onChanged: (value) => _taskName = value,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Task details",
                ),
                onChanged: (value) => _taskDesc = value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

```
