import 'package:source_app/git/shell/git/model/git_output.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';
import 'base/base_adapter.dart';

class AddAdapter extends BaseAdapter {
  AddAdapter(terminalOutput) : super(terminalOutput) ;

  GitOutput all() {
    return execute();
  }

  GitOutput files() {
    return execute();
  }
}
