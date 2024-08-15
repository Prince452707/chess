// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Chess',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: ChessHomePage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class ChessHomePage extends StatefulWidget {
//   @override
//   _ChessHomePageState createState() => _ChessHomePageState();
// }

// class _ChessHomePageState extends State<ChessHomePage> {
//   final ChessBoard _chessBoard = ChessBoard();
//   List<int> _selectedSquare = [-1, -1];

//   @override
//   void initState() {
//     super.initState();
//     _chessBoard.initializeBoard();
//   }

//   void _onSquareTapped(int x, int y) {
//     setState(() {
//       if (_selectedSquare[0] == -1) {
//         // Select a piece
//         if (_chessBoard.board[x][y] != null && _chessBoard.isPieceOwnedByCurrentPlayer(_chessBoard.board[x][y]!)) {
//           _selectedSquare = [x, y];
//         }
//       } else {
//         // Move the selected piece
//         if (_chessBoard.isValidMove(_selectedSquare[0], _selectedSquare[1], x, y)) {
//           _chessBoard.makeMove(_selectedSquare[0], _selectedSquare[1], x, y);
//           _chessBoard.switchPlayer();
//           _selectedSquare = [-1, -1];
//         } else {
//           _selectedSquare = [-1, -1];
//         }
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Chess'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _buildBoard(),
//             SizedBox(height: 20),
//             Text(
//               'Current Player: ${_chessBoard.gameState.currentPlayer == 'w' ? 'White' : 'Black'}',
//               style: TextStyle(fontSize: 24),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBoard() {
//     return AspectRatio(
//       aspectRatio: 1.0,
//       child: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 8,
//         ),
//         itemBuilder: _buildGridItems,
//         itemCount: 64,
//       ),
//     );
//   }

//   Widget _buildGridItems(BuildContext context, int index) {
//     final int x = index ~/ 8;
//     final int y = index % 8;
//     final String? piece = _chessBoard.board[x][y];

//     return GestureDetector(
//       onTap: () {
//         _onSquareTapped(x, y);
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.black),
//           color: (x + y) % 2 == 0 ? Color.fromARGB(255, 190, 92, 92) : Colors.grey,
//         ),
//         child: Center(
//           child: Text(
//             piece != null ? _chessBoard.getPieceSymbol(piece) : '',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: piece != null && piece.toLowerCase() == piece ? Colors.black : Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ChessBoard {
//   List<List<String?>> board;
//   GameState gameState;

//   ChessBoard()
//       : board = List.generate(8, (i) => List.generate(8, (j) => null)),
//         gameState = GameState();

//   void initializeBoard() {
//     // Black pieces
//     board[0] = ['r', 'n', 'b', 'q', 'k', 'b', 'n', 'r'];
//     board[1] = List.generate(8, (index) => 'p');
    
//     // Empty rows in between
//     for (int i = 2; i <= 5; i++) {
//       board[i] = List.generate(8, (index) => null);
//     }

//     // White pieces
//     board[6] = List.generate(8, (index) => 'P');
//     board[7] = ['R', 'N', 'B', 'Q', 'K', 'B', 'N', 'R'];
//   }

//   void switchPlayer() {
//     gameState.currentPlayer = (gameState.currentPlayer == 'w') ? 'b' : 'w';
//   }

//   bool isPieceOwnedByCurrentPlayer(String piece) {
//     if (gameState.currentPlayer == 'w' && piece.toUpperCase() == piece) {
//       return true;
//     }
//     if (gameState.currentPlayer == 'b' && piece.toLowerCase() == piece) {
//       return true;
//     }
//     return false;
//   }

//   bool isValidMove(int startX, int startY, int endX, int endY) {
//     final String? piece = board[startX][startY];
//     if (piece == null) return false;
//     switch (piece.toLowerCase()) {
//       case 'p':
//         return _isValidPawnMove(piece, startX, startY, endX, endY);
//       case 'r':
//         return _isValidRookMove(startX, startY, endX, endY);
//       case 'n':
//         return _isValidKnightMove(startX, startY, endX, endY);
//       case 'b':
//         return _isValidBishopMove(startX, startY, endX, endY);
//       case 'q':
//         return _isValidQueenMove(startX, startY, endX, endY);
//       case 'k':
//         return _isValidKingMove(startX, startY, endX, endY);
//       default:
//         return false;
//     }
//   }

//   void makeMove(int startX, int startY, int endX, int endY) {
//     final String? piece = board[startX][startY];
//     board[endX][endY] = piece;
//     board[startX][startY] = null;
//   }

