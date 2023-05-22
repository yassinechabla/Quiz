import 'question.dart';

class QuizLogic {
  final List<Question> _questionGroup = [
    Question(
        q: 'Bugatti Veyron is the fastest production car',
        i: 'images/veyron.jpg',
        a: false),
    Question(q: 'McLaren P1 is a hybrid car', i: 'images/mclaren.jpg', a: true),
    Question(
        q: 'Ferrari LaFerrari has a V12 engine',
        i: 'images/laferrari.jpg',
        a: false),
    Question(
        q: 'Koenigsegg Jesko has a top speed over 300 mph',
        i: 'images/koenigsegg.jpg',
        a: true),
    Question(
        q: 'Lamborghini Aventador SVJ holds the Nürburgring lap record',
        i: 'images/aventador.jpg',
        a: true),
    Question(
        q: 'The Porsche 911 GT2 RS is rear-wheel drive',
        i: 'images/911 gt2.jpg',
        a: false),
  ];
  int _questionNumber = 0;
  int getQuizLength() {
    return _questionGroup.length;
  }

  int getQuestionNumber() {
    return _questionNumber;
  }

  void nextQuestion() {
    if (_questionNumber < _questionGroup.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questionGroup[_questionNumber].text;
  }

  String getQuestionImage() {
    return _questionGroup[_questionNumber].image;
  }

  bool getQuestionAnswer() {
    return _questionGroup[_questionNumber].answer;
  }

  bool isFinished() {
    return _questionNumber > _questionGroup.length - 2;
  }

  void reset() {
    _questionNumber = 0;
  }
}
