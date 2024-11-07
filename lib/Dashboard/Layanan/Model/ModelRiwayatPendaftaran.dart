class RiwayatPendaftaran {
  final int id;
  final String noPendaftaran;
  final String pasienId;
  final String dokterId;
  final String poliId;
  final String tanggalDaftar;
  final String keluhan;
  final String status;
  final String createdAt;
  final String updatedAt;

  RiwayatPendaftaran({
    required this.id,
    required this.noPendaftaran,
    required this.pasienId,
    required this.dokterId,
    required this.poliId,
    required this.tanggalDaftar,
    required this.keluhan,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RiwayatPendaftaran.fromJson(Map<String, dynamic> json) {
    return RiwayatPendaftaran(
      id: json['id'],
      noPendaftaran: json['no_pendaftaran'],
      pasienId: json['pasien_id'],
      dokterId: json['nama'],
      poliId: json['nama_poli'],
      tanggalDaftar: json['tanggal_daftar'],
      keluhan: json['keluhan'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
