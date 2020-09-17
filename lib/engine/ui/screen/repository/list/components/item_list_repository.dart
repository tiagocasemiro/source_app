import 'package:flutter/material.dart';
import 'package:source_app/engine/domain/model/git_repository.dart';
import 'package:source_app/engine/domain/use.case/start_application_usecase.dart';
import 'package:source_app/engine/ui/source_resources.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/dashboard_view.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/dashboard_viewmodel.dart';
import 'package:source_app/engine/ui/screen/repository/list/components/credentials_reposritory.dart';
import 'package:source_app/engine/ui/screen/repository/list/list_repositories_viewmodel.dart';

class RepositoryItem extends StatelessWidget {
  final Repository repository;
  final SelectRepositoryViewModel _viewModel;

  RepositoryItem(this.repository, this._viewModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 86,
      margin: const EdgeInsets.only(left: 8.0, top: 1.0, right: 8.0, bottom: 1.0,),
      decoration: BoxDecoration(
          color: SourceColors.grey,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 38,
                  height: 38,
                  child: Image.asset("images/logo-grey.png"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                child: VerticalDivider(
                  color: SourceColors.grey[5],
                  width: 2
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text(
                    repository.name,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w900,
                      color: SourceColors.blue[2],
                      fontSize: 15.0,
                    ),
                  ),
                  subtitle: Text(
                    repository.workDirectory,
                    style: GoogleFonts.roboto(
                      color: SourceColors.blue[2],
                      fontSize: 13.0,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                width: 50,
                height: 50,
                child: Image.asset("images/delete-repository.png"),
              ),
            ],
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              hoverColor: SourceColors.blue[4],
              focusColor: SourceColors.blue[4],
              splashColor: SourceColors.blue[5],
              onTap: () {
                _viewModel.statusInput.add(repository);
              },
              onDoubleTap: () {
                _viewModel.hasCredential(repository).then((hasCredential) {
                  if(hasCredential) {
                    StartApplicationUseCase().startGitApplication(repository.workDirectory).then((isSuccess) {
                      if(isSuccess) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return Dashboard(DashboardViewModel());
                        }));
                      }
                    });
                  } else {
                    AuthenticationRepositoryAlert(repository).displayAlert(context);
                  }
                });
              },
            ),
          ),
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  margin: const EdgeInsets.all(9),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      hoverColor: SourceColors.blue[4],
                      focusColor: SourceColors.blue[4],
                      splashColor: SourceColors.blue[5],
                      onTap: () {
                        print("Delete repository " + repository.name);
                        _viewModel.deleteInput.add(repository);
                      },
                    ),
                  ),
                )
              ],
            ),
          )
        ]
      ),
    );
  }
}
