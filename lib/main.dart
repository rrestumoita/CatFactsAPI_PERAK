import 'package:flutter/material.dart';
import 'services/cat_fact_service.dart';

void main() {
  runApp(CatFactsApp());
}

class CatFactsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat Facts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CatFactScreen(),
    );
  }
}

class CatFactScreen extends StatefulWidget {
  @override
  _CatFactScreenState createState() => _CatFactScreenState();
}

class _CatFactScreenState extends State<CatFactScreen> {
  late Future<CatFact> futureCatFact;

  @override
  void initState() {
    super.initState();
    futureCatFact = CatFactService().fetchCatFact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Facts'),
      ),
      body: Center(
        child: FutureBuilder<CatFact>(
          future: futureCatFact,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '${snapshot.data!.fact}',
                  style: TextStyle(fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return Text('No data available');
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            futureCatFact = CatFactService().fetchCatFact();
          });
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
