import 'dart:async';

Stream<int> getNumbers() async* {
  for (var i = 0; i < 5; i++) {
    await Future.delayed(Duration(seconds: 1));
    // if (i == 2) {
    //   throw Exception("i 2 oldu hata çıktı");
    // }
    yield i;
  }
}

StreamController<int> _controller = StreamController<
    int>(); //çoklu listener yapabilmek için StreamController<int>.broadcast() olmalı
Stream<int> get myStream => _controller.stream;
Sink<int> get mySink => _controller.sink;
//reactive programlama
void main(List<String> args) {
  //subscriptionProcess();
  //broadCastStream();

  streamVeriEkle();
  streamControllerKullanimi();
}

void streamControllerKullanimi() {
  myStream.listen((event) {
    print(event);
  });
}

void streamVeriEkle() async {
  await Future.delayed(const Duration(seconds: 2));
  mySink.add(5);
  await Future.delayed(const Duration(seconds: 2));
  mySink.add(15);
  await Future.delayed(const Duration(seconds: 2));
  mySink.add(25);
}

//bir streamden uygulamamıza veri geliyor ve biz iki farklı yerden dinliyorsak broadcast olur.
void broadCastStream() async {
  //normalde bir stream sadece bir kişi tarafından dinlenebilir.
  //var myStream = getNumbers();

  //bir streami birden fazla yer dinlemesini istersek yai broadcast ise asBroadcastStream methodunu çalıştırmalıyız.
  var myStream = getNumbers().asBroadcastStream();

  // myStream.listen((event) {
  //   print("Listen 1 : $event");
  // });

  // myStream.listen((event) {
  //   print("Listen 2 : $event");
  // });

  //streamlerde işlem yaparken listelerle aynı şekilde yapabiliriz. genelikle aynı
  // contains(stream bitince içinde 5 varsa true döndür) ,
  //elementAt(2. indexteki elemanı bana ver),
  //any(elementin 1 e eşit olduğu yerler varsa true döndürür.)
  //join(",") elemanların arasına virgül koyup yazdır.
  // print(await myStream.first);
  // print(await myStream.last);
  // print(await myStream.length);
}

void streamMethodlari() {
  final myStream = getNumbers();

  // myStream.expand((element) => [element, element + 2, 99]).listen((event) { //gelen elemanı çoğaltarak ver
  //   print(event);
  // });

  // myStream.map((event) => event * 5).listen((event) {
  //   //gelen elemanı modifiye etme
  //   print(event);
  // });

  // myStream.where((event) => event % 2 == 0).listen((event) {
  //   //filtreleme
  //   print(event);
  // });

  // myStream.take(2).listen((event) {
  //   //streamin ilk iki elemanını yazdır.
  //   print(event);
  // });

  // myStream.skip(2).listen((event) {
  //   //streamin ilk iki elemanını iptal et gerisini yazdır.
  //   print(event);
  // });

  // myStream.distinct().listen((event) {
  //   //Stream bir elemanı 2 3 defa yield ediyorsa normalde ekranda 2 3 defa gzükür. Distinct dersek aynı elemanı sadece 1 kere yazdırır.
  //   print(event);
  // });

  // myStream
  //     .distinct()
  //     .map((event) => event * 2)
  //     .where((event) => event < 3)
  //     .listen((event) {
  //   //zincirleme yapılabilir.
  //   print(event);
  // });
}

void subscriptionProcess() {
  var subs = getNumbers().listen((event) {});
  subs.onData((data) {
    print(data);
  });
  subs.onError((err) {
    print("Hata çıktı : $err");
  });
  subs.onDone(() {
    print("stream edilecek değer kalmadı");
  });
}