//   bool _isValidPawnMove(String piece, int startX, int startY, int endX, int endY) {
//     int direction = piece == 'P' ? -1 : 1;
//     int startRow = piece == 'P' ? 6 : 1;
//   // Move forward
//     if (startY == endY && board[endX][endY] == null) {
//       if (endX == startX + direction) {
//         return true;
//       }
//       if (startX == startRow && endX == startX + 2 * direction && board[startX + direction][endY] == null) {
//         return true;
//       }
//     }

//     // Capture diagonally
//     if ((endY == startY + 1 || endY == startY - 1) && endX == startX + direction && board[endX][endY] != null) {
//       return true;
//     }

//     return false;
//   }

//   bool _isValidRookMove(int startX, int startY, int endX, int endY) {
//     if (startX != endX && startY != endY) return false;

//     if (startX == endX) {
//       for (int y = (startY < endY ? startY + 1 : endY + 1); y < (startY < endY ? endY : startY); y++) {
//         if (board[startX][y] != null) return false;
//       }
//     }

//     if (startY == endY) {
//       for (int x = (startX < endX ? startX + 1 : endX + 1); x < (startX < endX ? endX : startX); x++) {
//         if (board[x][startY] != null) return false;
//       }
//     }

//     return true;
//   }

//   bool _isValidKnightMove(int startX, int startY, int endX, int endY) {
//     int dx = (startX - endX).abs();
//     int dy = (startY - endY).abs();
//     return (dx == 2 && dy == 1) || (dx == 1 && dy == 2);
//   }

//   bool _isValidBishopMove(int startX, int startY, int endX, int endY) {
//     if ((startX - endX).abs() != (startY - endY).abs()) return false;

//     int dx = startX < endX ? 1 : -1;
//     int dy = startY < endY ? 1 : -1;
//     for (int i = 1; i < (startX - endX).abs(); i++) {
//       if (board[startX + i * dx][startY + i * dy] != null) return false;
//     }

//     return true;
//   }

//   bool _isValidQueenMove(int startX, int startY, int endX, int endY) {
//     return _isValidRookMove(startX, startY, endX, endY) || _isValidBishopMove(startX, startY, endX, endY);
//   }

//   bool _isValidKingMove(int startX, int startY, int endX, int endY) {
//     return (startX - endX).abs() <= 1 && (startY - endY).abs() <= 1;
//   }

//   String getPieceSymbol(String piece) {
//     switch (piece.toLowerCase()) {
//       case 'p':
//         return '♟';
//       case 'r':
//         return '♜';
//       case 'n':
//         return '♞';
//       case 'b':
//         return '♝';
//       case 'q':
//         return '♛';
//       case 'k':
//         return '♚';
//       default:
//         return '';
//     }
//   }
// }

// class GameState {
//   String currentPlayer;

//   GameState() : currentPlayer = 'w';
// }






































































// import 'package:flutter/material.dart';
// import 'dart:math' as math;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Futuristic Chess',
//       theme: ThemeData.dark().copyWith(
//         primaryColor: Colors.deepPurple,
//         scaffoldBackgroundColor: Colors.black,
//       ),
//       home: ChessHomePage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class ChessHomePage extends StatefulWidget {
//   @override
//   _ChessHomePageState createState() => _ChessHomePageState();
// }

// class _ChessHomePageState extends State<ChessHomePage> {
//   final ChessBoard _chessBoard = ChessBoard();
//   List<int> _selectedSquare = [-1, -1];

//   @override
//   void initState() {
//     super.initState();
//     _chessBoard.initializeBoard();
//   }

//   void _onSquareTapped(int x, int y) {
//     setState(() {
//       if (_selectedSquare[0] == -1) {
//         if (_chessBoard.board[x][y] != null && _chessBoard.isPieceOwnedByCurrentPlayer(_chessBoard.board[x][y]!)) {
//           _selectedSquare = [x, y];
//         }
//       } else {
//         if (_chessBoard.isValidMove(_selectedSquare[0], _selectedSquare[1], x, y)) {
//           _chessBoard.makeMove(_selectedSquare[0], _selectedSquare[1], x, y);
//           _selectedSquare = [-1, -1];
          
//           if (_chessBoard.gameState.currentPlayer == 'b') {
//             Future.delayed(Duration(milliseconds: 500), () {
//               _makeAutomaticMove();
//             });
//           }
//         } else {
//           _selectedSquare = [-1, -1];
//         }
//       }
//     });
//   }

