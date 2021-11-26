import 'dart:convert';
import 'dart:io';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model/clients_model.dart';

void main() {
  print("IN MAIN");
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("IN |_/_MyApp_\_|");
    return MaterialApp(
      title: 'Client List',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    getClientsDetail();
    super.initState();
  }

  int currentPage = 1;
  List<Client> clients = [];

  Future<bool> getClientsDetail() async {
    final response = await http.get(Uri.parse("https://run.mocky.io/v3/f3feef1c-9bfa-43fd-b2a0-bbe9abadb4f6"));
    if(response.statusCode == 200){
      final result = clientModelFromJson(response.body);
      clients = result.clients.cast<Client>();
      print(clients[0].name);
      setState(() {

      });
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clients List'),
      ),
      body: _body()
    );
  }

  _body() {
    if (clients.isEmpty){
      return Center(child: CircularProgressIndicator(),);
    }
    return
      ListView.separated(
          itemBuilder: (context, index) {
            final client = clients[index];
            return ListTile(
                title: Text(client.name),
                subtitle: Text(client.company),
                trailing:Column(
                    children: [
                      Text("paid +"+client.invoicepaid,  style: TextStyle(color: Colors.green), textAlign: TextAlign.left,),
                      Text("pending "+client.invoicepaid,  style: TextStyle(color: Colors.redAccent), textAlign: TextAlign.left,)
                    ],
                  ),
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: clients.length
      );
  }
}
