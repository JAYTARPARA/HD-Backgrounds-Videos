import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  final double size;
  Loading(this.size);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: widget.size,
        ),
      ),
    );
  }
}
