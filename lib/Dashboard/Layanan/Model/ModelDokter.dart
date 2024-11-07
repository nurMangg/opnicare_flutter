class Dokter {
  String id;
  String namaDokter;
  String tentang;
  String spesialis;
  String image;


  Dokter({
    required this.id,
    required this.namaDokter,
    required this.tentang,
    required this.spesialis,
    required this.image,
  });

  factory Dokter.fromJson(Map<String, dynamic> json) {
    return Dokter(
      id: json['id'].toString() ?? '',
      namaDokter: json['nama'] ?? 'unKnown',
      tentang: json['email'] ?? 'Tidak ada',
      spesialis: json['spesialisasi'] ?? 'Tidak Ada',
      image: json['image'] ?? '',
    );
  }
}