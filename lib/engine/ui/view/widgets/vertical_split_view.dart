import 'package:flutter/material.dart';

class VerticalSplitView extends StatefulWidget {
  final Widget left;
  final Widget right;
  final double ratio;

  const VerticalSplitView(
      {Key key, @required this.left, @required this.right, this.ratio = 0.3})
      : assert(left != null),
        assert(right != null),
        assert(ratio >= 0),
        assert(ratio <= 1),
        super(key: key);

  @override
  _VerticalSplitViewState createState() => _VerticalSplitViewState();
}

class _VerticalSplitViewState extends State<VerticalSplitView> {
  final _dividerWidth = 16.0;

  //from 0-1
  double _ratio;
  double _maxWidth;

  get _width1 => _ratio * _maxWidth;

  get _width2 => (1 - _ratio) * _maxWidth;

  @override
  void initState() {
    super.initState();
    _ratio = widget.ratio;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      assert(_ratio <= 1);
      assert(_ratio >= 0);
      if (_maxWidth == null) _maxWidth = constraints.maxWidth - _dividerWidth;
      if (_maxWidth != constraints.maxWidth) {
        _maxWidth = constraints.maxWidth - _dividerWidth;
      }

      return SizedBox(
        width: constraints.maxWidth,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: _width1,
              child: widget.left,
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              child: SizedBox(
                width: _dividerWidth,
                height: constraints.maxHeight,
              ),
              onPanUpdate: (DragUpdateDetails details) {
                setState(() {
                  _ratio += details.delta.dx / _maxWidth;
                  if (_ratio > 1)
                    _ratio = 1;
                  else if (_ratio < 0.0) _ratio = 0.0;
                });
              },
            ),
            SizedBox(
              width: _width2,
              child: widget.right,
            ),
          ],
        ),
      );
    });
  }
}
