import 'package:source_app/git/shell/git/model/git_output.dart';
import 'base/base_adapter.dart';

class MergeAdapter extends BaseAdapter {
  GitOutput confirm(String _gitOutput) {
    // TODO implement
    print(_gitOutput);
    return GitOutput(_gitOutput);
  }
}
