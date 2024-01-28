import 'package:dish_discover/entities/ticket.dart';
import 'package:dish_discover/entities/user.dart';
import 'package:flutter/foundation.dart';

abstract class AppState {
  static const String serverDomain =
      kDebugMode ? "localhost:8000" : "localhost:8000";
  static const String clientDomain =
      kDebugMode ? "localhost:????" : "localhost:????";
  static User? currentUser;
  static Ticket? currentTicket;
}
