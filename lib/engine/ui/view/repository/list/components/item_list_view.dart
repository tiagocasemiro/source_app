import 'package:flutter/material.dart';
import 'package:source_app/engine/domain/model/git_repository.dart';

class RepositoryItem extends StatelessWidget {
  final Repository repository;

  RepositoryItem(this.repository);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          repository.name,
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
        subtitle: Text(
          repository.workDirectory,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