//   void _makeAutomaticMove() {
//     List<List<int>> availableMoves = [];
//     for (int startX = 0; startX < 8; startX++) {
//       for (int startY = 0; startY < 8; startY++) {
//         if (_chessBoard.board[startX][startY] != null && 
//             _chessBoard.isPieceOwnedByCurrentPlayer(_chessBoard.board[startX][startY]!)) {
//           for (int endX = 0; endX < 8; endX++) {
//             for (int endY = 0; endY < 8; endY++) {
//               if (_chessBoard.isValidMove(startX, startY, endX, endY)) {
//                 availableMoves.add([startX, startY, endX, endY]);
//               }
//             }
//           }
//         }
//       }
//     }

//     if (availableMoves.isNotEmpty) {
//       final move = availableMoves[math.Random().nextInt(availableMoves.length)];
//       setState(() {
//         _chessBoard.makeMove(move[0], move[1], move[2], move[3]);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Futuristic Chess'),
//         backgroundColor: Colors.deepPurple,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _buildBoard(),
//             SizedBox(height: 20),
//             Text(
//               'Current Player: ${_chessBoard.gameState.currentPlayer == 'w' ? 'White' : 'Black'}',
//               style: TextStyle(fontSize: 24, color: Colors.cyanAccent),
//             ),
//             if (_chessBoard.gameState.check)
//               Text(
//                 'Check!',
//                 style: TextStyle(fontSize: 24, color: Colors.redAccent),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBoard() {
//     return Container(
//       width: MediaQuery.of(context).size.width * 0.9,
//       height: MediaQuery.of(context).size.width * 0.9,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.cyanAccent.withOpacity(0.5),
//             blurRadius: 10,
//             spreadRadius: 5,
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(15),
//         child: GridView.builder(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 8,
//           ),
//           itemBuilder: _buildGridItems,
//           itemCount: 64,
//         ),
//       ),
//     );
//   }

//   Widget _buildGridItems(BuildContext context, int index) {
//     final int x = index ~/ 8;
//     final int y = index % 8;
//     final String? piece = _chessBoard.board[x][y];

//     return GestureDetector(
//       onTap: () {
//         _onSquareTapped(x, y);
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: (x + y) % 2 == 0 
//               ? Colors.deepPurple.withOpacity(0.7) 
//               : Colors.deepPurple.withOpacity(0.3),
//           border: Border.all(color: Colors.cyanAccent.withOpacity(0.3)),
//         ),
//         child: Center(
//           child: piece != null
//               ? _buildPiece(piece)
//               : null,
//         ),
//       ),
//     );
//   }

//   Widget _buildPiece(String piece) {
//     return Container(
//       width: 40,
//       height: 40,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         gradient: RadialGradient(
//           colors: [
//             piece.toLowerCase() == piece ? Colors.black : Colors.white,
//             piece.toLowerCase() == piece ? Colors.grey[800]! : Colors.grey[300]!,
//           ],
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.cyanAccent.withOpacity(0.5),
//             blurRadius: 5,
//             spreadRadius: 1,
//           ),
//         ],
//       ),
//       child: Center(
//         child: Text(
//           _chessBoard.getPieceSymbol(piece),
//           style: TextStyle(
//             fontSize: 24,
//             color: piece.toLowerCase() == piece ? Colors.white : Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ChessBoard {
//   List<List<String?>> board;
//   GameState gameState;

//   ChessBoard()
//       : board = List.generate(8, (i) => List.generate(8, (j) => null)),
//         gameState = GameState();

//   void initializeBoard() {
//     board[0] = ['r', 'n', 'b', 'q', 'k', 'b', 'n', 'r'];
//     board[1] = List.generate(8, (index) => 'p');
    
//     for (int i = 2; i <= 5; i++) {
//       board[i] = List.generate(8, (index) => null);
//     }

//     board[6] = List.generate(8, (index) => 'P');
//     board[7] = ['R', 'N', 'B', 'Q', 'K', 'B', 'N', 'R'];
//   }

//   void switchPlayer() {
//     gameState.currentPlayer = (gameState.currentPlayer == 'w') ? 'b' : 'w';
//   }

//   bool isPieceOwnedByCurrentPlayer(String piece) {
//     if (gameState.currentPlayer == 'w' && piece.toUpperCase() == piece) {
//       return true;
//     }
//     if (gameState.currentPlayer == 'b' && piece.toLowerCase() == piece) {
//       return true;
//     }
//     return false;
//   }

//   bool isValidMove(int startX, int startY, int endX, int endY) {
//     final String? piece = board[startX][startY];
//     if (piece == null) return false;

//     if (piece.toLowerCase() == 'k' && (startY - endY).abs() == 2) {
//       return canCastle(endY > startY);
//     }

