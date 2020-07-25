import 'package:source_app/git/shell/git/model/git_output.dart';
import 'base/base_adapter.dart';

class CommitAdapter extends BaseAdapter {
  GitOutput commitToObject(String _gitOutput) {
    print("Terminal output: " + _gitOutput);

    toLines(_gitOutput).forEach((line) {
      if(line.contains("error: ")) {
        print("Falha no commit");
        return GitOutput(_gitOutput).failure();
      }
    });
    print("uhuuuuu sucesso no commit");
    return GitOutput(_gitOutput).success();
  }
}
