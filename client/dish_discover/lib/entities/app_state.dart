import 'package:dish_discover/entities/ticket.dart';
import 'package:dish_discover/entities/user.dart';

abstract class AppState {
  static Duration timeout = const Duration(minutes: 1);
  static User? currentUser;
  static Ticket? currentTicket;
}
