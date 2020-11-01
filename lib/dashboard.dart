import 'package:flutter/material.dart';
import 'package:flutter_todo_app/todo.dart';
import 'package:swipedetector/swipedetector.dart';

class Dashboard extends StatelessWidget {
  static const String routeName = '/dashboard';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterTodo',
      home: Home(),
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with SingleTickerProviderStateMixin{
  List<Todo> items = new List<Todo>();
  static final myController = TextEditingController();
  TextEditingController _editingController;
  String initialText = "Enter Task";
  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text: " ");
  }
  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FlutterTodo',
          key: Key('main-app-title'),
        ),
        centerTitle: true,
      ),
      /*floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>goToNewItemView(),
      ),*/
      body: SafeArea(
          child: SwipeDetector(
              swipeConfiguration: SwipeConfiguration(
                  verticalSwipeMinVelocity: 100.0,
                  verticalSwipeMinDisplacement: 50.0,
                  verticalSwipeMaxWidthThreshold:100.0),
              onSwipeDown: () {
                setState(() {
                  Todo data=new Todo(title: " ");
                  data.updateEdit(true);
                  addItem(data);
                });
              },
              child: renderBody())
      )
    );
  }

  Widget renderBody(){
      return buildListView();
  }
  
  Widget emptyList(){
    return Center(child: Text("No Item"));
  }

  void _updateMyItems(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final Todo item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    changeItemCompleteness(item);
  }

  void _updateCompleteItems(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final Todo item = items.removeAt(oldIndex);
    item.completed=false;
    items.insert(newIndex, item);
    changeItemCompleteness(item);
  }

  Widget buildListView() {
    return ReorderableListView(
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          _updateMyItems(oldIndex, newIndex);
        });
      },
      children: List.generate(items.length, (index) {
        return buildItem(items[index],index);
      }),
    );
  }

  Widget buildItem(Todo item, index) {
      return Dismissible(
        key: Key('value${index}'),
        background: slideRightBackground(),
        secondaryBackground: slideLeftBackground(),
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            _removeItemFromList(item);
          } else if(direction == DismissDirection.startToEnd){
            changeItemCompletenessToBottom(item, index);
          }
        },
        child: buildListTile(item, index),
      );
  }

  Widget buildListTile(item, index){
    return Container(
        decoration: BoxDecoration(
            color: item.completed ? Colors.black : Colors.deepOrange[1000-((index+1)*100)],
            border: Border(
              bottom: BorderSide( //                   <--- left side
                color: Colors.grey,
                width: 0.5,
              ),
            ),
        ),
      child: ListTile(
        key: ValueKey('${item.hashCode}'),
        //onTap: () => goToEditItemView(item),
        //onLongPress: () => goToEditItemView(item),
        title: _editTitleTextField(item,index),
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.green,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.edit,
              color: Colors.white,
            ),
            Text(
              " Edit",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  void changeItemCompleteness(Todo item){
    setState(() {
      item.completed = !item.completed;
    });
  }

  void changeItemCompletenessToBottom(Todo item,int index){
    setState(() {
      _updateCompleteItems(index, items.length);
    });
  }


  void addItem(Todo item){
    // Insert an item into the top of our list, on index zero
    items.insert(0, item);
  }


  void editItem(Todo item ,String title){
    item.title = title;
  }

  void _removeItemFromList(item) {
    deleteItem(item);
  }

  void deleteItem(item){
    // We don't need to search for our item on the list because Dart objects
    // are all uniquely identified by a hashcode. This means we just need to
    // pass our object on the remove method of the list
    items.remove(item);
  }


  Widget _editTitleTextField(Todo item,index) {
    if (item.isEditable)
      return Center(
        child: TextField(
          key: Key('item-$index'),
          style: TextStyle(color: Colors.white,fontSize: 20.0),
          decoration: new InputDecoration.collapsed(
              hintText: 'Task'
          ),
          onSubmitted: (newValue){
            setState(() {
              _editingController.text =" ";
              item.isEditable =false;
              item.title=newValue;
            });
          },
          autofocus: true,
          controller: _editingController,
        ),
      );
    return InkWell(
        key: Key('item-$index'),
        onTap: () {
      setState(() {
        item.isEditable = true;
      });
    },
    child: Text(
      item.title,
      key: Key('item-$index'),
      style: TextStyle(
          fontSize: 20.0,
          color:item.completed ? Colors.grey: Colors.white,
          decoration: item.completed ? TextDecoration.lineThrough : null
      ),
    ));
  }
}