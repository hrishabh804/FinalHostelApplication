import 'package:bloc/bloc.dart';
import 'package:hostel_project/pages/student_page.dart';
enum NavigationEvents {
  StudentPageClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  NavigationBloc();




  @override
  NavigationStates get initialState => StudentPage();

  get name => name;

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.StudentPageClickedEvent:
        yield StudentPage();
        break;
    }
  }
}