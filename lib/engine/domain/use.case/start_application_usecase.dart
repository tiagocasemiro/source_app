import 'package:source_app/engine/database/file/FileUtils.dart';
import 'package:source_app/engine/domain/model/git_remote.dart';
import 'package:source_app/engine/domain/model/git_repository.dart';
import 'package:source_app/engine/shell/git/git.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'dart:async';
import 'dart:io';

class StartApplicationUseCase {
  Future<String> startGitApplicationWithCredentials(Repository repository) async {
    Completer<String> _completer = new Completer<String>();
    Git.repositoryCache = repository;
    await Git().config().store().call();
    GitOutput gitOutputRemote = await Git().config().url().call();

    if(gitOutputRemote.isSuccess()) {
      Git.repositoryCache.url = (gitOutputRemote.object as GitRemote).url;
      Git.repositoryCache.generateCredentials();
      bool isAddedWithSuccess = await FileUtil(Platform.environment['HOME'] + '/.git-credentials').addLine(Git.repositoryCache.credentials);
      if(isAddedWithSuccess) {
        GitOutput gitOutputShow = await Git().remote().show().call();
        if(gitOutputShow.isSuccess()) {
          Git.repositoryCache.origin = (gitOutputShow.object as GitRemote).name;
          _completer.complete(Git.repositoryCache.credentials);
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

  Future<bool> startGitApplication(Repository repository) async {
    Completer<bool> _completer = new Completer<bool>();
    Git.repositoryCache = repository;
    Git().remote().show().call().then((GitOutput remote) {
      if(remote.isSuccess()) {
        Git.repositoryCache.origin = (remote.object as GitRemote).name;
      }
      _completer.complete(remote.isSuccess());
    }, onError: (e) => _completer.complete(false));

    return _completer.future;
  }
}
