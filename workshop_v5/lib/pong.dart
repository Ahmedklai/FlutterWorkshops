import 'package:flutter/material.dart';
import './ball.dart';
import './bat.dart';
import 'dart:math';

enum Direction { up, down, left, right }

class Pong extends StatefulWidget {
  @override
  _PongState createState() => _PongState();
}

class _PongState extends State<Pong> with TickerProviderStateMixin {
  double width;
  double height;
  double posX = 30;
  Direction vDir = Direction.down;
  Direction hDir = Direction.right;
  double posY = 30;
  int score = 0;

  double batWidth = 0;
  double batHeight = 0;
  double bat1Position = 0;
  double bat2Position = 0;
  double increment = 5;
  double diameter = 50;
  double randX = 1;
  double randY = 1;

  Animation<double> animation;
  AnimationController controller;
  double randomNumber() {
    //this is a number between 0.5 and 1.5;
    var ran = new Random();
    int myNum = ran.nextInt(101);
    return (50 + myNum) / 100;
  }

  void safeSetState(Function function) {
    if (mounted && controller.isAnimating) {
      setState(() {
        function();
      });
    }
  }

  void moveBat(DragUpdateDetails update) {
    safeSetState(() {
      bat1Position += update.delta.dx;
    });
  }

  void moveBate(DragUpdateDetails update) {
    safeSetState(() {
      bat2Position += update.delta.dx;
    });
  }

  void checkBorders() {
    double diameter = 50;
    if (posX <= 0 && hDir == Direction.left) {
      hDir = Direction.right;
      randX = randomNumber();
    }
    if (posX >= width - diameter && hDir == Direction.right) {
      hDir = Direction.left;
      randX = randomNumber();
    }
    //check the bat position as well
    if (posY >= height - diameter - batHeight && vDir == Direction.down) {
      //check if the bat is here, otherwise loose
      if (posX >= (bat1Position - diameter) &&
          posX <= (bat1Position + batWidth + diameter)) {
        vDir = Direction.up;
        randY = randomNumber();
        score += 1;
      } else {
        controller.stop();
        showMessage(context);
      }
    }
    if (posY <= 0 + batHeight && vDir == Direction.up) {
      if (posX >= (bat2Position - diameter) &&
          posX <= (bat2Position + batWidth + diameter)) {
        vDir = Direction.down;
        randY = randomNumber();
        score += 1;
      } else {
        controller.stop();
        showMessage(context);
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void showMessage(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Game Over'),
            content: Text('Would you like to play again?'),
            actions: <Widget>[
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  setState(() {
                    posX = 30;
                    posY = 30;
                    score = 0;
                    bat2Position = 0;
                  });
                  Navigator.of(context).pop();
                  controller.repeat();
                },
              ),
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                  dispose();
                },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    posX = 0;
    posY = 0;
    controller = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 3000),
    );
    controller.forward();
    super.initState();
    animation = Tween<double>(begin: 0, end: 100).animate(controller);
    animation.addListener(() {
      safeSetState(() {
        (hDir == Direction.right)
            ? posX += ((increment * randX).round())
            : posX -= ((increment * randX).round());
        (vDir == Direction.down)
            ? posY += ((increment * randY).round())
            : posY -= ((increment * randY).round());
      });
      checkBorders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      height = constraints.maxHeight;
      width = constraints.maxWidth;

      batWidth = width / 5;
      batHeight = height / 20;

      return Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            right: 24,
            child: Text('Score: ' + score.toString()),
          ),
          Positioned(
              top: 0,
              left: bat2Position,
              child: GestureDetector(
                  onHorizontalDragUpdate: (DragUpdateDetails updatee) =>
                      moveBate(updatee),
                  child: Bat(batWidth, batHeight))),
          Positioned(
            child: Ball(),
            top: posY,
            left: posX,
          ),
          Positioned(
              bottom: 0,
              left: bat1Position,
              child: GestureDetector(
                  onHorizontalDragUpdate: (DragUpdateDetails update) =>
                      moveBat(update),
                  child: Bat(batWidth, batHeight))),
        ],
      );
    });
  }
}
