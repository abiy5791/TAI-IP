// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

class FlashlightScreen extends StatefulWidget {
  const FlashlightScreen({super.key});

  @override
  State<FlashlightScreen> createState() => _FlashlightScreenState();
}

class _FlashlightScreenState extends State<FlashlightScreen> {
  bool _isAvailable = false;
  @override
  void initState() {
    super.initState();
    _CheckTorchAvailability;
  }

  _CheckTorchAvailability() async {
    final isTorchAvailable = await TorchLight.isTorchAvailable();
    setState(() {
      _isAvailable = isTorchAvailable;
    });
  }

  _TorchToggle() async {
    if (!_isAvailable) {
      await TorchLight.enableTorch();
    } else {
      await TorchLight.disableTorch();
    }
    setState(() {
      _isAvailable = !_isAvailable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          "Flash Light",
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 25, color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _isAvailable
              ? Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red),
                      ),
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.transparent),
                      ),
                    )
                  ],
                )
              : Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                      ),
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.transparent),
                      ),
                    )
                  ],
                ),
          GestureDetector(
            onTap: _TorchToggle,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _isAvailable
                      ? Icon(
                          Icons.flashlight_on,
                          size: 70,
                          color: Colors.amber,
                        )
                      : Icon(
                          Icons.flashlight_off,
                          color: Colors.black,
                          size: 70,
                        ),
                  _isAvailable
                      ? Text(
                          "ON",
                          style: TextStyle(
                              color: Colors.amber,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        )
                      : Text(
                          "OFF",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
