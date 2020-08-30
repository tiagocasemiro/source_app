import 'dart:async';
import 'package:source_app/engine/domain/model/git_remote.dart';
import 'package:source_app/engine/shell/git/command/checkout.dart';
import 'package:source_app/engine/shell/git/command/credentials.dart';
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
  bool _passwordStarted = false;
  bool _usernameStarted = false;
  bool _repositoryStarted = false;

  Future<bool> startRepository(String username, String password, String workDirectory) async {
    Completer<bool> _completer = new Completer<bool>();
    _workDirectory = workDirectory;

    await credentials().store().call();

    Function onError = (e) {
      _completer.complete(false);
    };

    remote().call().then((GitOutput remote) {
      _repository = (remote.object as GitRemote).name;
      _repositoryStarted = true;
      if(isAllStarted()) {
        _completer.complete(true);
      }
    }, onError: onError);

    credentials().username(username).call().then((GitOutput gitOutput) {
      _usernameStarted = true;
      if(isAllStarted()) {
        _completer.complete(true);
      }
    }, onError: onError);

    credentials().password(password).call().then((GitOutput gitOutput) {
      _passwordStarted = true;
      if(isAllStarted()) {
        _completer.complete(true);
      }
    }, onError: onError);

    return _completer.future;
  }


  bool isAllStarted() {
    return _passwordStarted && _usernameStarted && _repositoryStarted;
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

  Credentials credentials() {
    return Credentials(_workDirectory);
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
