void main() {
  // print(DateTime.now()-DateTime.parse('2025-05-05 12:30:22.710768'));
  // DateTime.;
  // Duration d =
  //     DateTime.now().difference(DateTime.parse('2023-05-04 12:30:22.710768'));
  // print(d);
  // if (d.inMinutes >5) {
  //   print("YES IT IS BIGGER THAN FIVE MINUTES");
  // }
  fun1();
  fun2();
}

void fun1() async {
  await Future.delayed(Duration(seconds: 3), () {
    print("delayed");
  });
}

void fun2() async {
  print("I am faster");
}
