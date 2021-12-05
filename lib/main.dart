import 'package:flutter/material.dart';
import 'MyApp.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'COVID-19 Prediction',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/MyApp': (context) => MyApp(),
      },
    ),
  );
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COVID-19 Prediction Model', textAlign: TextAlign.center),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
          children: [
            Text('Machine learning based prediction of COVID-19 using hematological parameters', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0)),                      
            Text(''),
            
            Text('The current model considers four hematological parameters, namely, "Platelet Count", "Monocyte count", "Leukocyte Count" and "Eosinophil count" as inputs.', textAlign: TextAlign.center, style: TextStyle(fontSize: 18.0)),
            Text('Based on these parameters, a binary prediction - either COVID-19 positive or negative as well as probability of COVID-19 positive is made.', textAlign: TextAlign.center, style: TextStyle(fontSize: 18.0)),
            Text(''),
            ElevatedButton(
              onPressed: () {
              Navigator.pushNamed(context, '/MyApp');
            },
            child: const Text('Enter Values'),
            ),
          ],
        )
        )
        // child: ElevatedButton(
        //   onPressed: () {
        //     Navigator.pushNamed(context, '/MyApp');
        //   },
        //   child: const Text('Enter Values'),
        // ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COVID-19 Prediction',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyAppPage(),
    );
  }
}