//     switch (piece.toLowerCase()) {
//       case 'p':
//         return _isValidPawnMove(piece, startX, startY, endX, endY);
//       case 'r':
//         return _isValidRookMove(startX, startY, endX, endY);
//       case 'n':
//         return _isValidKnightMove(startX, startY, endX, endY);
//       case 'b':
//         return _isValidBishopMove(startX, startY, endX, endY);
//       case 'q':
//         return _isValidQueenMove(startX, startY, endX, endY);
//       case 'k':
//         return _isValidKingMove(startX, startY, endX, endY);
//       default:
//         return false;
//     }
//   }

//   void makeMove(int startX, int startY, int endX, int endY) {
//     final String? piece = board[startX][startY];
    
//     if (piece?.toLowerCase() == 'k' && (startY - endY).abs() == 2) {
//       performCastling(endY > startY);
//     } else {
//       board[endX][endY] = piece;
//       board[startX][startY] = null;
//     }

//     switchPlayer();
//     if (isKingInCheck(gameState.currentPlayer)) {
//       gameState.check = true;
//     } else {
//       gameState.check = false;
//     }
//   }

//   bool _isValidPawnMove(String piece, int startX, int startY, int endX, int endY) {
//     int direction = piece == 'P' ? -1 : 1;
//     int startRow = piece == 'P' ? 6 : 1;
//     if (startY == endY && board[endX][endY] == null) {
//       if (endX == startX + direction) {
//         return true;
//       }
//       if (startX == startRow && endX == startX + 2 * direction && board[startX + direction][endY] == null) {
//         return true;
//       }
//     }

//     if ((endY == startY + 1 || endY == startY - 1) && endX == startX + direction && board[endX][endY] != null) {
//       return true;
//     }

//     return false;
//   }

//   bool _isValidRookMove(int startX, int startY, int endX, int endY) {
//     if (startX != endX && startY != endY) return false;

//     if (startX == endX) {
//       for (int y = (startY < endY ? startY + 1 : endY + 1); y < (startY < endY ? endY : startY); y++) {
//         if (board[startX][y] != null) return false;
//       }
//     }

//     if (startY == endY) {
//       for (int x = (startX < endX ? startX + 1 : endX + 1); x < (startX < endX ? endX : startX); x++) {
//         if (board[x][startY] != null) return false;
//       }
//     }

//     return true;
//   }

//   bool _isValidKnightMove(int startX, int startY, int endX, int endY) {
//     int dx = (startX - endX).abs();
//     int dy = (startY - endY).abs();
//     return (dx == 2 && dy == 1) || (dx == 1 && dy == 2);
//   }

//   bool _isValidBishopMove(int startX, int startY, int endX, int endY) {
//     if ((startX - endX).abs() != (startY - endY).abs()) return false;

//     int dx = startX < endX ? 1 : -1;
//     int dy = startY < endY ? 1 : -1;
//     for (int i = 1; i < (startX - endX).abs(); i++) {
//       if (board[startX + i * dx][startY + i * dy] != null) return false;
//     }

//     return true;
//   }

//   bool _isValidQueenMove(int startX, int startY, int endX, int endY) {
//     return _isValidRookMove(startX, startY, endX, endY) || _isValidBishopMove(startX, startY, endX, endY);
//   }

//   bool _isValidKingMove(int startX, int startY, int endX, int endY) {
//     return (startX - endX).abs() <= 1 && (startY - endY).abs() <= 1;
//   }

//   String getPieceSymbol(String piece) {
//     switch (piece.toLowerCase()) {
//       case 'p':
//         return '♟';
//       case 'r':
//         return '♜';
//       case 'n':
//         return '♞';
//       case 'b':
//         return '♝';
//       case 'q':
//         return '♛';
//       case 'k':
//         return '♚';
//       default:
//         return '';
//     }
//   }

//   bool isKingInCheck(String color) {
//     int kingX = -1, kingY = -1;
//     for (int x = 0; x < 8; x++) {
//       for (int y = 0; y < 8; y++) {
//         if (board[x][y] == (color == 'w' ? 'K' : 'k')) {
//           kingX = x;
//           kingY = y;
//           break;
//         }
//       }
//       if (kingX != -1) break;
//     }

//     for (int x = 0; x < 8; x++) {
//       for (int y = 0; y < 8; y++) {
//         if (board[x][y] != null && isPieceOwnedByCurrentPlayer(board[x][y]!) != (color == 'w')) {
//           if (isValidMove(x, y, kingX, kingY)) {
//             return true;
//           }
//         }
//       }
//     }
//     return false;
//   }

