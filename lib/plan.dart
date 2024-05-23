import 'package:flutter/material.dart';
import 'home.dart';
import 'calendar.dart';
import 'profile.dart';
import 'constants/colors.dart';
import '../model/todo.dart';
import '../widgets/todo_item.dart';
import 'database_helper.dart';

class PlanPage extends StatefulWidget {
  PlanPage({Key? key}) : super(key: key);

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  List<ToDo> todosList = [];
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();
  int _currentIndex = 2;

  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    _loadTodos();
    super.initState();
  }

  Future<void> _loadTodos() async {
    final todos = await _databaseHelper.getAllTodos();
    setState(() {
      _foundToDo = todos.map((todo) => ToDo.fromMap(todo)).toList();
    });
  }

  void _addToDoItem(String toDo) async {
    final newTodo = ToDo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      todoText: toDo,
    );

    await _databaseHelper.insertTodo(newTodo.toMap());
    _loadTodos();
    _todoController.clear();
  }

  void _handleToDoChange(ToDo todo) async {
    todo.isDone = !todo.isDone;
    await _databaseHelper.updateTodo(todo.toMap());
    _loadTodos();
  }

  void _deleteToDoItem(String id) async {
    await _databaseHelper.deleteTodo(id);
    _loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 50,
                          bottom: 20,
                        ),
                        child: Text(
                          'My Plan Here',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Serif',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      for (ToDo todoo in _foundToDo.reversed)
                        ToDoItem(
                          todo: todoo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteItem: _deleteToDoItem,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                    left: 20,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                        hintText: 'Input New Plan Here!',
                        border: InputBorder.none),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                ),
                child: ElevatedButton(
                  child: Text(
                    '+',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            'My New Plan, Horaiii !!!',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Serif',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: Text(
                            _todoController.text,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Serif',
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'OK',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'Serif',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                    _addToDoItem(_todoController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: tdOrange,
                    minimumSize: Size(60, 60),
                    elevation: 10,
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        unselectedItemColor: Colors.black,
        selectedItemColor: Color.fromARGB(255, 174, 102, 1),
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.calendar_month),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CalendarPage()),
                );
              },
            ),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              // icon: Icon(Icons.task),
              icon: _currentIndex == 2
                  ? Icon(Icons.task, color: Color.fromARGB(255, 174, 102, 1))
                  : Icon(Icons.task),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlanPage()),
                );
              },
            ),
            label: 'My Plans',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) => item.todoText
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
          semanticLabel: 'menu',
        ),
        onPressed: () {
          print('Menu Button');
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.notifications,
            semanticLabel: 'notification',
          ),
          onPressed: () {},
        ),
      ],
      title: const Text(
        'My Plan',
        style: TextStyle(
          fontSize: 22,
          fontFamily: "Serif",
          fontWeight: FontWeight.bold,
          height: 2.0,
        ),
        textAlign: TextAlign.center,
      ),
      centerTitle: true,
      backgroundColor: Color.fromARGB(255, 255, 218, 83),
    );
  }
}
