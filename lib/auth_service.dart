class AuthService {
  // Hard-coded list of user accounts, to be replaced by actual user authentication
  // Key: Username, Value: Password
  final Map<String, String> hardCodedAccounts = {
    "user1": "password1",
    "user2": "password2",
  };

  /// A Future function to sign in with a username and password
  ///
  /// @param name: the username provided by the user
  /// @param password: the password provided by the user
  /// @returns Future<bool>: 'true' if sign-in is successful, 'false' otherwise
  Future<bool> signInWithUserName(String name, String password) async {
    try {
      // Logging that a sign-in attempt is being made
      print("Attempting to sign in...");

      // Check if the username exists in 'hardCodedAccounts'
      // and if the password matches the one associated with that username
      if (hardCodedAccounts.containsKey(name) &&
          hardCodedAccounts[name] == password) {
        // Logging that sign-in is successful
        print("Successfully signed in!");

        return true; // Return 'true' to indicate successful sign-in
      } else {
        print("Invalid credentials");

        return false; // Return 'false' to indicate invalid credentials
      }
    } catch (e) {
      // Catching any exceptions that may occur
      // Logging the caught exception
      print("An error occurred: ${e.toString()}");

      return false; // Return 'false' to indicate an exception occurred
    }
  }
}
