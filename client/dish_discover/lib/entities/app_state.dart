import 'package:dish_discover/entities/ticket.dart';
import 'package:dish_discover/entities/user.dart';

abstract class AppState {
  static User? currentUser;
  static Ticket? currentTicket;
}
