import 'package:flutter/material.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Source',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    padding: EdgeInsets.all(8.0),
                    width: 400,
                    height: double.maxFinite,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return  Container(
                                color: Colors.white,
                                width: double.maxFinite,
                                height: 100,
                                margin: const EdgeInsets.all(8.0),
                              );
                            },
                            itemCount: 3,
                          )
                        ),
                      ],
                    ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    padding: EdgeInsets.all(8.0),
                  ),
                ),
              ),
            ],
          ))
      ),
    );
  }
}