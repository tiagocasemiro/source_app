import 'package:source_app/git/shell/git/adapter/base/base_adapter.dart';
import 'package:source_app/git/shell/git/model/git_output.dart';

class CheckoutAdapter extends BaseAdapter {

  GitOutput confirm(String _gitOutput) {
    print(_gitOutput);
    return noOutput(_gitOutput);
  }
}