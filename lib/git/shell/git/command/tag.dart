import 'package:source_app/git/shell/git/adapter/tag_adapter.dart';
import 'base/base_command.dart';

class Tag extends BaseGitCommand {

  Tag(workDirectory): super(workDirectory) {
    parameters.add('tag');
  }

  @override
  Future call() async {
    String terminalOutput = await super.execute(parameters: parameters);

    return TagAdapter().toTags(terminalOutput);
  }
}