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

  void initializeGame() {
    board = List.generate(3, (i) => List.generate(3, (j) => ''));
    currentPlayer = 'X';
    winner = "";
  }

  void makeMove(int row, int col) {
    if (board[row][col].isEmpty && winner == "") {
      setState(() {
        board[row][col] = currentPlayer;
        if (checkForWin(row, col)) {
          winner = currentPlayer;
        } else if (isBoardFull()) {
          winner = 'Draw';
        } else {
          currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
        }
      });
    }
  }

  bool isBoardFull() {
    return board.every((row) => row.every((cell) => cell.isNotEmpty));
  }


  bool checkForWin(int row, int col) {
    // Check row, column, and diagonals for a win
    return (board[row].every((cell) => cell == currentPlayer) ||
        List.generate(3, (i) => board[i][col]).every((cell) => cell == currentPlayer) ||
        (row == col && List.generate(3, (i) => board[i][i]).every((cell) => cell == currentPlayer)) ||
        (row + col == 2 && List.generate(3, (i) => board[i][2 - i]).every((cell) => cell == currentPlayer)));
  }

  void resetGame() {
    setState(() {
      initializeGame();
    });
  }

  Widget buildCell(int row, int col) {
    return GestureDetector(
      onTap: () => makeMove(row, col),
      child: Container(
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            board[row][col],
            style: TextStyle(fontSize: 40.0),
          ),
        ),
      ),
    );
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
