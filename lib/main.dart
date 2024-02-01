import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  //initial state
  int _counter = 0;
  bool switchStatus = true;
  bool bulbStatus = true;

  @override
  void initState() {
    // first time
    getstoredBulbStauts();
    readStoredValue();
    super.initState();
  }

  Future getstoredBulbStauts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? status = prefs.getBool("BULBSTATUS");
    if (status != null) {
      bulbStatus = status;
    }
  }

  readStoredValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // get previously stored value if any from shared preferences

    _counter = prefs.getInt('COUNTER') ?? 0;

    setState(() {});
  }

  void _incrementCounter() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // get previously stored value if any from shared preferences

    _counter = prefs.getInt('COUNTER') ?? 0;

    _counter++;
    await prefs.setInt('COUNTER', _counter);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: GestureDetector(
        onTap: _incrementCounter,
        child: Container(
          color: Colors.red,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.lightbulb,
                size: switchStatus ? 200 : 100,
                color: switchStatus ? Colors.amber : Colors.black,
              ),
              Switch(
                  value: switchStatus,
                  onChanged: (value) async {
                    bulbStatus = value;
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool("BULBSTATUS", value);

                    setState(() {
                      switchStatus = value;
                    });
                  }),
              IconButton(
                  onPressed: () {
                    setState(() {
                      bulbStatus = !bulbStatus;
                    });
                  },
                  icon: Icon(
                    Icons.lightbulb,
                    size: 200,
                    color: bulbStatus ? Colors.amber : Colors.black,
                  )),
              //Switch(value: value, onChanged: onChanged)
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
