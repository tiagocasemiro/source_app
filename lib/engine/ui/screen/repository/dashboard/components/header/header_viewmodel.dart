import 'package:source_app/engine/domain/use.case/push_usecase.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';

class HeaderViewModel {

  Future<GitOutput> push() async {
    return await PushUseCase().push();
  }
}