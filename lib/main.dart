import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: QuizzlerPage(),
    );
  }
}

class QuizzlerPage extends StatefulWidget {
  const QuizzlerPage({Key? key}) : super(key: key);

  @override
  State<QuizzlerPage> createState() => _QuizzlerPageState();
}

class _QuizzlerPageState extends State<QuizzlerPage> {
  List<Icon> answerIcons = [];

  void theAnswer(bool userAnswer) {
    bool questionAnswer = quizBrain.getAnswer();
    setState(() {
      if (quizBrain.questionIsFinished()) {
        Alert(
          context: context,
          type: AlertType.success,
          title: "Finished!",
          desc: "You've reached the end of the quiz.",
          buttons: [
            DialogButton(
              onPressed: () {
                setState(() {
                  answerIcons.clear();
                  quizBrain.questionRestart();
                  Navigator.pop(context);
                });
              },
              width: 120,
              child: const Text(
                "Restart",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ).show();
      }

      if (quizBrain.questionIsFinished() == false) {
        if (userAnswer == questionAnswer) {
          answerIcons.add(
            const Icon(Icons.check, color: Colors.green),
          );
        } else {
          answerIcons.add(
            const Icon(Icons.close, color: Colors.red),
          );
        }
      }
      quizBrain.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        quizBrain.getQuestionText(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.green),
                    ),
                    onPressed: () {
                      theAnswer(true);
                    },
                    child: const Text(
                      'True',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.red),
                    ),
                    onPressed: () {
                      theAnswer(false);
                    },
                    child: const Text(
                      'False',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: answerIcons,
              )
            ],
          ),
        ),
      ),
    );
  }
}
