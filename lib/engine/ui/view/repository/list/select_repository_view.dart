import 'package:flutter/material.dart';
import 'package:source_app/engine/ui/view/repository/list/components/content_repository.dart';
import 'package:source_app/engine/ui/view/repository/list/components/list_repositories.dart';

class SelectRepositoryView extends StatelessWidget {
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
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    padding: EdgeInsets.all(8.0),
                    width: 400,
                    height: double.maxFinite,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListRepositories()
                        ),
                      ],
                    ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ContentRepository(),
                ),
              ),
            ],
          ))
      ),
    );
  }
}