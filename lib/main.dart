import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      MaterialApp(title: 'Startup Name Generator', home: RandomWords());
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('Startup Name Generator')),
        body: _buildSuggestions(),
      );

  ListView _buildSuggestions() {
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

  ListTile _buildRow(WordPair wordPair) {
    final trailing = _getTrailing(wordPair);
    return ListTile(
        title: Text(wordPair.asPascalCase, style: _biggerFont),
        trailing: trailing);
  }

  Icon _getTrailing(WordPair wordPair) {
    final isSaved = _saved.contains(wordPair);
    final savedTrailing = Icon(Icons.favorite, color: Colors.red);
    final unSavedTrailing = Icon(Icons.favorite_border);
    final trailing = isSaved ? savedTrailing : unSavedTrailing;
    return trailing;
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RandomWordsState();
}
