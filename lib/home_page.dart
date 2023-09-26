import 'package:flutter/material.dart';

// Define a StatelessWidget since the UI does not need to change over time
class HomePage extends StatelessWidget {
  // Constructor for the HomePage class, taking an optional key
  const HomePage({Key? key}) : super(key: key);

  // The build method is where you define the UI for the widget
  @override
  Widget build(BuildContext context) {
    // Scaffold is the basic layout structure of the app
    return Scaffold(
      body: OrientationBuilder(
        // Use OrientationBuilder to change layout based on screen orientation
        builder: (context, orientation) {
          // Check the screen orientation and render accordingly
          return (orientation == Orientation.portrait)
              ? _buildPortraitLayout(context)
              : _buildLandscapeLayout(context);
        },
      ),
    );
  }

  // Function to define how the layout should look in portrait mode
  Widget _buildPortraitLayout(BuildContext context) {
    // Use Center to center the child widgets
    return Center(
      child: Column(
        // Align child widgets to the center of the main axis
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Welcome text
          const Text(
            'Welcome to Messenger',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          // Add some space
          const SizedBox(height: 20),
          // Button to navigate to the login page
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }

  // Function to define how the layout should look in landscape mode
  Widget _buildLandscapeLayout(BuildContext context) {
    // Similar to _buildPortraitLayout but uses Row instead of Column
    return Center(
      child: Row(
        // Align child widgets to the center of the main axis
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Welcome text
          const Text(
            'Welcome to Messenger',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          // Add some space
          const SizedBox(width: 20),
          // Button to navigate to the login page
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