//   bool canCastle(bool kingSide) {
//     String king = gameState.currentPlayer == 'w' ? 'K' : 'k';
//     String rook = gameState.currentPlayer == 'w' ? 'R' : 'r';
//     int row = gameState.currentPlayer == 'w' ? 7 : 0;
//     int kingCol = 4;
//     int rookCol = kingSide ? 7 : 0;

//     if (board[row][kingCol] != king || board[row][rookCol] != rook) {
//       return false;
//     }

//     int start = kingSide ? kingCol + 1 : rookCol + 1;
//     int end = kingSide ? rookCol : kingCol;
//     for (int col = start; col < end; col++) {
//       if (board[row][col] != null) {
//         return false;
//       }
//     }

//     if (isKingInCheck(gameState.currentPlayer)) {
//       return false;
//     }
//     for (int col = kingCol; col != (kingSide ? kingCol + 2 : kingCol - 2); col += (kingSide ? 1 : -1)) {
//       board[row][kingCol] = null;
//       board[row][col] = king;
//       bool inCheck = isKingInCheck(gameState.currentPlayer);
//       board[row][col] = null;
//       board[row][kingCol] = king;
//       if (inCheck) {
//         return false;
//       }
//     }

//     return true;
//   }

//   void performCastling(bool kingSide) {
//     int row = gameState.currentPlayer == 'w' ? 7 : 0;
//     int kingCol = 4;
//     int rookCol = kingSide ? 7 : 0;
//     int newKingCol = kingSide ? 6 : 2;
//     int newRookCol = kingSide ? 5 : 3;

//     String king = board[row][kingCol]!;
//     String rook = board[row][rookCol]!;

//     board[row][kingCol] = null;
//     board[row][rookCol] = null;
//     board[row][newKingCol] = king;
//     board[row][newRookCol] = rook;
//   }
// }

// class GameState {
//   String currentPlayer;
//   bool check;

//   GameState() : currentPlayer = 'w', check = false;
// }




























import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Futuristic Chess',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: ChessHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChessHomePage extends StatefulWidget {
  @override
  _ChessHomePageState createState() => _ChessHomePageState();
}

class _ChessHomePageState extends State<ChessHomePage> {
  final ChessBoard _chessBoard = ChessBoard();
  List<int> _selectedSquare = [-1, -1];

  @override
  void initState() {
    super.initState();
    _chessBoard.initializeBoard();
  }

  void _onSquareTapped(int x, int y) {
    setState(() {
      if (_selectedSquare[0] == -1) {
        if (_chessBoard.board[x][y] != null && _chessBoard.isPieceOwnedByCurrentPlayer(_chessBoard.board[x][y]!)) {
          _selectedSquare = [x, y];
        }
      } else {
        if (_chessBoard.isValidMove(_selectedSquare[0], _selectedSquare[1], x, y)) {
          _chessBoard.makeMove(_selectedSquare[0], _selectedSquare[1], x, y);
          _selectedSquare = [-1, -1];
          
          if (_chessBoard.gameState.currentPlayer == 'b') {
            Future.delayed(Duration(milliseconds: 500), () {
              _makeAutomaticMove();
            });
          }
        } else {
          _selectedSquare = [-1, -1];
        }
      }
    });
  }

  void _makeAutomaticMove() {
    final botMove = findBestMove(_chessBoard, 3);
    if (botMove != null) {
      setState(() {
        _chessBoard.makeMove(botMove[0], botMove[1], botMove[2], botMove[3]);
      });
    }
  }

  List<int>? findBestMove(ChessBoard board, int depth) {
    List<int>? bestMove;
    int bestScore = -999999;
    
    for (int startX = 0; startX < 8; startX++) {
      for (int startY = 0; startY < 8; startY++) {
        if (board.board[startX][startY] != null && 
            board.isPieceOwnedByCurrentPlayer(board.board[startX][startY]!)) {
          for (int endX = 0; endX < 8; endX++) {
            for (int endY = 0; endY < 8; endY++) {
              if (board.isValidMove(startX, startY, endX, endY)) {
                ChessBoard newBoard = board.clone();
                newBoard.makeMove(startX, startY, endX, endY);
                int score = -minimax(newBoard, depth - 1, -999999, 999999, false);
                if (score > bestScore) {
                  bestScore = score;
                  bestMove = [startX, startY, endX, endY];
                }
              }
            }
          }
        }
      }
    }
    return bestMove;
  }

