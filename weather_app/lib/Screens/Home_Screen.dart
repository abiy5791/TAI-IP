// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/bloc/weather_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget getWeatherIcon(int IconCode) {
    switch (IconCode) {
      case > 200 && <= 300:
        return Image.asset("assets/tund.png");
      case >= 300 && < 400:
        return Image.asset("assets/fuz.png");
      case > 500 && <= 600:
        return Image.asset("assets/umb.png");
      case >= 600 && < 700:
        return Image.asset("assets/snow.png");
      case > 700 && <= 800:
        return Image.asset("assets/rain.png");
      case == 800:
        return Image.asset("assets/sun.png");
      case > 800 && <= 804:
        return Image.asset("assets/cloud.png");
      default:
        return Image.asset("assets/cloud.png");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(40, kToolbarHeight, 40, 25),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional(4, -0.3),
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.deepPurple),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-4, -0.3),
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.deepPurple),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0, -1.4),
                  child: Container(
                    width: 600,
                    height: 300,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle, color: Color(0xFFFFAB40)),
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.transparent),
                  ),
                ),
                BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherBlocSuccess) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Color(0xFFCE5A67),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  state.weather.areaName!,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            Text(
                              DateFormat("EEEE dd .")
                                  .add_jm()
                                  .format(state.weather.date!),
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 4,
                                child: getWeatherIcon(
                                    state.weather.weatherConditionCode!)),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    "${state.weather.temperature!.celsius!.round()} \u2103",
                                    style: TextStyle(
                                        fontSize: 65,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    state.weather.weatherMain!.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/sun.png",
                                      scale: 25,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Sunrise",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          DateFormat()
                                              .add_jm()
                                              .format(state.weather.sunrise!),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/moon.png",
                                      scale: 45,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Sunset",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          DateFormat()
                                              .add_jm()
                                              .format(state.weather.sunset!),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/lowtemp.png",
                                      scale: 45,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Temp Min",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "${state.weather.tempMin!.celsius!.round()} \u2103",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/htemp.png",
                                      scale: 45,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Temp High",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "${state.weather.tempMax!.celsius!.round()} \u2103",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Scaffold(
                        backgroundColor: Colors.transparent,
                        body: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
