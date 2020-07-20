import 'package:source_app/git/adapter/AddAdapter.dart';
import 'package:source_app/git/adapter/CommitAdapter.dart';
import 'package:source_app/git/adapter/PushAdapter.dart';
import 'adapter/BrancheAdapter.dart';
import 'adapter/TagAdapter.dart';
import 'model/Branch.dart';
import 'model/Tag.dart';
import 'shell/Terminal.dart';

class Git {
  String _path;
  final String _originWithCredential;

  Git(this._path, {String user, String password, String host, String repository}) : _originWithCredential="https://$user:$password@$host/$repository";

  _Branch branch() {
    return _Branch(_path);
  }

  _Tag tag() {
    return _Tag(_path);
  }

  _Add add() {
    return _Add(_path);
  }

  Future<bool> commit(String message) {
    return Terminal(_path).git(['commit', '-m', message]).then((String terminalOutput) {
      return CommitAdapter().commitConfirm(terminalOutput);
    });
  }

  Future<bool> push() {
    return Terminal(_path).git(['push', _originWithCredential]).then((String terminalOutput) {
      return PushAdapter().pushConfirm(terminalOutput);
    });
  }
}

class _Branch {
  String _path;
  _Branch(this._path);

  Future<List<Branch>> remote() {
    return Terminal(_path).git(['branch', '-r']).then((String terminalOutput) {
      return BranchAdapter().toBranches(terminalOutput != null ? terminalOutput: "");
    });
  }

  Future<List<Branch>> local() {
    return Terminal(_path).git(['branch']).then((String terminalOutput) {
      return BranchAdapter().toBranches(terminalOutput != null ? terminalOutput: "");
    });
  }

  Future<Branch> current() {
    return Terminal(_path).git(['branch']).then((String terminalOutput) {
      return BranchAdapter().toBranch(terminalOutput != null ? terminalOutput: "");
    });
  }
}

class _Tag {
  String _path;
  _Tag(this._path);

  Future<List<Tag>> all() {
    return Terminal(_path).git(['tag']).then((String terminalOutput) {
      return TagAdapter().toTags(terminalOutput != null ? terminalOutput: "");
    });
  }
}

class _Add {
  String _path;
  _Add(this._path);

  Future<bool> all() {
    return Terminal(_path).git(['add', '.']).then((String terminalOutput) {
      return AddAdapter().allConfirm(terminalOutput);
    });
  }

  Future<bool> files(List<String> files) {
    List<String> command = ["add"];
    command.addAll(files);
    return Terminal(_path).git(command).then((String terminalOutput) {
      return AddAdapter().filesConfirm(terminalOutput);
    });
  }
}