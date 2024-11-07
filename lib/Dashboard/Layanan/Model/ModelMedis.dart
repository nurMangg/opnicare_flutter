class Obat {
  final String obatName;
  final String indikasi;
  final String dosis;
  final String efekSamping;
  final String interaksiObat;
  final String peringatan;
  final String price;
  final int quantity;
  final String image;

  Obat({
    required this.obatName,
    required this.indikasi,
    required this.dosis,
    required this.efekSamping,
    required this.interaksiObat,
    required this.peringatan,
    required this.price,
    required this.quantity,
    required this.image,
  });

  factory Obat.fromJson(Map<String, dynamic> json) {
    return Obat(
      obatName: json['nama_obat'] ?? 'Unknown',
      indikasi: json['efek_samping'] ?? 'Tidak ada',
      dosis: json['bentuk_dosis'] ?? '',
      efekSamping: json['efekSamping'] ?? '',
      interaksiObat: json['instruksi_penggunaan'] ?? '',
      peringatan: json['instruksi_penyimpanan'] ?? 'Tidak ada',
      price: json['harga'] ?? 0,
      quantity: json['jumlah_stok'] ?? 0,
      image: json['foto'] ?? '',
    );
  }
}