import 'package:flutter/material.dart';
import 'quiz_logic.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(ExamApp());
}

QuizLogic newQuiz = QuizLogic();

class ExamApp extends StatefulWidget {
  const ExamApp({super.key});

  @override
  State<ExamApp> createState() => _MyAppState();
}

class _MyAppState extends State<ExamApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 28, 7, 87),
          title: Text(
            'Cars quiz',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: QuizPage(),
        ),
      ),
    );
  }
}

Padding answerIcon(bool isTrue) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20, right: 20),
    child: Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        color: isTrue ? Colors.green : Colors.red,
        shape: BoxShape.circle,
      ),
      child: Icon(
        isTrue ? Icons.check : Icons.close,
        color: Colors.white,
        size: 16,
      ),
    ),
  );
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Padding> iconList = [];
  int cpt = 0;
  int correctAnswers = 0;
  void checkAnswer(bool whatUserPicked) {
    cpt++;
    if (cpt < newQuiz.getQuizLength() + 1) {
      if (newQuiz.getQuestionAnswer() == whatUserPicked) correctAnswers++;
      iconList.add(
        answerIcon((newQuiz.getQuestionAnswer() == whatUserPicked)),
      );
    }
    if (newQuiz.isFinished()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Quiz Finished'),
            content: Text('You have got $correctAnswers correct answers.'),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    iconList.clear();
                    cpt = 0;
                    correctAnswers = 0;
                    newQuiz.reset();
                  });
                  Navigator.pop(context);
                },
                child: Text('Restart'),
              ),
              TextButton(
                onPressed: () {
                  // Close the dialog
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      newQuiz.nextQuestion();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  newQuiz.getQuestionImage(),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    newQuiz.getQuestionText(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w700,
                      fontSize: 23,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 60,
          child: Row(
            children: iconList,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: TextButton(
              onPressed: () {
                setState(() {
                  checkAnswer(true);
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 28, 7, 87)),
              ),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 23,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.redAccent),
              ),
              onPressed: () {
                setState(() {
                  checkAnswer(false);
                });
              },
              child: Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 23,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
