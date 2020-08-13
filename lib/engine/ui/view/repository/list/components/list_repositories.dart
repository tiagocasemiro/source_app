import 'package:flutter/material.dart';
import 'package:source_app/engine/domain/model/git_repository.dart';
import '../list_repositories_viewmodel.dart';
import 'item_list_repository.dart';

class ListRepositories extends StatelessWidget {
  final SelectRepositoryViewModel _viewModel = SelectRepositoryViewModel();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Repository>>(
      initialData: [],
      future: _viewModel.all(),
      builder: (context, snapshot) {
        final List<Repository> repositories = snapshot.data != null? snapshot.data: List();
        return Visibility(
          visible: repositories.isNotEmpty,
          replacement: Center(child: snapshot.connectionState != ConnectionState.done? CircularProgressIndicator(): Text("No repository")),
          child: ListView.builder(
              itemBuilder: (context, index) {
                final Repository repository = repositories[index];
                return RepositoryItem(repository, _viewModel);
              },
              itemCount: repositories.length,
            ),
        );
      },
    );
  }
}
