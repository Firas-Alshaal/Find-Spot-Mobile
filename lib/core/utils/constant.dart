// ignore_for_file: constant_identifier_names

class Constants {
  Constants._();

  //PAGES
  static const String SPLASH = '/';
  static const String IntroScreen = '/Intro';
  static const String HomeScreen = '/Home';
  static const String LoginScreen = '/Login';
  static const String RegisterScreen = '/Register';
  static const String LostItemScreen = '/Lost';
  static const String FoundItemScreen = '/Found';
  static const String AddLostScreen = '/AddLost';
  static const String AddFoundScreen = '/AddFound';
  static const String LocationScreen = '/Location';
  static const String SearchScreen = '/Search';
  static const String ItemDetailsScreen = '/ItemDetails';
  static const String PutLocationScreen = '/PutLocation';
  static const String EditUserScreen = '/EditUser';

  //APIs
  static const String URL = 'BASE_URL/';
  static const String LOGIN = 'users/login';
  static const String Register = 'users/register';
  static const String EditUser = 'users/edit';
  static const String AddLostItem = 'items/lost';
  static const String AddFoundItem = 'items/found';
  static const String GetLostItem = 'items';
  static const String GetCategories = 'categories';
  static const String Search = 'items/search';

  // Shared Key
  static const String TOKEN = 'token';
  static const String User = 'user';
  static const String OnBoarding = 'OnBoarding';
  static const String LostItems = 'LostItems';
  static const String Categories = 'Categories';
}
