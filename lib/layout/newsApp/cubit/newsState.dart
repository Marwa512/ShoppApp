// ignore_for_file: camel_case_types

abstract class newsAppState {}

class newsAppInitialState extends newsAppState {}

class BottomNavBarState extends newsAppState {}

class newsGetBusinessLoadingData extends newsAppState {}

class newsGetBusinessSuccesssData extends newsAppState {}

class newsGetBusinessLErorData extends newsAppState {
  newsGetBusinessLErorData(String string);
}

class newsGetSportsLoadingData extends newsAppState {}

class newsGetSportsSuccesssData extends newsAppState {}

class newsGetSportsLErorData extends newsAppState {
  newsGetSportsLErorData(String string);
}

class newsGetScienceLoadingData extends newsAppState {}

class newsGetScienceSuccesssData extends newsAppState {}

class newsGetScienceLErorData extends newsAppState {
  newsGetScienceLErorData(String string);
}

class newsAppthemeChange extends newsAppState {}

class newsSearchLoadingData extends newsAppState {}

class newsSearchSuccesssData extends newsAppState {}

class newsSearchLErorData extends newsAppState {
  newsSearchLErorData(String string);
}
