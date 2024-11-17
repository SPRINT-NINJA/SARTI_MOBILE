enum FromWho { mine, hers }

class Msg {
  final String text;
  final String? imageUrl;
  final FromWho fromWho;

  Msg({
    required this.text,
    this.imageUrl,
    required this.fromWho,
  });
}
