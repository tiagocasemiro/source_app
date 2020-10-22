import 'package:flutter/material.dart';
import 'package:source_app/engine/domain/model/git_commit.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/body_right_viewmodel.dart';

class CommitDetailsDescription extends StatelessWidget {
  final BodyRightViewModel _bodyRightViewModel;
  final GitCommit _commitDetails;

  CommitDetailsDescription(this._bodyRightViewModel, this._commitDetails);

  @override
  Widget build(BuildContext context) {
    String message = _commitDetails != null ? _commitDetails.message : "Empty";
    return Container(child: Text(message),);
  }
}
