import 'package:flutter/material.dart';
import 'package:source_app/engine/domain/use.case/start_repository_usecase.dart';
import 'engine/domain/use.case/add_repository_usecase.dart';
import 'engine/presenter/view/main_view.dart';
import 'engine/shell/git/command/log.dart';
import 'engine/shell/git/git.dart';


void main() {
  runApp(MainView());

  //Git().add().all().call().then((branches) => print(branches));
  //Git().commit().message("commitado pelo app").call().then((branches) => print(branches));
  //Git().push("tiagocasemiro", "password").then((branches) => print(branches));
  //Git().add().all().call().then((value) => print(value));
  //Git().checkout().branch("develop").call().then((value) => print(value));
  //Git().branch().delete("develop").call().then((branches) => print(branches));
  //Git().isGitDirectory().then((branches) => print(branches));
  //Git().log().graph().pretty(Log.historyFormat).call().then((branches) => print(branches));
  //Git().restore().files(['cument_5.txt']).call();

  String workDirectory = "/home/tiagocasemiro/Documentos/projetos/pessoal/documentation";
  String host = "github.com";
  String pathDotGit = "tiagocasemiro/documentation.git";
  String username = "tiagocasemiro";
  String password = "";

  AddRepositoryUseCase().localRepository("Documentation", workDirectory).then((value) => print(value)); //TODO work on linux?
//  StartRepositoryUseCase().startGitApplication(workDirectory, username, password).then((value) => print(value));
}
