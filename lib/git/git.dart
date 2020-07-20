import 'package:source_app/git/adapter/AddAdapter.dart';
import 'package:source_app/git/adapter/CommitAdapter.dart';
import 'package:source_app/git/adapter/PushAdapter.dart';
import 'adapter/BranchAdapter.dart';
import 'adapter/TagAdapter.dart';
import 'model/Branch.dart';
import 'model/Tag.dart';
import 'shell/Terminal.dart';

class Git {
  final String _workDirectory = "/home/tiagocasemiro/Documentos/projetos/pessoal/documentation";
  final String _host = "github.com";
  final String _repository = "tiagocasemiro/documentation.git";

  String _originWithCredential(String user, String password) {
    return "https://$user:$password@$_host/$_repository";
  }

  _Branch branch() {
    return _Branch(_workDirectory);
  }

  _Tag tag() {
    return _Tag(_workDirectory);
  }

  _Add add() {
    return _Add(_workDirectory);
  }

  Future<bool> commit(String message) {
    return Terminal(_workDirectory).run("git", parameters: ['commit', '-m', message]).then((String terminalOutput) {
      return CommitAdapter().confirm(terminalOutput);
    });
  }

  Future<bool> push(String username, String password) {
    return Terminal(_workDirectory).run("git", parameters: ['push', _originWithCredential(username, password)]).then((String terminalOutput) {
      return PushAdapter().confirm(terminalOutput);
    });
  }

  Future<bool> fetch() {
    return Terminal(_workDirectory).run("git", parameters: ['fetch']).then((String terminalOutput) {
      return PushAdapter().confirm(terminalOutput);
    });
  }

  Future<bool> pull() {
    return Terminal(_workDirectory).run("git", parameters: ['pull']).then((String terminalOutput) {
      return PushAdapter().confirm(terminalOutput);
    });
  }
}

class _Branch {
  String _workDirectory;
  _Branch(this._workDirectory);

  Future<List<Branch>> remote() {
    return Terminal(_workDirectory).run("git", parameters: ['branch', '-r']).then((String terminalOutput) {
      return BranchAdapter().toBranches(terminalOutput != null ? terminalOutput: "");
    });
  }

  Future<List<Branch>> local() {
    return Terminal(_workDirectory).run("git", parameters: ['branch']).then((String terminalOutput) {
      return BranchAdapter().toBranches(terminalOutput != null ? terminalOutput: "");
    });
  }

  Future<Branch> current() {
    return Terminal(_workDirectory).run("git", parameters: ['branch']).then((String terminalOutput) {
      return BranchAdapter().toBranch(terminalOutput != null ? terminalOutput: "");
    });
  }
}

class _Tag {
  String _workDirectory;
  _Tag(this._workDirectory);

  Future<List<Tag>> all() {
    return Terminal(_workDirectory).run("git", parameters: ['tag']).then((String terminalOutput) {
      return TagAdapter().toTags(terminalOutput != null ? terminalOutput: "");
    });
  }
}

class _Add {
  String _workDirectory;
  _Add(this._workDirectory);

  Future<bool> all() {
    return Terminal(_workDirectory).run("git", parameters: ['add', '.']).then((String terminalOutput) {
      return AddAdapter().allConfirm(terminalOutput);
    });
  }

  Future<bool> files(List<String> files) {
    List<String> parameters = ["add"];
    parameters.addAll(files);
    return Terminal(_workDirectory).run("git", parameters: parameters).then((String terminalOutput) {
      return AddAdapter().filesConfirm(terminalOutput);
    });
  }
}