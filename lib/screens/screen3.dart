import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learningapi/models/UserModel.dart';
import 'package:http/http.dart' as http;
class Screen3 extends StatefulWidget {
  const Screen3({Key? key}) : super(key: key);

  @override
  _Screen3State createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  List<UserModel> userList = [];
  Future<List<UserModel>> getApi() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200)
      {  
        for(Map i in data)
          {
            userList.add(UserModel.fromJson(i));
          }
        return userList;
      } else {
      return userList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User API"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getApi(),
                builder: (context,AsyncSnapshot<List<UserModel>> snapshot){
                if(!snapshot.hasData)
                  {
                     return const Center(child: CircularProgressIndicator());
                  } else{
                  return ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ReuseableRow(title: 'name', value: snapshot.data![index].name.toString()),
                                ReuseableRow(title: 'email', value: snapshot.data![index].email.toString()),
                                ReuseableRow(title: 'address', value: snapshot.data![index].address.toString()),
                                ReuseableRow(title: 'Latitude', value: snapshot.data![index].address!.geo!.lat.toString()),
                              ],
                            ),
                          )
                        );
                      });
                }

            }),
          )
        ],
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String title, value;
   ReuseableRow({Key? key , required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
