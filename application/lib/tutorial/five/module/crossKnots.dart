import 'package:flutter/material.dart';

class TicTacToeGame extends StatefulWidget {
  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  late List<List<String>> board;
  late String currentPlayer;
  late String winner;

  @override
  void initState() {
    super.initState();
    initializeGame();
  }

  void initializeGame() {}

  void makeMove(int row, int col) {}

  void resetGame() {}

  Widget buildCell(int row, int col) {
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic-Tac-Toe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              (winner == "")
                  ? 'Current Player: $currentPlayer'
                  : 'Winner: $winner',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            Column(
              children: List.generate(3, (row) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (col) {
                    return buildCell(row, col);
                  }),
                );
              }),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: resetGame,
              child: Text('Restart Game'),
            ),
          ],
        ),
      ),
    );
  }
}
