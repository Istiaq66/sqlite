import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:sqlite/models/scholar_model.dart';
import 'package:sqlite/pages/scholar_page.dart';
import 'package:sqlite/repo/local_repository.dart';


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
  int _counter = 0;
  var logger = Logger();
  LocalRepo dbService = LocalRepo();

  void _incrementCounter() async {
    try {
      // Fetch scholars from the database
      List<Scholar>? scholars = await dbService.fetchData();

      // Navigate to ScholarsListPage with the fetched scholars
      if(mounted){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScholarsListPage(scholars: scholars ?? []),
          ),
        );
      }
    } catch (e) {
      // Handle any errors that occur during data fetching
      logger.i('Error fetching scholars: $e');
      // Optionally show an error dialog or snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load scholars')),
      );
    }
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    dbService.initializeDatabase();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
