import 'package:source_app/engine/shell/git/adapter/diff_adapter.dart';
import 'package:source_app/engine/shell/git/command/base/base_command.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/shell/model/terminal_output.dart';

class Diff extends BaseGitCommand {
  _Variant _variant = _Variant.diff;
  Diff(String workDirectory) : super(workDirectory) {
    parameters.add('diff');
  }

  Diff nameOnly() {
    parameters.add("--name-only");

    return this;
  }

  Diff cached() {
    parameters.add("--cached");

    return this;
  }

  Diff file(String name) {
    parameters.add(name);

    return this;
  }

  Diff tree() {
    parameters.clear();
    parameters.add("diff-tree");
    _variant = _Variant.diff_tree;

    return this;
  }

  Diff noCommitId() {
    parameters.add("--no-commit-id");

    return this;
  }

  Diff r() {
    parameters.add("-r");

    return this;
  }

  Diff hash(String value) {
    parameters.add(value);

    return this;
  }

  @override
  Future<GitOutput> call() async {
    TerminalOutput terminalOutput = await super.execute(parameters: parameters);

    if(_variant == _Variant.diff)
      return DiffAdapter(terminalOutput).files();

    return DiffAdapter(terminalOutput).filesModifiedFromCommit();
  }
}

enum _Variant { diff, diff_tree }