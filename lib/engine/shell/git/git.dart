import 'dart:async';
import 'package:source_app/engine/domain/model/git_remote.dart';
import 'package:source_app/engine/domain/model/git_repository.dart';
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
  static String _credentials = "";
  static String _privateCredentials = "";

  Future<String> startRepositoryWithCredentials(String username, String password, String workDirectory) async {
    Completer<String> _completer = new Completer<String>();
    _workDirectory = workDirectory;
    await config().store().call();
    GitOutput gitOutputRemote = await config().url().call();
    _credentials = (gitOutputRemote.object as GitRemote).urlWithCredentials(username, password);
    _privateCredentials = (gitOutputRemote.object as GitRemote).url;
    remote().showWithCredentials(gitOutputRemote.object, username, password).call().then((GitOutput gitOutput) {
      if(gitOutput.isSuccess()) {
        _repository = (gitOutput.object as GitRemote).name;
        _completer.complete(_credentials);
      } else {
        _completer.complete(null);
      }
    }, onError: (e) => _completer.complete(null));

    return _completer.future;
  }
  
  static String repository() {
    return _repository;  
  }

  static String credentials() {
    return _credentials;
  }

  static String privateCredentials() {
    return _privateCredentials;
  }

  Future<bool> startRepository(Repository repository) async {
    Completer<bool> _completer = new Completer<bool>();
    _workDirectory = repository.workDirectory;
    _credentials = repository.credentials;
    _privateCredentials = repository.hidePasswordCredentials();
    remote().call().then((GitOutput remote) {
      if(remote.isSuccess()) {
        _repository = (remote.object as GitRemote).name;
      }
      _completer.complete(remote.isSuccess());
    }, onError: (e) => _completer.complete(false));

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

  Push push() {
    return Push(_workDirectory, _repository, _credentials);
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
    return Checkout(_workDirectory);
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
