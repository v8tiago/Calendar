import 'package:flutter/material.dart';
import 'package:login/components/model/event.dart';
import 'package:login/components/myCalendar/my_calendar.dart';
import 'package:login/pages/home/components/app_bar_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.events});

  final Map<String, List<Event>> events;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHome(),
      body: Column(
        children: [
          Expanded(
            child: MyCalendar(events: widget.events),
          ),
        ],
      ),
    );
  }
}
