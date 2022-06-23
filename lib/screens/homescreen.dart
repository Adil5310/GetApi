import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:learningapi/models/PostsModel.dart';
import 'package:http/http.dart' as http;
import 'package:learningapi/screens/screen2.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostsModel> postList = [];
  Future<List<PostsModel>> getPosts() async {

    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200)
      {
        for(Map i in data)
          {
            postList.add(PostsModel.fromJson(i));
          }
        return postList;
      }else{
      return postList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Get API"),),
        actions: [IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Screen2()));
        }, icon: Icon(Icons.skip_next))],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPosts(),
                builder:(context, snapshot){
                if(!snapshot.hasData)
                  {
                    return Text("Loading...");
                  }
                else{
                  return ListView.builder(
                    itemCount: postList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(

                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("ID :", style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),),
                                Text(postList[index].id.toString()),
                                const Text("Title :", style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),),
                                Text(postList[index].title.toString()),
                                const Text('Description: ', style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),),
                                Text(postList[index].body.toString()),
                              ],
                            ),
                          ),
                        );
                  } );
                }
    },),
          )
        ],
      )
    );
  }
}
