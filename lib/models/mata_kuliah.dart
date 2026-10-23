class MataKuliah {
  final String kode;
  final String nama;
  final int sks;
  final String dosen;

  const MataKuliah({
    required this.kode,
    required this.nama,
    required this.sks,
    required this.dosen,
  });
}

const List<MataKuliah> daftarMataKuliah = [
  MataKuliah(kode: 'IF101', nama: 'Pemrograman Mobile', sks: 3, dosen: 'Dr. Budi Santoso'),
  MataKuliah(kode: 'IF102', nama: 'Basis Data', sks: 3, dosen: 'Ir. Siti Aminah'),
  MataKuliah(kode: 'IF103', nama: 'Jaringan Komputer', sks: 3, dosen: 'Rahmat Hidayat, M.Kom'),
  MataKuliah(kode: 'IF104', nama: 'Kecerdasan Buatan', sks: 3, dosen: 'Dr. Dewi Lestari'),
  MataKuliah(kode: 'IF105', nama: 'Rekayasa Perangkat Lunak', sks: 4, dosen: 'Agus Prasetyo, M.T'),
  MataKuliah(kode: 'IF106', nama: 'Keamanan Informasi', sks: 2, dosen: 'Dian Kurniawan, M.Kom'),
  MataKuliah(kode: 'IF107', nama: 'Interaksi Manusia & Komputer', sks: 3, dosen: 'Nina Marlina, M.T'),
  MataKuliah(kode: 'IF108', nama: 'Statistika', sks: 2, dosen: 'Prof. Hendra Wijaya'),
  MataKuliah(kode: 'UM101', nama: 'Bahasa Inggris', sks: 2, dosen: 'Maya Putri, M.Pd'),
  MataKuliah(kode: 'UM102', nama: 'Kewirausahaan', sks: 2, dosen: 'Bambang Setiawan, M.M'),
];
