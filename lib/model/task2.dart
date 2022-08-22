import 'package:flutter/material.dart';

class Task extends StatefulWidget {

Task({Key? key}) : super(key: key);


  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool showGride =false;
  String apititle = "GridView";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("cdksnvk"),
        leading: IconButton(icon: Icon(Icons.add),
          onPressed: () {
          setState((){
            showGride = true;
            apititle ="fvfv";

          });
          },
        ),
        actions: [
      IconButton(icon: Icon(Icons.add),
      onPressed: () {
        setState((){
          showGride = false;
          apititle ="fvfv";

        });
      },
      ),
      ],
      ),
      body:showGride? _buildGride():_buildList(),
    );
  }

  //build gridview
  Widget _buildGride() => GridView.extent(
      padding: EdgeInsets.all(4),
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
      maxCrossAxisExtent: 150,
      children: __buildGrideTitleList(100));

  List<Container> __buildGrideTitleList(int count) => List.generate(
      count,
      (index) => Container(
            child: Image.asset("images/illustration-1.png"),
          ));

  //Build Li"tview
  Widget _buildList() => ListView(
        children: [
          _tile('CineArts at the Empire','85 w portal Ave',Icons.theaters),
          _tile('CineArts at the Empire','85 w portal Ave',Icons.theaters),
          _tile('CineArts at the Empire','85 w portal Ave',Icons.theaters),
          _tile('CineArts at the Empire','85 w portal Ave',Icons.theaters),

        ],
      );

  ListTile _tile(String title, String subTitle, IconData icon) => ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subTitle),
        leading: Icon(
          icon,
          color: Colors.blue,
        ),
      );
}
