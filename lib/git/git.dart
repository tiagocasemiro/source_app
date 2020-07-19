import 'adapter/BrancheAdapter.dart';
import 'adapter/TagAdapter.dart';
import 'model/Branch.dart';
import 'model/Tag.dart';
import 'shell/Terminal.dart';

class Git {
  String _path;
  Git(this._path);

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
    return _Commit(_path).execute(message);
  }

  Future<bool> push() {
    return _Push(_path).execute();
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
      return true;
    });
  }

  Future<bool> files(List<String> files) {
    List<String> command = ["add"];
    command.addAll(files);
    return Terminal(_path).git(command).then((String terminalOutput) {
      return true;
    });
  }
}

class _Commit {
  String _path;
  _Commit(this._path);

  Future<bool> execute(String message) {
    return Terminal(_path).git(['commit', '-m', message]).then((String terminalOutput) {
      print(terminalOutput);
      return true;
    });
  }
}

class _Push {
  String _path;
  _Push(this._path);

  Future<bool> execute() {
    return Terminal(_path).git(['push']).then((String terminalOutput) {
      return true;
    });
  }
}