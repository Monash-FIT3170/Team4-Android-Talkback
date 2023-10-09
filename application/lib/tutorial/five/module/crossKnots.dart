import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:math';

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({super.key});

  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  late List<List<String>> board;
  late String currentPlayer;
  late String winner;

  String introSpeech = """Welcome to crosses and knots.
      Scroll forward and backwards throught the grid by swiping right,
      or left. once you are on the grid you want to place your knot or 
      cross, double tap to place it. After the game ends, click the 
      restart button. You will play as crosses.
      """;

  FlutterTts? flutterTts;

  @override
  void initState() {
    super.initState();
    initializeGame();

    // Initilizing tts engine
    _initTextToSpeech().then((value) {
      flutterTts = value;
      _speakLines(flutterTts!, introSpeech);
    });
  }

  Future<FlutterTts> _initTextToSpeech() async {
    String lang = 'en-US';
    double narrationSpeed = 0.45;

    FlutterTts flutterTts = FlutterTts();
    flutterTts.setLanguage(lang);
    flutterTts.setSpeechRate(narrationSpeed);
    return flutterTts;
  }

  void _speakLines(FlutterTts flutterTts, String message) async {
    String line =
        message.replaceAll('\n', ' '); // Multi line str into str array

    flutterTts.speak(line);
  }

  void initializeGame() {
    board = List.generate(3, (i) => List.generate(3, (j) => ''));
    currentPlayer = 'X';
    winner = "";
  }

  List<Offset> getAvailableMoves() {
    List<Offset> moves = [];
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == '') {
          moves.add(Offset(i.toDouble(), j.toDouble()));
        }
      }
    }
    return moves;
  }

  void makeMove(int row, int col) {
    if (board[row][col].isEmpty && winner == "") {
      setState(() {
        board[row][col] = currentPlayer;
        if (checkForWin(row, col)) {
          winner = currentPlayer;
          _speakLines(flutterTts!, "Player $currentPlayer wins!");
        } else if (isBoardFull()) {
          winner = 'Draw';
          _speakLines(flutterTts!, 'The game is a draw.');
        } else {
          currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';

          if (currentPlayer == 'O') {
            // AI's turn
            List<Offset> availableMoves = getAvailableMoves();
            if (availableMoves.isNotEmpty) {
              var random = Random();
              Offset aiMove =
                  availableMoves[random.nextInt(availableMoves.length)];
              int row = aiMove.dx.toInt();
              int col = aiMove.dy.toInt();
              makeMove(row, col);
              _speakLines(
                  flutterTts!, "Opponent placed on Row $row, Column $col");
            }
          }
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
        List.generate(3, (i) => board[i][col])
            .every((cell) => cell == currentPlayer) ||
        (row == col &&
            List.generate(3, (i) => board[i][i])
                .every((cell) => cell == currentPlayer)) ||
        (row + col == 2 &&
            List.generate(3, (i) => board[i][2 - i])
                .every((cell) => cell == currentPlayer)));
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
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              board[row][col],
              style: const TextStyle(
                  fontSize: 40.0,
                  color: Colors
                      .black), // Set the text color to black for 'X' and 'O'
            ),
            Text(
              'Row ${row + 1}, Column ${col + 1}',
              style: const TextStyle(
                  fontSize: 10.0,
                  color: Colors
                      .white), // Keep the text color for "Row x, Column y" white
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic-Tac-Toe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              (winner == "")
                  ? 'Current Player: $currentPlayer'
                  : 'Winner: $winner',
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
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
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: resetGame,
              child: const Text('Restart Game'),
            ),
          ],
        ),
      ),
    );
  }
}
