import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class VerticalSplitView extends StatefulWidget {
  final Widget left;
  final Widget right;
  final double ratio;
  final double minRatio;

  const VerticalSplitView(
      {Key key, @required this.left, @required this.right, this.ratio = 0.5, this.minRatio = 0})
      : assert(left != null),
        assert(right != null),
        assert(ratio >= 0),
        assert(ratio <= 1),
        super(key: key);

  @override
  _VerticalSplitViewState createState() => _VerticalSplitViewState(minRatio);
}

class _VerticalSplitViewState extends State<VerticalSplitView> {
  final _dividerWidth = 16.0;
  double _ratio; //from 0-1
  double _maxWidth;
  final double _minRatio;
  _VerticalSplitViewState(this._minRatio);
  get _width1 {
    double newWidth1 = _ratio * _maxWidth;
    return newWidth1 < _minWidth1? _minWidth1 : newWidth1;
  }
  get _width2 {
    double newWidth1 = _ratio * _maxWidth;
    return newWidth1 < _minWidth1? ( _maxWidth - _minWidth1 ) : (1 - _ratio) * _maxWidth;
  }
  get _minWidth1 => _minRatio * _maxWidth;

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
                child: MouseRegion(
                  cursor: SystemMouseCursors.resizeLeftRight,
                  child: SizedBox(
                  width: _dividerWidth,
                  height: constraints.maxHeight,
                ),
                ),
                onPanUpdate: (DragUpdateDetails details) {
                  setState(() {
                    _ratio += details.delta.dx / _maxWidth;
                    if (_ratio > 1)
                      _ratio = 1;
                    else if (_ratio < 0.0)
                      _ratio = 0.0;
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
