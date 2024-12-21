import 'package:flutter/material.dart';
import 'dart:math';

class DailyAffirmationPage extends StatefulWidget {
  @override
  _DailyAffirmationPageState createState() => _DailyAffirmationPageState();
}

class _DailyAffirmationPageState extends State<DailyAffirmationPage> {
  final List<String> affirmations = [
  "You are capable of amazing things.",
  "Today is full of endless possibilities.",
  "You are stronger than you think.",
  "Happiness is within your reach.",
  "Believe in yourself and all that you are.",
  "Every day is a new beginning.",
  "You are worthy of love and respect.",
  "Your potential is limitless.",
  "You have the power to change your life.",
  "You can accomplish great things.",
  "Every challenge is an opportunity to grow.",
  "Be kind to yourself and others.",
  "You are in charge of your own happiness.",
  "Success is within your grasp.",
  "You are doing your best, and that's enough.",
  "Be proud of how far you’ve come.",
  "Your hard work will pay off.",
  "You are enough just as you are.",
  "You have the power to make today great.",
  "You are deserving of all good things.",
  "Let go of what you can't control.",
  "Focus on progress, not perfection.",
  "You can overcome any obstacle.",
  "Take a deep breath. You've got this.",
  "Be present in the moment.",
  "Your dreams are worth chasing.",
  "You are capable of achieving greatness.",
  "Mistakes are part of learning.",
  "You are resilient and resourceful.",
  "Your mindset determines your success.",
  "You bring positivity wherever you go.",
  "You are brave and courageous.",
  "Take things one step at a time.",
  "You are worthy of happiness.",
  "Believe in your unique abilities.",
  "You are making a difference.",
  "Your efforts are making an impact.",
  "Every day brings new opportunities.",
  "You are exactly where you need to be.",
  "Your future is bright and full of promise.",
  "You are surrounded by love and support.",
  "Stay patient and trust your journey.",
  "You are free to create your own path.",
  "You are capable of amazing transformations.",
  "Embrace change; it leads to growth.",
  "Your creativity knows no bounds.",
  "You can find joy in the little things.",
  "You are a magnet for positivity.",
  "You can turn challenges into victories.",
  "You are a force for good in the world.",
  "You have the courage to pursue your dreams.",
  "Be kind to yourself; you’re doing great.",
  "Your best days are still ahead.",
  "You are learning and growing every day.",
  "Your happiness is a priority.",
  "You are stronger than your fears.",
  "You radiate confidence and positivity.",
  "You can achieve anything you set your mind to.",
  "Your inner strength is unshakable.",
  "You are a beacon of light and hope.",
  "Trust yourself and your instincts.",
  "You are destined for great things.",
  "Every small step brings you closer to your goals.",
  "You are capable of adapting and thriving.",
  "You are enough, just as you are.",
  "Let go of negativity and embrace positivity.",
  "You are constantly growing and evolving.",
  "You are surrounded by abundance.",
  "Your mindset is your greatest asset.",
  "You are creating a life you love.",
  "You are a source of inspiration to others.",
  "You are capable of achieving balance in your life.",
  "Your energy is magnetic and uplifting.",
  "Your possibilities are endless.",
  "You are grateful for today’s blessings.",
  "You have the power to rewrite your story.",
  "You are brave enough to be yourself.",
  "You are worthy of your dreams.",
  "You are in control of your destiny.",
  "You are at peace with your past and excited for your future.",
  "You are the author of your own happiness.",
  "You are open to new opportunities.",
  "You are living your purpose every day.",
  "You are a reflection of your hard work.",
  "Your goals are within reach.",
  "You are proud of who you are becoming.",
  "Your kindness makes a difference.",
  "You are resilient in the face of challenges.",
  "You are building the life of your dreams.",
  "You have the power to make today amazing.",
  "You are deserving of success and abundance.",
  "You are confident and capable.",
  "You are grateful for the present moment.",
  "You are making positive changes every day.",
  "You are in tune with your inner self.",
  "You are unstoppable when you believe in yourself.",
  "You are worthy of unconditional love.",
  "Your determination knows no limits.",
  "You are living your best life.",
  "You are capable of turning setbacks into comebacks.",
  "Your positivity is contagious.",
  "You are a masterpiece in progress.",
  "You are creating your own happiness.",
  "You are worthy of all the wonderful things life has to offer.",
  "You are open to the abundance of the universe.",
  "You are courageous enough to embrace change.",
  "You are a magnet for success.",
  "You have everything you need to succeed.",
  "You are surrounded by positive energy.",
  "You are capable of creating a fulfilling life.",
  "Your future is full of endless possibilities.",
  "You are the architect of your dreams.",
  "Each step forward is progress.",
  "You are deserving of peace and joy.",
  "You radiate self-confidence and love.",
  "You are proud of your achievements.",
  "You attract positivity and kindness.",
  "You are exactly who you need to be.",
  "Your gratitude is your strength.",
  "You are growing into your best self.",
  "Life is a gift, and you cherish it.",
  "You are creating your own happiness.",
  "You choose hope and optimism daily.",
  "Every moment is a fresh start.",
  "You are thriving and moving forward.",
  "You believe in your unique journey.",
  "You are a source of love and light.",
  "You turn challenges into opportunities.",
  "You are open to learning and growing.",
  "You are more than enough.",
  "Your dreams are worth pursuing.",
  "You radiate positivity and confidence.",
  "You deserve to feel joy every day.",
  "You are grateful for today’s blessings.",
  "Every action you take moves you closer to success.",
  "You are destined for greatness.",
  "You are a masterpiece in the making.",
  "You deserve love, joy, and abundance.",
  "You are fearless and unstoppable.",
  "You trust your intuition and inner wisdom.",
  "You are filled with energy and inspiration.",
  "You radiate happiness and positivity.",
  "You have the courage to take the first step.",
  "You are grateful for this moment.",
  "You are powerful beyond measure.",
  "You are worthy of achieving your goals.",
  "You are focused, resilient, and motivated.",
  "You are free to be your authentic self.",
  "You choose to see the good in every situation.",
  "You are a magnet for love and success.",
  "You are the creator of your happiness."
];


  String _affirmation = "";

  @override
  void initState() {
    super.initState();
    _setDailyAffirmation();
  }

  void _setDailyAffirmation() {
    // Get the current day of the year (1-365)
    final currentDayOfYear = DateTime.now().difference(DateTime(DateTime.now().year, 1, 1)).inDays;

    // Ensure the affirmation index stays within bounds
    final affirmationIndex = currentDayOfYear % affirmations.length;

    setState(() {
      _affirmation = affirmations[affirmationIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Affirmation'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _affirmation,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                "Come back tomorrow for a new affirmation!",
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
