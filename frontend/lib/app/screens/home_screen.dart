import 'package:flutter/material.dart';
import 'package:frontend/app/controllers/task.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _descController = TextEditingController();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    final _taskController = Provider.of<TaskController>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Tasks Project'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Column(
                  children: [
                    Text('Adicione uma tarefa:'),
                    Divider(),
                  ],
                ),
                content: TextField(
                  controller: _descController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                actions: [
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancelar'),
                  ),
                  FlatButton(
                    onPressed: () {
                      _taskController.createTask(_descController.text.trim());
                      Navigator.pop(context);
                      _taskController.getTasks();
                    },
                    child: Text('Salvar'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List>(
        future: _taskController.getTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          if (!snapshot.hasData)
            return Center(
              child: Text('Sem tarefas cadastradas...'),
            );
          return Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: RefreshIndicator(
              key: _refreshKey,
              onRefresh: () async {},
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Dismissible(
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                    ),
                    key: ValueKey(snapshot.data[index]["id"]),
                    onDismissed: (direction) {
                      _taskController.deleteTask(snapshot.data[index]["id"]);
                    },
                    child: CheckboxListTile(
                      title: Text(snapshot.data[index]["desc"]),
                      value: snapshot.data[index]["done"] == 0 ? false : true,
                      onChanged: (_) {
                        _taskController.updateTask(snapshot.data[index]["id"]);
                      },
                    ),
                  );
                },
                itemCount: snapshot.data.length,
              ),
            ),
          );
        },
      ),
    );
  }
}
