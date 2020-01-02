import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _act = 1;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void changeState() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _act == 1 ? _act = 2 : _act = 1;
    });
  }

  @override
  Widget build(BuildContext context) {

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Gestion de costos Operativos',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Productos'),
              onTap: (){},
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Materiales'),
              onTap: (){},
            ),
            ListTile(
              leading: Icon(Icons.group),
              title: Text('Administración'),
              onTap: (){},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configuracion'),
              onTap: (){},
            ),
          ],
        ),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListView(

          children: ListTile.divideTiles(context: context, tiles: [
            ListTile(
                leading: const Icon(Icons.flight_land),
                title: const Text('Mayonesa'),
                subtitle: const Text('Se usa para untar'),
                enabled: true,
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.red[600],
                  onPressed: () {},
                ),
                onTap: () {

                }),
            ListTile(
                leading: const Icon(Icons.flight_land),
                title: const Text('Mayonesa'),
                subtitle: const Text('Se usa para untar'),
                enabled: true,
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.red[600],
                  onPressed: () {},
                ),
                onTap: () {

                })
          ]).toList()
          ,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}