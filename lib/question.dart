class Question {
  late String text;
  late String image;
  late bool answer;
  Question({required String q, required String i, required bool a}) {
    text = q;
    image = i;
    answer = a;
  }
}
