import 'package:source_app/engine/domain/use.case/fetch_usecase.dart';
import 'package:source_app/engine/domain/use.case/pull_usecase.dart';
import 'package:source_app/engine/domain/use.case/push_usecase.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-left/body_left_viewmodel.dart';

class HeaderViewModel {
  final BodyLeftViewModel _bodyLeftViewModel;

  HeaderViewModel(this._bodyLeftViewModel);

  Future<GitOutput> push() async {
    return await PushUseCase().push();
  }

  Future<GitOutput> pull() async {
    return await PullUseCase().pull();
  }

  Future<GitOutput> fetch() async {
    GitOutput gitOutput = await FetchUseCase().fetch();

    if(gitOutput.isSuccess()) {
      _bodyLeftViewModel.refreshLocalBranches();
    }
    return gitOutput;
  }
}