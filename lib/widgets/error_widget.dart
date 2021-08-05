import 'package:flutter/material.dart';

class NetworkErrorWidget extends StatelessWidget {
  const NetworkErrorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 100,
        constraints: const BoxConstraints.expand(),
        child: FittedBox(
          fit: BoxFit.none,
          child: SizedBox(
            height: 100,
            width: 250,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: const [
                    Icon(Icons.error_outline, color: Colors.red,),
                    Text("Error something went wrong!")
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
        ),
      ),
    );
  }
}
