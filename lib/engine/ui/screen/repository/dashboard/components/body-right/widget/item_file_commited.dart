import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/domain/model/git_file_modified.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/body_right_viewmodel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:source_app/engine/ui/source_resources.dart';

class ItemFileCommitted extends StatelessWidget {
  final BodyRightViewModel _bodyRightViewModel;
  final GitFileModified fileCommitted;
  final int index;

  const ItemFileCommitted(this.index, this._bodyRightViewModel, this.fileCommitted);

  @override
  Widget build(BuildContext context) {
    String fileName = fileCommitted.name.split("/").last;
    Color background = (index % 2 == 0) ? SourceColors.grey[11] : SourceColors.grey[10];
    SvgPicture icon;

    switch(fileCommitted.typeFile) {
      case  TypeFile.modification: {
        icon = SvgPicture.asset("images/file_modified.svg", width: 22, height: 22);
        break;
      }
      case  TypeFile.delete: {
        icon = SvgPicture.asset("images/file_deleted.svg", width: 22, height: 22);
        break;
      }
      case  TypeFile.conflict: {
        icon = SvgPicture.asset("images/file_conflicted.svg", width: 22, height: 22);
        break;
      }
      case  TypeFile.add: {
        icon = SvgPicture.asset("images/file_addeded.svg", width: 22, height: 22);
        break;
      }
      case  TypeFile.rename: {
        icon = SvgPicture.asset("images/file_renamed.svg", width: 22, height: 22);
        break;
      }
      default: {
        icon = SvgPicture.asset("images/file_modified.svg", width: 22, height: 22);
      }
    }


    return Material(child:
      InkWell(child:
        Container(
          color: background,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                icon,
                Container(width: 8,),
                Text(fileName,
                  style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w400,
                  color: SourceColors.blue[2],
                  fontSize: 12.0,
                ),),
              ],
            ),
          )
        ),
        onTap: () {
          fileCommitted.stageFile = StageFile.committed;
          _bodyRightViewModel.displayFileDiff(fileCommitted);
        },
      )
    );
  }
}