  int minimax(ChessBoard board, int depth, int alpha, int beta, bool isMaximizingPlayer) {
    if (depth == 0 || board.isGameOver()) {
      return evaluateBoard(board);
    }

    if (isMaximizingPlayer) {
      int maxEval = -999999;
      for (int startX = 0; startX < 8; startX++) {
        for (int startY = 0; startY < 8; startY++) {
          if (board.board[startX][startY] != null && 
              board.isPieceOwnedByCurrentPlayer(board.board[startX][startY]!)) {
            for (int endX = 0; endX < 8; endX++) {
              for (int endY = 0; endY < 8; endY++) {
                if (board.isValidMove(startX, startY, endX, endY)) {
                  ChessBoard newBoard = board.clone();
                  newBoard.makeMove(startX, startY, endX, endY);
                  int eval = minimax(newBoard, depth - 1, alpha, beta, false);
                  maxEval = math.max(maxEval, eval);
                  alpha = math.max(alpha, eval);
                  if (beta <= alpha) {
                    break;
                  }
                }
              }
            }
          }
        }
      }
      return maxEval;
    } else {
      int minEval = 999999;
      for (int startX = 0; startX < 8; startX++) {
        for (int startY = 0; startY < 8; startY++) {
          if (board.board[startX][startY] != null && 
              board.isPieceOwnedByCurrentPlayer(board.board[startX][startY]!)) {
            for (int endX = 0; endX < 8; endX++) {
              for (int endY = 0; endY < 8; endY++) {
                if (board.isValidMove(startX, startY, endX, endY)) {
                  ChessBoard newBoard = board.clone();
                  newBoard.makeMove(startX, startY, endX, endY);
                  int eval = minimax(newBoard, depth - 1, alpha, beta, true);
                  minEval = math.min(minEval, eval);
                  beta = math.min(beta, eval);
                  if (beta <= alpha) {
                    break;
                  }
                }
              }
            }
          }
        }
      }
      return minEval;
    }
  }

  int evaluateBoard(ChessBoard board) {
    int score = 0;
    for (int x = 0; x < 8; x++) {
      for (int y = 0; y < 8; y++) {
        if (board.board[x][y] != null) {
          score += getPieceValue(board.board[x][y]!);
        }
      }
    }
    return score;
  }

