import 'package:get_it/get_it.dart';
import 'navigation_service.dart';

// Create an instance of GetIt to manage dependencies
GetIt locator = GetIt.instance;

// Function to setup dependency registrations
void setupLocator() {
  // Register NavigationService as a lazy singleton
  // This ensures that only one instance of NavigationService exists
  // throughout the app's lifecycle
  locator.registerLazySingleton(() => NavigationService());
}
