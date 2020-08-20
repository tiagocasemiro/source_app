import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HorizontalSplitView extends StatefulWidget {
  final Widget up;
  final Widget down;
  final double ratio;
  final double minRatio;

  const HorizontalSplitView(
      {Key key, @required this.up, @required this.down, this.ratio = 0.5, this.minRatio = 0})
      : assert(up != null),
        assert(down != null),
        assert(ratio >= 0),
        assert(ratio <= 1),
        super(key: key);

  @override
  _HorizontalSplitViewState createState() => _HorizontalSplitViewState(minRatio);
}

class _HorizontalSplitViewState extends State<HorizontalSplitView> {
  final _dividerHeight = 16.0;
  double _ratio; //from 0-1
  double _maxHeight;
  final double _minRatio;
  _HorizontalSplitViewState(this._minRatio);
  get _height1 {
    double newHeight1 = _ratio * _maxHeight;
    return newHeight1 < _minHeight1? _minHeight1 : newHeight1;
  }
  get _height2 {
    double newHeight1 = _ratio * _maxHeight;
    return newHeight1 < _minHeight1? ( _maxHeight - _minHeight1 ) : (1 - _ratio) * _maxHeight;
  }
  get _minHeight1 => _minRatio * _maxHeight;

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
      if (_maxHeight == null) _maxHeight = constraints.maxHeight - _dividerHeight;
      if (_maxHeight != constraints.maxHeight) {
        _maxHeight = constraints.maxHeight - _dividerHeight;
      }

      return SizedBox(
        height: constraints.maxHeight,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: _height1,
              child: widget.up,
            ),
            GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: MouseRegion(
                  cursor: SystemMouseCursors.resizeUpDown,
                  child: SizedBox(
                  width: constraints.maxWidth,
                  height: _dividerHeight,
                ),
                ),
                onPanUpdate: (DragUpdateDetails details) {
                  setState(() {
                    _ratio += details.delta.dy / _maxHeight;
                    if (_ratio > 1)
                      _ratio = 1;
                    else if (_ratio < 0.0)
                      _ratio = 0.0;
                  });
                },
              ),

            SizedBox(
              height: _height2,
              child: widget.down,
            ),
          ],
        ),
      );
    });
  }
}
