import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemoryCardGame extends StatefulWidget {
  @override
  _MemoryCardGameState createState() => _MemoryCardGameState();
}

class _MemoryCardGameState extends State<MemoryCardGame> {
  final List<IconData> _icons = [
    Icons.star,
    Icons.favorite,
    Icons.cake,
    Icons.ac_unit,
    Icons.wb_sunny,
    Icons.beach_access,
  ];

  late List<IconData> _shuffledIcons;
  List<bool> _revealedCards = [];
  List<int> _selectedCards = [];
  bool _isChecking = false; // To disable taps while checking
  bool _isFirstTime = false; // To check if the user is playing for the first time

  @override
  void initState() {
    super.initState();
    _checkFirstTime();
    _resetGame();
  }

  // Step 1: Check if it's the user's first time
  Future<void> _checkFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    _isFirstTime = prefs.getBool('isFirstTime') ?? true; // Default: true

    if (_isFirstTime) {
      // Show the tutorial
      _showTutorial();
      await prefs.setBool('isFirstTime', false); // Mark as not first time
    }
  }

  // Step 2: Show the tutorial
  void _showTutorial() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("How to Play Memory Card Match"),
          content: SingleChildScrollView(
            child: Column(
              children: const [
                Text("1. Tap a card to reveal its symbol."),
                Text("2. Find and tap the matching card."),
                Text("3. Match all pairs to win the game."),
                SizedBox(height: 10),
                Text("Good luck!", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Got it!"),
            ),
          ],
        );
      },
    );
  }

  void _resetGame() {
    _shuffledIcons = [..._icons, ..._icons]..shuffle();
    _revealedCards = List.filled(_shuffledIcons.length, false);
    _selectedCards.clear();
    _isChecking = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Memory Card Match"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetGame,
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: _shuffledIcons.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _onCardTap(index),
            child: Card(
              color: _revealedCards[index] ? Colors.white : Colors.grey,
              child: _revealedCards[index]
                  ? Icon(_shuffledIcons[index], size: 36, color: Colors.blue)
                  : null,
            ),
          );
        },
      ),
    );
  }

  void _onCardTap(int index) async {
    if (_isChecking || _revealedCards[index] || _selectedCards.length == 2) {
      return; // Ignore tap if checking or card already revealed
    }

    setState(() {
      _revealedCards[index] = true; // Reveal the card
      _selectedCards.add(index); // Add to selected cards
    });

    if (_selectedCards.length == 2) {
      _isChecking = true;

      // Check for match after a delay
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        if (_shuffledIcons[_selectedCards[0]] ==
            _shuffledIcons[_selectedCards[1]]) {
          // Cards match; keep them revealed
        } else {
          // Cards don't match; hide them again
          _revealedCards[_selectedCards[0]] = false;
          _revealedCards[_selectedCards[1]] = false;
        }
        _selectedCards.clear(); // Clear selection
        _isChecking = false; // Allow new taps
      });

      // Check if the game is over
      if (_revealedCards.every((revealed) => revealed)) {
        _showGameOverDialog();
      }
    }
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Congratulations!"),
          content: const Text("You've matched all the cards!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetGame();
              },
              child: const Text("Play Again"),
            ),
          ],
        );
      },
    );
  }
}
