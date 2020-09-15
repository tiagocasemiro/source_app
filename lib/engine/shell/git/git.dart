import 'dart:async';
import 'package:source_app/engine/domain/model/git_remote.dart';
import 'package:source_app/engine/shell/git/command/checkout.dart';
import 'package:source_app/engine/shell/git/command/config.dart';
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
  static String _repository = "origin";

  Future<bool> startRepositoryWithCredentials(String username, String password, String workDirectory) async {
    Completer<bool> _completer = new Completer<bool>();
    _workDirectory = workDirectory;
    await config().store().call();
    GitOutput gitOutput = await config().url().call();
    remote().showWithCredentials(gitOutput.object, username, password).call().then((GitOutput remote) {
      if(remote.isSuccess()) {
        _repository = (remote.object as GitRemote).name;
      }
      _completer.complete(remote.isSuccess());
    }, onError: (e) => _completer.complete(false));

    return _completer.future;
  }

  Future<bool> startRepository(String workDirectory) async {
    Completer<bool> _completer = new Completer<bool>();
    _workDirectory = workDirectory;
    _completer.complete(true);
    return _completer.future;
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
    return Push(_workDirectory, _repository);
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

  Config config() {
    return Config(_workDirectory);
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
