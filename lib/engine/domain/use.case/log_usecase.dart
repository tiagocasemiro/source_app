import 'package:source_app/engine/shell/git/command/log.dart';
import 'package:source_app/engine/shell/git/git.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';

class LogUseCase {
  Future<GitOutput> history() async {
    return Git().log().all().dateOrder().pretty(Log.historyFormat).call();
  }
}
