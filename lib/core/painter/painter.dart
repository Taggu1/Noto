/// Provides a widget and an associated controller for simple painting using touch.
library painter;

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart' hide Image;
import 'package:note_app/core/constants/theme_constants.dart';
import 'package:note_app/core/models/hive_offset.dart';
import 'package:note_app/core/utils/string.dart';

/// A very simple widget that supports drawing using touch.
class Painter extends StatefulWidget {
  final PainterController painterController;
  final bool canDraw;

  /// Creates an instance of this widget that operates on top of the supplied [PainterController].
  Painter(this.painterController, this.canDraw)
      : super(key: ValueKey<PainterController>(painterController));

  @override
  _PainterState createState() => _PainterState();
}

class _PainterState extends State<Painter> {
  bool _finished = false;

  @override
  void initState() {
    super.initState();
    widget.painterController._widgetFinish = _finish;
  }

  Size _finish() {
    setState(() {
      _finished = true;
    });
    return context.size ?? const Size(0, 0);
  }

  @override
  Widget build(BuildContext context) {
    Widget child = CustomPaint(
      willChange: true,
      painter: _PainterPainter(widget.painterController._pathHistory,
          repaint: widget.painterController),
    );
    child = ClipRect(child: child);
    if (!_finished && widget.canDraw) {
      child = GestureDetector(
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
        child: child,
      );
    }
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: child,
    );
  }

  void _onPanStart(DragStartDetails start) {
    Offset pos = (context.findRenderObject() as RenderBox)
        .globalToLocal(start.globalPosition);
    widget.painterController._pathHistory
        .add(pos, color: widget.painterController._drawColor);
    widget.painterController._notifyListeners();
  }

  void _onPanUpdate(DragUpdateDetails update) {
    Offset pos = (context.findRenderObject() as RenderBox)
        .globalToLocal(update.globalPosition);
    widget.painterController._pathHistory.updateCurrent(pos);
    widget.painterController._notifyListeners();
  }

  void _onPanEnd(DragEndDetails end) {
    widget.painterController._pathHistory.endCurrent();
    widget.painterController._notifyListeners();
  }
}

class _PainterPainter extends CustomPainter {
  final _PathHistory _path;

  _PainterPainter(this._path, {Listenable? repaint}) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    _path.draw(canvas, size);
  }

  @override
  bool shouldRepaint(_PainterPainter oldDelegate) {
    return true;
  }
}

class _PathHistory {
  //TODO: wut
  final List<MapEntry<Path, Paint>> _paths;
  final Map<HiveOffset, Map<String, dynamic>> _points;
  Offset _lastStartingPoint;
  Paint currentPaint;
  final Paint _backgroundPaint;
  bool _inDrag;

  bool get isEmpty => _paths.isEmpty || (_paths.length == 1 && _inDrag);

  _PathHistory()
      : _paths = <MapEntry<Path, Paint>>[],
        _inDrag = false,
        _points = {},
        _lastStartingPoint = const Offset(0, 0),
        _backgroundPaint = Paint()..blendMode = BlendMode.dstOver,
        currentPaint = Paint()
          ..color = Colors.black
          ..strokeWidth = 1.0
          ..style = PaintingStyle.fill
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round;

  void setBackgroundColor(Color backgroundColor) {
    _backgroundPaint.color = backgroundColor;
  }

  void undo() {
    if (!_inDrag) {
      _points.remove(_points.keys.last);
      _paths.removeLast();
    }
  }

  void clear() {
    if (!_inDrag) {
      _points.clear();
      _paths.clear();
    }
  }

  void add(Offset startPoint, {Color? color}) {
    if (!_inDrag) {
      _lastStartingPoint = startPoint;
      final point = startPoint.toHiveOffset();
      _points[point] = {};
      _points[point]!["pointsList"] = [];
      _points[point]!["color"] = color.toString();
      _points[point]!["thickness"] = currentPaint.strokeWidth;

      _inDrag = true;
      Path path = Path();
      path.moveTo(startPoint.dx, startPoint.dy);
      _paths.add(MapEntry<Path, Paint>(path, currentPaint));
    }
  }

  void updateCurrent(Offset nextPoint) {
    if (_inDrag) {
      _points[_lastStartingPoint]!["pointsList"].add(nextPoint.toHiveOffset());
      Path path = _paths.last.key;
      path.lineTo(nextPoint.dx, nextPoint.dy);
    }
  }

  void endCurrent() {
    _inDrag = false;
  }

  void draw(Canvas canvas, Size size) {
    canvas.saveLayer(Offset.zero & size, Paint());
    for (MapEntry<Path, Paint> path in _paths) {
      Paint p = path.value;
      canvas.drawPath(path.key, p);
    }
    canvas.drawRect(
        Rect.fromLTWH(0.0, 0.0, size.width, size.height), _backgroundPaint);
    canvas.restore();
  }
}

/// Container that holds the size of a finished drawing and the drawed data as [Picture].
class PictureDetails {
  /// The drawings data as [Picture].
  final Picture picture;

  /// The width of the drawing.
  final int width;

  /// The height of the drawing.
  final int height;

  /// Creates an immutable instance with the given drawing information.
  const PictureDetails(this.picture, this.width, this.height);

