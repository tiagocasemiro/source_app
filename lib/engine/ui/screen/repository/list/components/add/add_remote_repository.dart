import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/domain/model/git_repository.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/ui/source_resources.dart';
import 'package:source_app/engine/ui/utils/file_choose.dart';
import 'package:source_app/engine/ui/screen/repository/list/list_repositories_viewmodel.dart';

class AddRemoteRepository {
  final _nameController = TextEditingController();
  final _workDirController = TextEditingController();
  final _urlController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isWorkDirEmpty = true;
  bool _isNameEmpty = true;
  bool _isUrlEmpty = true;
  bool _commandFailure = false;

  final SelectRepositoryViewModel _selectRepositoryViewModel;

  AddRemoteRepository(this._selectRepositoryViewModel);

  displayAlert(BuildContext context) {
    Widget cloneButton = RaisedButton(
      color: SourceColors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Text("clone",
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w300,
          color: SourceColors.white,
          fontSize: 18.0,
        ),
      ),
      onPressed: () {
        validateAndSaveRepository(context);
      },
    );
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
      title: Text("Clone repository",
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
        height: 400,
        child: Form(
          key: _formKey,
          child: Container(
            width: double.maxFinite,
            child: Column(
              children: [
                Container(
                  height: 80,
                  child: TextFormField(
                    controller: _nameController,
                    cursorColor: SourceColors.blue[2],
                    enableInteractiveSelection : true,
                    autofocus: true,
                    validator: (value) {
                      if (_isNameEmpty) {
                        return 'Inform the name of repository';
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
                      labelText: 'Name',
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
                    controller: _workDirController,
                    cursorColor: SourceColors.blue[2],
                    enableInteractiveSelection : true,
                    validator: (value) {
                      if (_isWorkDirEmpty) {
                        return 'Inform the work directory of repository';
                      }
                      if(_commandFailure) {
                        return 'Verify work directory';
                      }

                      return null;
                    },                   
                    decoration: InputDecoration(
                      fillColor: SourceColors.grey,
                      focusColor: SourceColors.blue[3],
                      contentPadding: EdgeInsets.all(16),
                      labelText: 'Work directory',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.folder,
                          color: SourceColors.blue[6],
                        ),
                        onPressed: () {
                          pickDirectory().then((value) {
                            String path = value.toString();
                            if(path != null && path.isNotEmpty && path != "null") {
                              _workDirController.text = value.toString();
                            }
                          });
                        },
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
                Container(
                  height: 80,
                  child: TextFormField(
                    controller: _urlController,
                    cursorColor: SourceColors.blue[2],
                    enableInteractiveSelection : true,
                    autofocus: true,
                    validator: (value) {
                      if (_isUrlEmpty) {
                        return 'Inform the url of repository';
                      }
                      if(_commandFailure) {
                        return 'Verify url, put credentials on url if need';
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
                      labelText: 'Url',
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
          child: cloneButton,
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
      barrierDismissible: false,
    );
  }
  void cloneRepository(Repository repository, String username, String password, {void onClone(Repository repository), void onFailure()}) async {
    repository.generateCredentials(username, password);
    GitOutput gitOutput = await _selectRepositoryViewModel.clone(repository);
    if(gitOutput != null && gitOutput.isSuccess()) {
      onClone(repository);
    } else {
      onFailure();
    }
  }

  void validateAndSaveRepository(BuildContext context) async {
    _commandFailure = false;
    String name = _nameController.text;
    String workDirectory = _workDirController.text;
    String url = _urlController.text;
    String username = _usernameController.text;
    String password = _passwordController.text;
    Repository repository = Repository(name, workDirectory, url: url);
    _isNameEmpty = name.isEmpty;
    _isWorkDirEmpty = workDirectory.isEmpty;
    _isUrlEmpty = url.isEmpty;

    if(_isNameEmpty == false && _isWorkDirEmpty == false && _isUrlEmpty == false) {
      cloneRepository(repository, username, password,
        onClone: (repository) {
          _selectRepositoryViewModel.save(repository).then((GitOutput gitOutput) {
            if(gitOutput.isSuccess()) {
              Navigator.of(context, rootNavigator: true).pop('dialog');
            }
          });
        }, 
        onFailure: () {
          _commandFailure = true;
          _formKey.currentState.validate();
        }
      );     
    }
    _formKey.currentState.validate();
  }
}