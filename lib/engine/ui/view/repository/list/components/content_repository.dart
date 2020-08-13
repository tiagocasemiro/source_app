

import 'package:flutter/material.dart';
import 'package:source_app/engine/ui/view/repository/list/list_repositories_viewmodel.dart';

class RepositoryDetails extends StatelessWidget {
  final SelectRepositoryViewModel _viewModel;
  final String _content;

  RepositoryDetails(this._viewModel, this._content);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10)
      ),
      padding: EdgeInsets.all(8.0),
      child: Text(_content),
    );
  }
}
