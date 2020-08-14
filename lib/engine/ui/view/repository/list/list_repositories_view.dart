import 'package:flutter/material.dart';
import 'package:source_app/engine/ui/source_resources.dart';
import 'package:source_app/engine/ui/view/repository/list/components/content_repository.dart';
import 'package:source_app/engine/ui/view/repository/list/components/empty_content_repository.dart';
import 'package:source_app/engine/ui/view/repository/list/components/list_repositories.dart';
import 'package:source_app/engine/ui/view/widgets/vertical_split_view.dart';
import 'list_repositories_viewmodel.dart';

class SelectRepositoryView extends StatefulWidget {
  @override
  _SelectRepositoryViewState createState() => _SelectRepositoryViewState();
}

class _SelectRepositoryViewState extends State<SelectRepositoryView> {
  final SelectRepositoryViewModel _viewModel = SelectRepositoryViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SourceColors.white,
      body:  Container(
        decoration: BoxDecoration(
          color: SourceColors.grey[3],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: VerticalSplitView(
            ratio: 0.4,
            minRatio: 0.4,
            left: Container(
              decoration: BoxDecoration(
                  color: SourceColors.grey[2],
                  borderRadius: BorderRadius.circular(10)
              ),
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 80.0, top: 40.0, left: 80.0, bottom: 40.0),
                    child: Image.asset('images/source-logo.png', width: 300, height: 120),
                  ),
                  Expanded(
                      child: ListRepositories()
                  ),
                ],
              ),
            ),
            right: StreamBuilder<String>(
              initialData: "",
              stream: _viewModel.output,
              builder: (context, snapshot) {
                final String content = snapshot.data != null? snapshot.data: "";

                return Visibility(
                  visible: content.isNotEmpty,
                  replacement: EmptyContentRepository(_viewModel),
                  child: RepositoryDetails(_viewModel, content),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _viewModel.newRepository();
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}