  int getPieceValue(String piece) {
    switch (piece.toLowerCase()) {
      case 'p':
        return piece.toLowerCase() == piece ? -10 : 10;
      case 'n':
      case 'b':
        return piece.toLowerCase() == piece ? -30 : 30;
      case 'r':
        return piece.toLowerCase() == piece ? -50 : 50;
      case 'q':
        return piece.toLowerCase() == piece ? -90 : 90;
      case 'k':
        return piece.toLowerCase() == piece ? -900 : 900;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Futuristic Chess'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildBoard(),
            SizedBox(height: 20),
            Text(
              'Current Player: ${_chessBoard.gameState.currentPlayer == 'w' ? 'White' : 'Black'}',
              style: TextStyle(fontSize: 24, color: Colors.cyanAccent),
            ),
            if (_chessBoard.gameState.check)
              Text(
                'Check!',
                style: TextStyle(fontSize: 24, color: Colors.redAccent),
              ),
            if (_chessBoard.isGameOver())
              Text(
                _chessBoard.isCheckmate(_chessBoard.gameState.currentPlayer) ? 'Checkmate!' : 'Stalemate!',
                style: TextStyle(fontSize: 24, color: Colors.redAccent),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBoard() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 8,
          ),
          itemBuilder: _buildGridItems,
          itemCount: 64,
        ),
      ),
    );
  }

  Widget _buildGridItems(BuildContext context, int index) {
    final int x = index ~/ 8;
    final int y = index % 8;
    final String? piece = _chessBoard.board[x][y];

    return GestureDetector(
      onTap: () {
        _onSquareTapped(x, y);
      },
      child: Container(
        decoration: BoxDecoration(
          color: (x + y) % 2 == 0 
              ? Colors.deepPurple.withOpacity(0.7) 
              : Colors.deepPurple.withOpacity(0.3),
          border: Border.all(color: Colors.cyanAccent.withOpacity(0.3)),
        ),
        child: Center(
          child: piece != null
              ? _buildPiece(piece)
              : null,
        ),
      ),
    );
  }

  Widget _buildPiece(String piece) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            piece.toLowerCase() == piece ? Colors.black : Colors.white,
            piece.toLowerCase() == piece ? Colors.grey[800]! : Colors.grey[300]!,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(0.5),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Center(
        child: Text(
          _chessBoard.getPieceSymbol(piece),
          style: TextStyle(
            fontSize: 24,
            color: piece.toLowerCase() == piece ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

class ChessBoard {
  List<List<String?>> board;
  GameState gameState;

  ChessBoard()
      : board = List.generate(8, (i) => List.generate(8, (j) => null)),
        gameState = GameState();

  void initializeBoard() {
    board[0] = ['r', 'n', 'b', 'q', 'k', 'b', 'n', 'r'];
    board[1] = List.generate(8, (index) => 'p');
    
    for (int i = 2; i <= 5; i++) {
      board[i] = List.generate(8, (index) => null);
    }

    board[6] = List.generate(8, (index) => 'P');
    board[7] = ['R', 'N', 'B', 'Q', 'K', 'B', 'N', 'R'];
  }

  void switchPlayer() {
    gameState.currentPlayer = (gameState.currentPlayer == 'w') ? 'b' : 'w';
  }

  bool isPieceOwnedByCurrentPlayer(String piece) {
    if (gameState.currentPlayer == 'w' && piece.toUpperCase() == piece) {
      return true;
    }
    if (gameState.currentPlayer == 'b' && piece.toLowerCase() == piece) {
      return true;
    }
    return false;
  }

  bool isValidMove(int startX, int startY, int endX, int endY) {
    final String? piece = board[startX][startY];
    if (piece == null) return false;

    if (piece.toLowerCase() == 'k' && (startY - endY).abs() == 2) {
      return canCastle(endY > startY);
    }

    switch (piece.toLowerCase()) {
      case 'p':
        return _isValidPawnMove(piece, startX, startY, endX, endY);
      case 'r':
        return _isValidRookMove(startX, startY, endX, endY);
      case 'n':
        return _isValidKnightMove(startX, startY, endX, endY);
      case 'b':
        return _isValidBishopMove(startX, startY, endX, endY);
      case 'q':
        return _isValidQueenMove(startX, startY, endX, endY);
      case 'k':
        return _isValidKingMove(startX, startY, endX, endY);
      default:
        return false;
    }
  }

  void makeMove(int startX, int startY, int endX, int endY) {
    final String? piece = board[startX][startY];
    
    if (piece?.toLowerCase() == 'k' && (startY - endY).abs() == 2) {
      performCastling(endY > startY);
    } else {
      board[endX][endY] = piece;
      board[startX][startY] = null;
    }

    switchPlayer();
    if (isKingInCheck(gameState.currentPlayer)) {
      gameState.check = true;
    } else {
      gameState.check = false;
    }
  }

  bool _isValidPawnMove(String piece, int startX, int startY, int endX, int endY) {
    int direction = piece == 'P' ? -1 : 1;
    int startRow = piece == 'P' ? 6 : 1;
    if (startY == endY && board[endX][endY] == null) {
      if (endX == startX + direction) {
        return true;
      }
      if (startX == startRow && endX == startX + 2 * direction && board[startX + direction][endY] == null) {
        return true;
      }
    }

    if ((endY == startY + 1 || endY == startY - 1) && endX == startX + direction && board[endX][endY] != null) {
      return true;
    }

    return false;
  }

  bool _isValidRookMove(int startX, int startY, int endX, int endY) {
    if (startX != endX && startY != endY) return false;

    if (startX == endX) {
      for (int y = (startY < endY ? startY + 1 : endY + 1); y < (startY < endY ? endY : startY); y++) {
        if (board[startX][y] != null) return false;
      }
    }

    if (startY == endY) {
      for (int x = (startX < endX ? startX + 1 : endX + 1); x < (startX < endX ? endX : startX); x++) {
        if (board[x][startY] != null) return false;
      }
    }

    return true;
  }

  bool _isValidKnightMove(int startX, int startY, int endX, int endY) {
    int dx = (startX - endX).abs();
    int dy = (startY - endY).abs();
    return (dx == 2 && dy == 1) || (dx == 1 && dy == 2);
  }

  bool _isValidBishopMove(int startX, int startY, int endX, int endY) {
    if ((startX - endX).abs() != (startY - endY).abs()) return false;

    int dx = startX < endX ? 1 : -1;
    int dy = startY < endY ? 1 : -1;
    for (int i = 1; i < (startX - endX).abs(); i++) {
      if (board[startX + i * dx][startY + i * dy] != null) return false;
    }

    return true;
  }

  bool _isValidQueenMove(int startX, int startY, int endX, int endY) {
    return _isValidRookMove(startX, startY, endX, endY) || _isValidBishopMove(startX, startY, endX, endY);
  }

  bool _isValidKingMove(int startX, int startY, int endX, int endY) {
    return (startX - endX).abs() <= 1 && (startY - endY).abs() <= 1;
  }

  String getPieceSymbol(String piece) {
    switch (piece.toLowerCase()) {
      case 'p':
        return '♟';
      case 'r':
        return '♜';
      case 'n':
        return '♞';
      case 'b':
        return '♝';
      case 'q':
        return '♛';
      case 'k':
        return '♚';
      default:
        return '';
    }
  }

  bool isKingInCheck(String color) {
    int kingX = -1, kingY = -1;
    for (int x = 0; x < 8; x++) {
      for (int y = 0; y < 8; y++) {
        if (board[x][y] == (color == 'w' ? 'K' : 'k')) {
          kingX = x;
          kingY = y;
          break;
        }
      }
      if (kingX != -1) break;
    }

    for (int x = 0; x < 8; x++) {
      for (int y = 0; y < 8; y++) {
        if (board[x][y] != null && isPieceOwnedByCurrentPlayer(board[x][y]!) != (color == 'w')) {
          if (isValidMove(x, y, kingX, kingY)) {
            return true;
          }
        }
      }
    }
    return false;
  }

  bool canCastle(bool kingSide) {
    String king = gameState.currentPlayer == 'w' ? 'K' : 'k';
    String rook = gameState.currentPlayer == 'w' ? 'R' : 'r';
    int row = gameState.currentPlayer == 'w' ? 7 : 0;
    int kingCol = 4;
    int rookCol = kingSide ? 7 : 0;

    if (board[row][kingCol] != king || board[row][rookCol] != rook) {
      return false;
    }

    int start = kingSide ? kingCol + 1 : rookCol + 1;
    int end = kingSide ? rookCol : kingCol;
    for (int col = start; col < end; col++) {
      if (board[row][col] != null) {
        return false;
      }
    }

    if (isKingInCheck(gameState.currentPlayer)) {
      return false;
    }
    for (int col = kingCol; col != (kingSide ? kingCol + 2 : kingCol - 2); col += (kingSide ? 1 : -1)) {
      board[row][kingCol] = null;
      board[row][col] = king;
      bool inCheck = isKingInCheck(gameState.currentPlayer);
      board[row][col] = null;
      board[row][kingCol] = king;
      if (inCheck) {
        return false;
      }
    }

    return true;
  }

  void performCastling(bool kingSide) {
    int row = gameState.currentPlayer == 'w' ? 7 : 0;
    int kingCol = 4;
    int rookCol = kingSide ? 7 : 0;
    int newKingCol = kingSide ? 6 : 2;
    int newRookCol = kingSide ? 5 : 3;

    String king = board[row][kingCol]!;
    String rook = board[row][rookCol]!;

    board[row][kingCol] = null;
    board[row][rookCol] = null;
    board[row][newKingCol] = king;
    board[row][newRookCol] = rook;
  }

  bool isGameOver() {
    return isCheckmate(gameState.currentPlayer) || isStalemate(gameState.currentPlayer);
  }

  bool isCheckmate(String color) {
    if (!isKingInCheck(color)) {
      return false;
    }

    for (int startX = 0; startX < 8; startX++) {
      for (int startY = 0; startY < 8; startY++) {
        if (board[startX][startY] != null && isPieceOwnedByCurrentPlayer(board[startX][startY]!)) {
          for (int endX = 0; endX < 8; endX++) {
            for (int endY = 0; endY < 8; endY++) {
              if (isValidMove(startX, startY, endX, endY)) {
                ChessBoard newBoard = clone();
                newBoard.makeMove(startX, startY, endX, endY);
                if (!newBoard.isKingInCheck(color)) {
                  return false;
                }
              }
            }
          }
        }
      }
    }
    return true;
  }

  bool isStalemate(String color) {
    if (isKingInCheck(color)) {
      return false;
    }

    for (int startX = 0; startX < 8; startX++) {
      for (int startY = 0; startY < 8; startY++) {
        if (board[startX][startY] != null && isPieceOwnedByCurrentPlayer(board[startX][startY]!)) {
          for (int endX = 0; endX < 8; endX++) {
            for (int endY = 0; endY < 8; endY++) {
              if (isValidMove(startX, startY, endX, endY)) {
                ChessBoard newBoard = clone();
                newBoard.makeMove(startX, startY, endX, endY);
                if (!newBoard.isKingInCheck(color)) {
                  return false;
                }
              }
            }
          }
        }
      }
    }
    return true;
  }

  ChessBoard clone() {
    ChessBoard newBoard = ChessBoard();
    newBoard.board = List.generate(8, (i) => List.generate(8, (j) => board[i][j]));
    newBoard.gameState = GameState()
      ..currentPlayer = gameState.currentPlayer
      ..check = gameState.check;
    return newBoard;
  }
}

class GameState {
  String currentPlayer;
  bool check;

  GameState() : currentPlayer = 'w', check = false;
}