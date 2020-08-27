import 'package:source_app/engine/domain/model/git_remote.dart';
import 'package:source_app/engine/shell/git/command/checkout.dart';
import 'package:source_app/engine/shell/git/command/pull.dart';
import 'package:source_app/engine/shell/git/command/remote.dart';
import 'package:source_app/engine/shell/git/command/restore.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'command/add.dart';
import 'command/branch.dart';
import 'command/commit.dart';
import 'command/fetch.dart';
import 'command/log.dart';
import 'command/merge.dart';
import 'command/push.dart';
import 'command/stash.dart';
import 'command/status.dart';
import 'command/tag.dart';

class Git {
  static String _workDirectory;
  static String _scheme ;
  static String _dotGit;
  static String password;
  static String username;
  static String _repository = "origin";

  Future<bool> startRepository(String username, String password, String workDirectory, String scheme, String dotGit) async {
    username = username;
    password = password;
    _workDirectory = workDirectory;
    _scheme = scheme;
    _dotGit = dotGit;
    return remote().call().then((GitOutput remote) {
      _repository = (remote.object as GitRemote).name;

      return true;
    });
  }

  String _originWithCredential() {
    return "$_scheme//$username:$password@$_dotGit";
  }

  Branch branch() {
    return Branch(_workDirectory);
  }

  Tag tag() {
    return Tag(_workDirectory);
  }

  Add add() {
    return Add(_workDirectory);
  }

  Fetch fetch() {
    return Fetch(_workDirectory);
  }

  Commit commit() {
    return Commit(_workDirectory);
  }

  Push push(String username, String password) {
    return Push(_workDirectory, _originWithCredential(), _repository);
  }

  Pull pull() {
    return Pull(_workDirectory);
  }

  Merge merge() {
    return Merge(_workDirectory);
  }

  Stash stash() {
    return Stash(_workDirectory);
  }

  Checkout checkout() {
    return Checkout(_workDirectory, _repository);
  }

  Log log() {
    return Log(_workDirectory);
  }

  Status status() {
    return Status(_workDirectory);
  }

  Restore restore() {
    return Restore(_workDirectory);
  }

  Remote remote() {
    return Remote(_workDirectory);
  }

  Future<bool> isGitDirectory() async {
    GitOutput gitOutput = await status().call();

    return gitOutput.isSuccess();
  }

  Future<GitOutput> checkWorkDirectory(String workDirectory) async {
    GitOutput gitOutput = await Status(workDirectory).call();

    return gitOutput;
  }
}
