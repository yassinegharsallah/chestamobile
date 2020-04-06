import 'Question.dart';

class QuizBrain{

  int _questionNumber = 0;

  List<Question> _questionBank = [
    Question('Votre temperature est plus de 38 ?', true),
    Question('Vous avez u mal ou poumons ?', false),
    Question('etes vous fumeur ?', true),
    Question('avez des problemes de respiration.', true),
    Question('etes vous plus que 65 ans ?', true),
    Question('avez vous des problemes cardiques ? ', true),
    Question(
        'No piece of square dry paper can be folded in half more than 7 times.',
        false),
    Question(
        'In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.',
        true),
    Question(
        'The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.',
        false),
    Question(
        'The total surface area of two human lungs is approximately 70 square metres.',
        true),
    Question('Google was originally called \"Backrub\".', true),
    Question(
        'Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.',
        true),
    Question(
        'In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.',
        true),
  ];

  int nextQuestion(){
      _questionNumber++;
      return _questionNumber ;

  }

  String getQuestionText(){
    return _questionBank[_questionNumber].question;
  }

  bool getCorrectAnswer(){
    return _questionBank[_questionNumber].answer;
  }
}


