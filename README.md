Apa repository ini?\
  Ini adalah repository kerja kelompok 1, matakuliah Rancang Bangun Perangkat Lunak, Departemen Sistem Informasi ITS\
\
Summary repository ?\
  dalam project ini kita melakukan development software untuk RSGM Unair, dengan 5 modul utama,\
  modul tediri dari modul :
  
  1. Pendaftaran
  2. Pembayaran
  4. Rekam Medik
  3. Apotek
  5. Jaminan Kesehatan Nasional
  
  
# rbpl_c_kelompok1
Kelompok 1 :
Zaidan Fathi Yakan - 05211940000092  
Naufal S A Sunandar - 05211940000104  
Surya Eka Adji Winanto - 05211840000097  
Naufal Fakhri Ardhan Laxito - 05211840000130  
  
  
Progress per:  
  
15 Juni 2021  
Requirement permodul - DONE. 
      
    - high level requirement  
    - GUI storyborad  
    - use case  
    - rubustness analysis  
    
7 Juli 2021
Modul JKN diperbarui

10 Juli 2021
Modul JKN selesai

13 Juli 2021
all modul - selesai
semua fungsi dasar berhasil dijalankan

dokumen view name - apache coachDB
```
- modul Pendaftaran --> pendaftaran
- modul Pembayaran --> pembayaran
- modul Rekam Medik --> rekammedik
- modul JKN --> jkn
```
script map function
```
function (doc) {
if(doc._id.startsWith("[blank]:")){
emit(doc._id, null);
}
}
```
