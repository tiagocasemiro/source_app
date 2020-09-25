import 'dart:io' show Platform;
import 'package:source_app/engine/database/file/FileUtils.dart';
import 'package:source_app/engine/domain/model/git_remote.dart';
import 'package:source_app/engine/domain/model/git_repository.dart';
import 'package:source_app/engine/shell/git/command/checkout.dart';
import 'package:source_app/engine/shell/git/command/clone.dart';
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
import 'dart:async';

class Git {
  static Repository _repository;

  Future<String> startRepositoryWithCredentials(Repository repository) async {
    Completer<String> _completer = new Completer<String>();
    _repository = repository;
    await config().store().call();
    GitOutput gitOutputRemote = await config().url().call();

    if(gitOutputRemote.isSuccess()) {
      _repository.url = (gitOutputRemote.object as GitRemote).url;
      _repository.generateCredentials();
      bool isAddedWithSuccess = await FileUtil(Platform.environment['HOME'] + '/.git-credentials').addLine(_repository.credentials);
      if(isAddedWithSuccess) {
        GitOutput gitOutputShow = await remote().show().call();
        if(gitOutputShow.isSuccess()) {
          _repository.origin = (gitOutputShow.object as GitRemote).name;
          _completer.complete(_repository.credentials);
        } else {
          _completer.complete(null);
        }
      } else {
        _completer.complete(null);
      }
    } else {
      _completer.complete(null);
    }

    return _completer.future;
  }

  static String origin() {
    if(_repository != null && _repository.origin != null)
      return _repository.origin;

    return "";
  }

  static String credentials() {
    if(_repository != null && _repository.credentials != null)
      return _repository.credentials;

    return "";
  }

  static String url() {
    if(_repository != null && _repository.url != null)
      return _repository.url;

    return "";
  }

  static String username() {
    if(_repository != null && _repository.username != null)
      return _repository.username;

    return "";
  }

  static String password() {
    if(_repository != null && _repository.password != null)
      return _repository.password;

    return "";
  }

  Future<bool> startRepository(Repository repository) async {
    Completer<bool> _completer = new Completer<bool>();
    _repository = repository;
    remote().show().call().then((GitOutput remote) {
      if(remote.isSuccess()) {
        _repository.origin = (remote.object as GitRemote).name;
      }
      _completer.complete(remote.isSuccess());
    }, onError: (e) => _completer.complete(false));

    return _completer.future;
  }


  Branch branch() {
    return Branch(_repository.workDirectory);
  }

  Tag tag() {
    return Tag(_repository.workDirectory);
  }

  Add add() {
    return Add(_repository.workDirectory);
  }

  Fetch fetch() {
    return Fetch(_repository.workDirectory);
  }

  Commit commit() {
    return Commit(_repository.workDirectory);
  }

  Push push() {
    return Push(_repository.workDirectory);
  }

  Pull pull() {
    return Pull(_repository.workDirectory);
  }

  Merge merge() {
    return Merge(_repository.workDirectory);
  }

  Stash stash() {
    return Stash(_repository.workDirectory);
  }

  Checkout checkout() {
    return Checkout(_repository.workDirectory);
  }

  Log log() {
    return Log(_repository.workDirectory);
  }

  Status status() {
    return Status(_repository.workDirectory);
  }

  Restore restore() {
    return Restore(_repository.workDirectory);
  }

  Remote remote() {
    return Remote(_repository.workDirectory);
  }

  Config config() {
    return Config(_repository.workDirectory);
  }

  Clone clone(Repository repository) {
    _repository = repository;
    return Clone(_repository.workDirectory);
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
