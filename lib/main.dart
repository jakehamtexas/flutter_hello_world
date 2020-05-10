import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Startup Name Generator',
      home: RandomWords(),
      theme: ThemeData(primaryColor: Colors.deepPurple));
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Startup Name Generator'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.list), onPressed: _pushSavedRoute)
          ],
        ),
        body: _buildSuggestions(),
      );

  void _pushSavedRoute() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (final context) {
      final Iterable<ListTile> tiles = _saved.map((final pair) => ListTile(
            title: Text(
              pair.asPascalCase,
              style: _biggerFont,
            ),
          ));
      final divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();
      return Scaffold(
        appBar: AppBar(
          title: Text('Saved Suggestions'),
        ),
        body: ListView(children: divided),
      );
    }));
  }

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
    final isSaved = _saved.contains(wordPair);
    final trailing = _getRandomWordTrailing(isSaved);
    final toggleSave = _getWordPairToggleSave(isSaved, wordPair);
    final wordPairText = _getWordPairText(wordPair);
    final row =
        ListTile(title: wordPairText, trailing: trailing, onTap: toggleSave);
    return row;
  }

  Text _getWordPairText(WordPair wordPair) {
    final wordPairText = Text(wordPair.asPascalCase, style: _biggerFont);
    return wordPairText;
  }

  Function _getWordPairToggleSave(bool isSaved, WordPair wordPair) {
    final onTap = () {
      setState(() {
        if (isSaved) {
          _saved.remove(wordPair);
        } else {
          _saved.add(wordPair);
        }
      });
    };
    return onTap;
  }

  Icon _getRandomWordTrailing(bool isSaved) {
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
