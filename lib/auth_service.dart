class AuthService {
  final Map<String, String> hardCodedAccounts = {
    "user1": "password1",
    "user2": "password2",
  };

  Future<bool> signInWithUserName(String name, String password) async {
    // Change the return type to bool
    try {
      print("Attempting to sign in...");
      if (hardCodedAccounts.containsKey(name) &&
          hardCodedAccounts[name] == password) {
        print("Successfully signed in!");
        return true; // Return true on successful sign-in
      } else {
        print("Invalid credentials");
        return false; // Return false on invalid credentials
      }
    } catch (e) {
      print("An error occurred: ${e.toString()}");
      return false; // Return false on exception
    }
  }
}
