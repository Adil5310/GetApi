import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learningapi/screens/screen3.dart';
class Screen2 extends StatefulWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  List<PhotosModel> photoList = [];
  Future<List<PhotosModel>> getList() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map i in data)
        {
          PhotosModel photosModel = PhotosModel(title: i['title'], url: i['url'], id: i['id']);
          photoList.add(photosModel);
        }
      return photoList;
    } else{
      return photoList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Photo API')),
        actions: [IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Screen3()));
        }, icon: Icon(Icons.skip_next))],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future:getList(),
                builder: (context, AsyncSnapshot<List<PhotosModel>> snapshot){
              return ListView.builder(
                itemCount: photoList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                      ),
                      title: Text(snapshot.data![index].id.toString() ),
                      subtitle: Text(snapshot.data![index].title.toString() ),
                    );
              });
            }),
          )
        ],
      ),
    );
  }
}


class PhotosModel{
  String title, url;
  int id;
  PhotosModel({required this.title ,required this.url, required this.id});
}