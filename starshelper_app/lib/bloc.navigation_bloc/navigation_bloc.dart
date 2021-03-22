import 'package:bloc/bloc.dart';
import '../pages/myaccountspage.dart';
import '../pages/courseswap.dart';
import '../pages/homepage.dart';
import '../pages/timetable/index.dart';
import '../utils/global.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  MyAccountClickedEvent,
  CourseswapClickedEvent,
  CourseplanClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  
  NavigationBloc(): super(Global().appData["sidebar_initpage"] == null ? HomePage() : Global().appData["sidebar_initpage"]);

  @override
  NavigationStates get initialState => Global().appData["sidebar_initpage"] == null ? HomePage() : Global().appData["sidebar_initpage"];

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomePageClickedEvent:
        yield HomePage();
        break;
      case NavigationEvents.MyAccountClickedEvent:
        yield MyAccountsPage();
        break;
      case NavigationEvents.CourseswapClickedEvent:
        yield CourseSwapPage();
        break;
      case NavigationEvents.CourseplanClickedEvent:
        yield TTHomePage(title: 'Home');
    }
  }
}