  /// Converts the [picture] to an [Image].
  Future<Image> toImage() => picture.toImage(width, height);

  /// Converts the [picture] to a PNG and returns the bytes of the PNG.
  ///
  /// This might throw a [FlutterError], if flutter is not able to convert
  /// the intermediate [Image] to a PNG.
  Future<Uint8List> toPNG() async {
    Image image = await toImage();
    ByteData? data = await image.toByteData(format: ImageByteFormat.png);
    if (data != null) {
      return data.buffer.asUint8List();
    } else {
      throw FlutterError('Flutter failed to convert an Image to bytes!');
    }
  }
}

/// Used with a [Painter] widget to control drawing.
class PainterController extends ChangeNotifier {
  Color _drawColor = const Color.fromARGB(255, 0, 0, 0);
  Color _backgroundColor = const Color.fromARGB(255, 255, 255, 255);
  bool _eraseMode = false;

  double _thickness = 1.0;
  PictureDetails? _cached;
  _PathHistory _pathHistory;
  ValueGetter<Size>? _widgetFinish;

  /// Creates a new instance for the use in a [Painter] widget.
  PainterController() : _pathHistory = _PathHistory();

  /// Returns true if nothing has been drawn yet.
  bool get isEmpty => _pathHistory.isEmpty;

  /// Returns true if the the [PainterController] is currently in erase mode,
  /// false otherwise.
  bool get eraseMode => _eraseMode;

  /// If set to true, erase mode is enabled, until this is called again with
  /// false to disable erase mode.
  set eraseMode(
    bool enabled,
  ) {
    _eraseMode = enabled;
    drawColor = kBlackColor;
    _updatePaint();
  }

  /// Retrieves the current draw color.
  Color get drawColor => _drawColor;

  /// Sets the draw color.
  set drawColor(Color color) {
    _drawColor = color;
    _updatePaint();
  }

  /// Retrieves the current background color.
  Color get backgroundColor => _backgroundColor;

  /// Updates the background color.
  set backgroundColor(Color color) {
    _backgroundColor = color;
    _updatePaint();
  }

  /// Returns the current thickness that is used for drawing.
  double get thickness => _thickness;

  /// Sets the draw thickness..
  set thickness(double t) {
    _thickness = t;
    _updatePaint();
  }

  void _updatePaint() {
    Paint paint = Paint();
    if (_eraseMode) {
      paint.blendMode = BlendMode.clear;
      paint.color = const Color.fromARGB(0, 255, 0, 0);
    } else {
      paint.color = drawColor;
      paint.blendMode = BlendMode.srcOver;
    }
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = thickness;
    paint.strokeCap = StrokeCap.round;
    paint.strokeJoin = StrokeJoin.round;
    _pathHistory.currentPaint = paint;
    _pathHistory.setBackgroundColor(backgroundColor);
    notifyListeners();
  }

  void setOldPaint(Map<HiveOffset, Map<String, dynamic>> offsets) {
    offsets.forEach((startingPoint, nextPoints) {
      final color = (nextPoints["color"] as String).toMaterialColor();
      drawColor = color;
      thickness = nextPoints["thickness"];

      _pathHistory.add(startingPoint, color: color);
      for (int i = 0; i < nextPoints["pointsList"].length; i++) {
        _pathHistory.updateCurrent(nextPoints["pointsList"][i]);
      }
      _pathHistory.endCurrent();
    });
    if (drawColor == kBlackColor) drawColor = Colors.teal;
    _notifyListeners();
  }

  /// Undoes the last drawing action (but not a background color change).
  /// If the picture is already finished, this is a no-op and does nothing.
  void undo() {
    if (!isFinished()) {
      _pathHistory.undo();
      notifyListeners();
    }
  }

  void _notifyListeners() {
    notifyListeners();
  }

  /// Deletes all drawing actions, but does not affect the background.
  /// If the picture is already finished, this is a no-op and does nothing.
  void clear() {
    if (!isFinished()) {
      _pathHistory.clear();
      notifyListeners();
    }
  }

  /// Finishes drawing and returns the rendered [PictureDetails] of the drawing.
  /// The drawing is cached and on subsequent calls to this method, the cached
  /// drawing is returned.
  ///
  /// This might throw a [StateError] if this PainterController is not attached
  /// to a widget, or the associated widget's [Size.isEmpty].
  PictureDetails finish() {
    if (!isFinished()) {
      if (_widgetFinish != null) {
        _cached = _render(_widgetFinish!());
      } else {
        throw StateError(
            'Called finish on a PainterController that was not connected to a widget yet!');
      }
    }
    return _cached!;
  }

  Map<HiveOffset, Map<String, dynamic>> getMapOfOffsets() {
    return _pathHistory._points;
  }

  PictureDetails _render(Size size) {
    if (size.isEmpty) {
      throw StateError('Tried to render a picture with an invalid size!');
    } else {
      PictureRecorder recorder = PictureRecorder();
      Canvas canvas = Canvas(recorder);
      _pathHistory.draw(canvas, size);
      return PictureDetails(
          recorder.endRecording(), size.width.floor(), size.height.floor());
    }
  }

  /// Returns true if this drawing is finished.
  ///
  /// Trying to modify a finished drawing is a no-op.
  bool isFinished() {
    return _cached != null;
  }
}
