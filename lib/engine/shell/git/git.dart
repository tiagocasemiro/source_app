import 'package:source_app/engine/domain/model/git_repository.dart';
import 'package:source_app/engine/shell/git/command/checkout.dart';
import 'package:source_app/engine/shell/git/command/clone.dart';
import 'package:source_app/engine/shell/git/command/config.dart';
import 'package:source_app/engine/shell/git/command/diff.dart';
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
  static Repository repositoryCache;

  static String origin() {
    if(repositoryCache != null && repositoryCache.origin != null)
      return repositoryCache.origin;

    return "";
  }

  static String credentials() {
    if(repositoryCache != null && repositoryCache.credentials != null)
      return repositoryCache.credentials;

    return "";
  }

  static String url() {
    if(repositoryCache != null && repositoryCache.url != null)
      return repositoryCache.url;

    return "";
  }

  static String username() {
    if(repositoryCache != null && repositoryCache.username != null)
      return repositoryCache.username;

    return "";
  }

  static String password() {
    if(repositoryCache != null && repositoryCache.password != null)
      return repositoryCache.password;

    return "";
  }

  Branch branch() {
    return Branch(repositoryCache.workDirectory);
  }

  Tag tag() {
    return Tag(repositoryCache.workDirectory);
  }

  Add add() {
    return Add(repositoryCache.workDirectory);
  }

  Fetch fetch() {
    return Fetch(repositoryCache.workDirectory);
  }

  Commit commit() {
    return Commit(repositoryCache.workDirectory);
  }

  Push push() {
    return Push(repositoryCache.workDirectory);
  }

  Pull pull() {
    return Pull(repositoryCache.workDirectory);
  }

  Merge merge() {
    return Merge(repositoryCache.workDirectory);
  }

  Stash stash() {
    return Stash(repositoryCache.workDirectory);
  }

  Checkout checkout() {
    return Checkout(repositoryCache.workDirectory);
  }

  Log log() {
    return Log(repositoryCache.workDirectory);
  }

  Status status() {
    return Status(repositoryCache.workDirectory);
  }

  Restore restore() {
    return Restore(repositoryCache.workDirectory);
  }

  Remote remote() {
    return Remote(repositoryCache.workDirectory);
  }

  Config config() {
    return Config(repositoryCache.workDirectory);
  }

  Diff diff() {
    return Diff(repositoryCache.workDirectory);
  }

  Clone clone(Repository repository) {
    repositoryCache = repository;
    return Clone(repositoryCache.workDirectory);
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
