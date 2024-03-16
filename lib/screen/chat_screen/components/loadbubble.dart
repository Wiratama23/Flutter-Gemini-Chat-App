import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadComp extends StatelessWidget {
  const LoadComp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: SpinKitThreeBounce(
            color: Colors.black12,
            size: 50,
          )
        )
    );
  }
}