import 'package:flutter/material.dart';
import 'package:tic_tac_toe/ui_theme/color.dart';
import 'package:tic_tac_toe/utils/game_logic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
 String lastValue = "X";
 bool gameOver = false;
 int turn =0;
 String result = "";
 List<int> scoreboard = [0,0,0,0,0,0,0,0];

 Game game = Game();

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    game.board = Game.initGameBoard();
    print(game.board);
  }

  @override
  Widget build(BuildContext context) {
   double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MainColor.primaryColor ,
        shadowColor: Colors.white,
        centerTitle: true,
        title: Text("Tic-Tact-Toe",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
     backgroundColor: MainColor.primaryColor ,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40.0,),
            Text("It's  ${lastValue}  turn".toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
            ),),
          SizedBox(height: 25.0,),
          Container(
            width: boardWidth,
            height: boardWidth,
            child: GridView.count(crossAxisCount: Game.boardlenth ~/ 3,
              padding: EdgeInsets.all(16.0),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: List.generate(Game.boardlenth, (index){
              return InkWell(
                onTap: gameOver ?null:() {
                  if(game.board![index] == ""){
                    setState(() {
                      game.board![index] = lastValue;
                      turn++;
                      gameOver = game.winnerCheck(lastValue, index, scoreboard, 3);
                      if(gameOver){
                        result = "$lastValue is the Winner";
                      }else if(!gameOver && turn == 9){
                        result = "It's a Draw!";
                        gameOver = true;
                      }
                      if(lastValue == "X")
                        lastValue = "0";
                      else
                        lastValue = "X";
                    });
                  }
                },
                child: Container(
                  width: Game.blocSize ,
                  height: Game.blocSize,
                  decoration: BoxDecoration(
                    color: MainColor.secondaryColor,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Center(
                    child: Text(game.board ! [index],
                    style: TextStyle(
                      color: game.board![index] == "X"
                          ? Colors.blue
                          : Colors.pink,
                      fontSize: 64.0,
                    ),
                    ),
                  ),
                ),
              );
            }),),

          ),
          SizedBox(height: 35.0,),
          Text(result,style: TextStyle(color: Colors.white, fontSize: 40.0),),
          SizedBox(height: 35.0,),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                game.board = Game.initGameBoard();
                lastValue = "X";
                gameOver = false;
                turn=0;
                result="";
                scoreboard = [0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0];
              });
    } ,
            icon: Icon(Icons.replay),
            label: Text("Repeat the Game"),
            ),

        ],
      ),
    );
  }
}
