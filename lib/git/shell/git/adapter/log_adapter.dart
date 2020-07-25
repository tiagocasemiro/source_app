import 'package:source_app/git/model/git_commit.dart';
import 'package:source_app/git/shell/git/adapter/base/base_adapter.dart';
import 'package:source_app/git/shell/git/model/git_output.dart';

class LogAdapter extends BaseAdapter {
  //https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
  GitOutput confirm(String _gitOutput) {
    // TODO implement
    print(_gitOutput);
    return GitOutput(_gitOutput).success(object: List());
  }
}
