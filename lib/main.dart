import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_request/models/persona.dart';

Future<Persona> fetchPersona() async {
  final response = await http.get(Uri.parse('http://10.0.0.12:3000/users/2'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var resp = jsonDecode(response.body);
    return Persona.fromJson(resp);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<List<Persona>> fetchAgenda() async {
  final response = await http.get(Uri.parse('http://10.0.0.12:3000/users/'));
  List<Persona> personas = [];

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var resp = jsonDecode(response.body) as List<dynamic>;

    resp.forEach((item) {
      personas.add(Persona.fromJson(item));
    });

    return personas;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Persona> futurePersona;
  late Future<List<Persona>> futureAgenda;

  @override
  void initState() {
    super.initState();
    //futurePersona = fetchPersona();
    futureAgenda = fetchAgenda();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Fetch Data Example'),
          ),
          body: FutureBuilder<List<Persona>>(
            future: futureAgenda,
            builder: (context, snapshot) {
              List<ListTile> items = [];

              snapshot.data?.forEach((item) => {
                    items.add(ListTile(
                      leading: Text(item.name),
                      title: Text(
                        item.phone,
                      ),
                    ))
                  });

              return ListView(
                children: items,
              );
            },
          )
// push notification $$$$
//websocket
//socketio jsnode
//signalR aspnet
          // Center(
          //   child: FutureBuilder<Persona>(
          //     future: futureAgenda,
          //     builder: (context, snapshot) {
          //       if (snapshot.hasData) {
          //         return Text(snapshot.data!.name);
          //       } else if (snapshot.hasError) {
          //         return Text('${snapshot.error}');
          //       }

          //       // By default, show a loading spinner.
          //       return const CircularProgressIndicator();
          //     },
          //   ),
          // ),
          ),
    );
  }
}
