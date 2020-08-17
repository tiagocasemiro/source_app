import 'package:flutter/material.dart';
import 'package:source_app/engine/domain/model/git_repository.dart';
import 'package:source_app/engine/ui/source_resources.dart';
import 'package:source_app/engine/ui/view/repository/list/components/add_local_repository.dart';
import 'package:source_app/engine/ui/view/repository/list/components/details_repository.dart';
import 'package:source_app/engine/ui/view/repository/list/components/empty_content_repository.dart';
import 'package:source_app/engine/ui/view/repository/list/components/list_repositories.dart';
import 'package:source_app/engine/ui/view/repository/list/list_repositories_viewmodel.dart';
import 'package:source_app/engine/ui/view/widgets/vertical_split_view.dart';

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
            ratio: 0.49,
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
                    padding: const EdgeInsets.only(right: 45.0, top: 8.0, left: 45.0, bottom: 8.0),
                    child: Image.asset('images/source-logo.png', width: 300, height: 120),
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: _viewModel.deleteOutput,
                      builder: (_, __) {
                        _viewModel.statusInput.add(null);
                        return ListRepositories(_viewModel);
                      })
                  ),
                ],
              ),
            ),
            right: StreamBuilder<Repository>(
              initialData: null,
              stream: _viewModel.statusOutput,
              builder: (context, snapshot) {
                final Repository repository = snapshot.data;

                return Visibility(
                  visible: repository != null,
                  replacement: EmptyContentRepository(_viewModel),
                  child: RepositoryDetails(repository),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addLocalRepositoryAlert(context);
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  @override
  void dispose(){
    _viewModel.dispose();
    super.dispose();
  }
}


