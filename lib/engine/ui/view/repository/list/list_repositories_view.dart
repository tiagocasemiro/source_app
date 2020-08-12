import 'package:flutter/material.dart';
import 'package:source_app/engine/ui/source_resources.dart';
import 'package:source_app/engine/ui/view/repository/list/components/content_repository.dart';
import 'package:source_app/engine/ui/view/repository/list/components/list_repositories.dart';

class SelectRepositoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Source',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        backgroundColor: SourceColors.white,
        body:  Container(
          decoration: BoxDecoration(
              color: SourceColors.background_grey[3],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: SourceColors.background_grey[2],
                          borderRadius: BorderRadius.circular(10)
                      ),
                      padding: EdgeInsets.all(8.0),
                      width: 550,
                      height: double.maxFinite,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 80.0, top: 40.0, left: 80.0, bottom: 40.0),
                            child: Image.asset('images/source-logo.png'),
                          ),
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
                    child: RepositoryDetails(),
                  ),
                ),
              ],
            )),
        )
      ),
    );
  }
}