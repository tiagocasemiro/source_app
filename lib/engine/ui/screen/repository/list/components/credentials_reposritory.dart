import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:load/load.dart';
import 'package:source_app/engine/domain/model/git_repository.dart';
import 'package:source_app/engine/ui/source_resources.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/dashboard_view.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/dashboard_viewmodel.dart';
import 'package:source_app/engine/ui/widgets/application_load.dart';

class AuthenticationRepositoryAlert {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _failureOnStartRepository = false;

  final Repository _repository;

  AuthenticationRepositoryAlert(this._repository);

  displayAlert(BuildContext context) {
    // ignore: deprecated_member_use
    Widget createButton = RaisedButton(
      color: SourceColors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Text("open",
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w300,
          color: SourceColors.white,
          fontSize: 18.0,
        ),
      ),
      onPressed: () {
        open(context);
      },
    );
    // ignore: deprecated_member_use
    Widget cancelButton = RaisedButton(
      color: SourceColors.grey[5],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Text("cancel",
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w300,
          color: SourceColors.white,
          fontSize: 18.0,
        ),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text("Authentication",
        style: GoogleFonts.balooBhai(
          fontWeight: FontWeight.w300,
          color: SourceColors.blue[2],
          fontSize: 25.0,
        ),
      ),
      actionsPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Container(
        width: 650,
        height: 180,
        child: Form(
          key: _formKey,
          child: Container(
            width: double.maxFinite,
            child: Column(
              children: [
                Container(
                  height: 80,
                  child: TextFormField(
                    controller: _usernameController,
                    cursorColor: SourceColors.blue[2],
                    enableInteractiveSelection : true,
                    autofocus: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Inform your username to selected repository';
                      }
                      return null;
                    },
                    style: TextStyle(
                      fontSize: 20,
                      color: SourceColors.blue[2],
                    ),
                    decoration: InputDecoration(
                      fillColor: SourceColors.grey,
                      focusColor: SourceColors.blue[3],
                      contentPadding: EdgeInsets.all(16),
                      labelText: 'Username',
                      hintStyle: TextStyle(
                        color: SourceColors.blue[2],
                        fontSize: 16,
                      ),
                      labelStyle: TextStyle(
                        fontSize: 20,
                        color: SourceColors.blue[2],
                        height: 0.8,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(5),
                        ),
                        borderSide: new BorderSide(
                          color: SourceColors.blue[6],
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 80,
                  child: TextFormField(
                    controller: _passwordController,
                    cursorColor: SourceColors.blue[2],
                    enableInteractiveSelection : true,
                    keyboardType : TextInputType.visiblePassword,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Inform the password to selected repository';
                      }
                      if(_failureOnStartRepository) {
                        return 'Failed to attempt to start repository. Check username and password';
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      fillColor: SourceColors.grey,
                      focusColor: SourceColors.blue[3],
                      contentPadding: EdgeInsets.all(16),
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(5),
                        ),
                        borderSide: new BorderSide(
                          color: SourceColors.blue[6],
                          width: 1.0,
                        ),
                      ),
                      hintStyle: TextStyle(
                        color: SourceColors.blue[2],
                        fontSize: 16,
                      ),
                      labelStyle: TextStyle(
                        fontSize: 20,
                        color: SourceColors.blue[2],
                        height: 0.8,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 20,
                      color: SourceColors.blue[2],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        SizedBox(
          width: 150,
          height: 40,
          child: cancelButton,
        ),
        SizedBox(
          width: 150,
          height: 40,
          child: createButton,
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LoadingProvider(
          themeData: LoadingThemeData(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            animDuration: Duration(seconds: 1),
            loadingBackgroundColor: SourceColors.grey[5],
          ),
          child: alertDialog);
      },
      barrierDismissible: false,
    );
  }

  void open(BuildContext context) async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    _failureOnStartRepository = false;
    if(_formKey.currentState.validate()) {
      Load.show();
      DashboardViewModel dashboardViewModel = DashboardViewModel();
      _repository.username = username;
      _repository.password = password;
      dashboardViewModel.initRepository(_repository).then((success) {
        if(success) {
          Navigator.of(context, rootNavigator: true).pop('dialog');
          Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
        } else {
          _failureOnStartRepository = true;
          _formKey.currentState.validate();
        }
        Load.hide();
      }, onError: (e) => Load.hide());
    }
  }
}