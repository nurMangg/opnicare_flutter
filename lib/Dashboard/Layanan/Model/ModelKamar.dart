class Kamar {
  final String nomorKamar;
  final String namaKamar;
  final String fasilitas;
  final String status;
  final int quantity;

  Kamar({
    required this.nomorKamar,
    required this.namaKamar,
    required this.fasilitas,
    required this.status,
    required this.quantity,
  });

  factory Kamar.fromJson(Map<String, dynamic> json) {
    return Kamar(
      nomorKamar: json['tipe_kamar'] ?? 'Unknown',
      namaKamar: json['tipe_kamar'] ?? 'Unknown',
      fasilitas: json['fasilitas'] ?? '',
      status: json['status'] ?? 'kosong',
      quantity: json['kapasitas'] ?? 0,
    );
  }
}