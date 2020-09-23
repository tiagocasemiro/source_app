import 'package:source_app/engine/domain/model/git_tag.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-left/body_left_viewmodel.dart';
import 'package:source_app/engine/ui/source_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/ui/widgets/application_load.dart';
import 'package:source_app/engine/ui/widgets/gitoutput_error_alert.dart';
import 'package:source_app/engine/ui/widgets/notify.dart';


class TagsDashboard extends StatefulWidget {
  final BodyLeftViewModel _dashboardViewModel;

  TagsDashboard(this._dashboardViewModel);

  @override
  _TagsState createState() => _TagsState(_dashboardViewModel);
}

class _TagsState extends State<TagsDashboard> {
  final BodyLeftViewModel _bodyLeftViewModel;

  _TagsState(this._bodyLeftViewModel);

  @override
  Widget build(BuildContext context) {
   final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
   return Theme(
     data: theme,
     isMaterialAppTheme: true,
     child: Container(
       width: double.maxFinite,
       decoration: BoxDecoration(
         color: SourceColors.grey[2],
         borderRadius: BorderRadius.circular(10),
       ),
       child: SingleChildScrollView(
         child: ExpansionTile(
           childrenPadding: const EdgeInsets.only(right: 0, top: 0, left: 0, bottom: 16),
           title: Container(
             height: 32,
             child: ListTile(
               contentPadding: const EdgeInsets.all(0),
               title:Align(
                 child: Transform(
                   transform: Matrix4.translationValues(-26, -8, 0.0),
                   child: Text("Tag", style: GoogleFonts.roboto(
                     fontWeight: FontWeight.w700,
                     color: SourceColors.blue[2],
                     fontSize: 16.0,
                   ),),
                 ),
                 alignment: Alignment.centerLeft,
               ),
               leading: Transform(
                   transform: Matrix4.translationValues(-0, -8, 0.0),
                   child: Image.asset("images/ic_tags.png", width: 16, height: 16)
               ),
             ),
           ),
           children: <Widget>[
             FutureBuilder(
               initialData: [],
               future: _bodyLeftViewModel.tags(),
               builder: (context, snapshot) {
                 List<GitTag> tags = List<GitTag>();
                 if (snapshot.data is GitOutput) {
                   GitOutput gitOutput = snapshot.data;

                   tags = gitOutput.isSuccess() &&
                       gitOutput.object != null &&
                       gitOutput.object is List<GitTag> ? gitOutput.object : List<GitTag>();
                }

                 return Visibility(
                   visible: tags.isNotEmpty,
                   replacement: Center(child: snapshot.connectionState != ConnectionState.done? CircularProgressIndicator(): Text("No tags", style: GoogleFonts.roboto(
                   fontWeight: FontWeight.w300,
                     color: SourceColors.blue[2],
                     fontSize: 14.0,
                   ),)),
                   child: new Column(
                     children: _buildExpandableContent(tags),
                   ),
                 );
               },
             ),
           ],
           trailing: Image.asset("images/down-indicator.png", width: 15.5, height: 8),
           initiallyExpanded: false,
         ),
       ),
     ),
   );
  }

  _buildExpandableContent(List<GitTag> tags) {
    List<Widget> columnContent = [];
    for (GitTag tag in tags) {
      columnContent.add(_buildTag(tag));
    }
    return columnContent;
  }

  Widget _buildTag(GitTag tag) {
    TextStyle allTags = GoogleFonts.roboto(
      fontWeight: FontWeight.w500,
      color: SourceColors.blue[2],
      fontSize: 16.0,
    );

    return Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          hoverColor: SourceColors.blue[4],
          focusColor: SourceColors.blue[4],
          splashColor: SourceColors.blue[5],
          child: Container(
            height: 32,
            child: Transform(
              transform: Matrix4.translationValues(0, -8, 0),
              child: ListTile(
                contentPadding: EdgeInsets.only(left: 16, bottom: 0, top: 0, right: 0),
                title: Align(
                  child: Transform(
                    transform: Matrix4.translationValues(-32, 0.0, 0.0),
                    child: Text(tag.name, style: allTags, maxLines: 1,),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                leading: RotatedBox(quarterTurns: 3,
                    child: Image.asset(
                        "images/down-indicator.png", width: 15.5, height: 8)),
                mouseCursor: SystemMouseCursors.click,
              ),
            ),
          ),
          onDoubleTap: () {
            Load.show();
            _bodyLeftViewModel.checkoutTag(tag).then((GitOutput gitOutput) {
              if(gitOutput.isFailure()) {
                GitOutputErrorAlert(context).displayAlert(gitOutput.message);
              } else {
                Notify(context).showSuccessWithMessage(gitOutput);
              }
              Load.hide();
            }, onError: (e) => Load.hide());
          },
        ),
      ),
    );
  }
}
