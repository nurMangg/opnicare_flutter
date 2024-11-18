class Keranjang {
  String medicine_id;
  String obatName;
  String price;
  String quantity;
  String image;

  Keranjang({
    required this.medicine_id,
    required this.obatName,
    required this.price,
    required this.quantity,
    required this.image,
  });

  factory Keranjang.fromJson(Map<String, dynamic> json) {
    return Keranjang(
      medicine_id: json['medicine_id'],
      obatName: json['nama_obat'],
      price: json['harga'],
      quantity: json['jumlah'].toString(),
      image: json['foto'],
    );
  }
}
