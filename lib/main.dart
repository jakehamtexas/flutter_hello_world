import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      MaterialApp(title: 'Welcome to Flutter', home: RandomWords());
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('Startup Name Generator')),
        body: _buildSuggestions(),
      );

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (_, incrementingIndex) {
          if (incrementingIndex.isOdd) return Divider();

          final suggestionIndex = incrementingIndex ~/ 2;
          if (suggestionIndex >= _suggestions.length)
            _suggestions.addAll(generateWordPairs().take(10));
          return _buildRow(_suggestions[suggestionIndex]);
        });
  }

  Widget _buildRow(WordPair wordPair) {
    return ListTile(title: Text(wordPair.asPascalCase, style: _biggerFont));
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RandomWordsState();
}
