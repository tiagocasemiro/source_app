
import 'package:flutter/material.dart';
import 'package:source_app/engine/ui/view/repository/list/list_repositories_viewmodel.dart';

class EmptyContentRepository extends StatelessWidget {
  final SelectRepositoryViewModel _viewModel;

  EmptyContentRepository(this._viewModel);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Select a repository"),
    );
  }
}
