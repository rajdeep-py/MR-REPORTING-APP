import 'package:flutter_riverpod/legacy.dart';

class HomeState {
  final String greeting;
  final String quote;

  HomeState({required this.greeting, required this.quote});
}

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier() : super(HomeState(greeting: '', quote: '')) {
    _updateGreeting();
  }

  void _updateGreeting() {
    final hour = DateTime.now().hour;
    String greeting;
    if (hour < 12) {
      greeting = "Good Morning";
    } else if (hour < 17) {
      greeting = "Good Afternoon";
    } else {
      greeting = "Good Evening";
    }

    const quotes = [
      "Your limitation—it's only your imagination.",
      "Push yourself, because no one else is going to do it for you.",
      "Sometimes later becomes never. Do it now.",
      "Great things never come from comfort zones.",
      "Dream it. Wish it. Do it.",
      "Success doesn’t just find you. You have to go out and get it.",
    ];
    final quote = quotes[DateTime.now().second % quotes.length];

    state = HomeState(greeting: greeting, quote: quote);
  }
}
