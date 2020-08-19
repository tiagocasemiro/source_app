
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/domain/model/git_repository.dart';
import 'package:source_app/engine/ui/source_resources.dart';
import 'package:source_app/engine/ui/view/repository/list/list_repositories_viewmodel.dart';

class AddLocalRepository {
  final _nameController = TextEditingController();
  final _workDirController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isWorkDirInvalid = true;
  bool _isWorkDirEmpty = true;
  bool _isNameEmpty = true;

  final SelectRepositoryViewModel _viewModel;

  AddLocalRepository(this._viewModel);

  displayAlert(BuildContext context) {
    Widget createButton = RaisedButton(
      color: SourceColors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Text("Create",
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w300,
          color: SourceColors.white,
          fontSize: 18.0,
        ),
      ),
      onPressed: () {
        saveRepository(context);
      },
    );
    Widget cancelButton = RaisedButton(
      color: SourceColors.grey[5],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Text("Cancel",
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
      title: Text("New repository",
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
                      if(_isWorkDirInvalid) {
                        return 'Is not valid directory';
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
                          _workDirController.text = "/home/tiagocasemiro/Documentos/projetos/ayla/ayla-package-application-salesman";
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
        return alertDialog;
      },
      barrierDismissible: false,
    );
  }

  void saveRepository(BuildContext context) {
    String name = _nameController.text;
    String workDirectory = _workDirController.text;
    Repository repository = Repository(name, workDirectory);
    _isNameEmpty = name.isEmpty;
    _isWorkDirEmpty = workDirectory.isEmpty;

    if(_isNameEmpty == false && _isWorkDirEmpty == false) {
      _viewModel.save(repository).then((bool success) {
        if (success) {
          _viewModel.statusInput.add(null);
          Navigator.of(context, rootNavigator: true).pop('dialog');
        } else {
          _formKey.currentState.validate();
        }
      });
    } else {
      _formKey.currentState.validate();
    }
  }
}