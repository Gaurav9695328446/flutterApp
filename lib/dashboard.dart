import 'package:desktop_app/storage.dart';
import 'package:flutter/material.dart';
import './dashboard_item.dart';
import './ticket.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new DashboardItem(storage: Storage(), ticketFile: Ticket()),
    );
  }
}
