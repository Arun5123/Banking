import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banking Transactions',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KCET Bank'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Login"),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Validate username and password
                if (_usernameController.text == 'Arun' &&
                    _passwordController.text == 'arun') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BankingHomePage(
                        username: _usernameController.text,
                      ),
                    ),
                  );
                } else {
                  // Show error message for invalid credentials
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Invalid username or password')),
                  );
                }
              },
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}

class BankingHomePage extends StatefulWidget {
  final String username;

  BankingHomePage({required this.username});

  @override
  _BankingHomePageState createState() => _BankingHomePageState();
}

class _BankingHomePageState extends State<BankingHomePage> {
  double _balance = 1000; // Initial balance for demonstration

  void _depositMoney(double amount) {
    setState(() {
      _balance += amount;
    });
  }

  void _withdrawMoney(double amount) {
    setState(() {
      if (_balance >= amount) {
        _balance -= amount;
      } else {
        // Show an error message if there are insufficient funds
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Insufficient Funds"),
              content: Text("You do not have enough funds to withdraw."),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    });
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Banking Transactions'),
        actions: [
          // Add a logout button to the app bar
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome, ${widget.username}!', // Display username in the welcome message
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Current Balance: \$$_balance',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _depositMoney(100); // Example deposit amount
              },
              child: Text('Deposit'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _withdrawMoney(200); // Example withdrawal amount
              },
              child: Text('Withdraw'),
            ),
          ],
        ),
      ),
    );
  }
}
