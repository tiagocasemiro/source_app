import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:source_app/engine/ui/source_resources.dart';

Widget _menu(List<ItemContextMenu> menus) {
  return  Card(
    color: SourceColors.white,
    child: Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children:_buildMenus(menus)
      ),
    ),
  );
}

List<Widget> _buildMenus(List<ItemContextMenu> menus) {
  List<Widget> widgetsMenu = [];
  TextStyle styleMenuLine = GoogleFonts.roboto(
    fontWeight: FontWeight.w500,
    color: SourceColors.blue[2],
    fontSize: 16.0,
  );

  menus.forEach((menu) {
    widgetsMenu.add(TextButton(
      onPressed: () {
        menu.onPressed();
        BotToast.cleanAll();
      },
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 70, maxWidth: 140),
        child: Row(children: [
          Icon(menu.icon, color: SourceColors.blue[2]),
          Container(width: 10,),
          Text(menu.label, style: styleMenuLine,),
        ]),
      ),
    ));
  });

  return widgetsMenu;
}

CancelFunc _show(BuildContext context, List<ItemContextMenu> menus) {
  return BotToast.showAttachedWidget(
      attachedBuilder: (_) => Card(
        color:  SourceColors.white,
        child: _menu(menus),
      ),
      animationDuration: Duration(milliseconds: 300),
      enableSafeArea: false,
      targetContext: context,
      preferDirection: PreferDirection.bottomCenter
  );
}

Widget contextMenu(Widget widget, List<ItemContextMenu> menus) {
  return Builder(
      builder: (context) {
        return GestureDetector(
          child: widget,
          onSecondaryTap: () {
            _show(context, menus);
          },
        );
      }
  );
}

class ItemContextMenu {
  IconData icon;
  String label;
  VoidCallback onPressed;

  ItemContextMenu(this.icon, this.label, this.onPressed);
}