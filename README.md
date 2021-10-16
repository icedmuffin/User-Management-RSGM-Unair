# Summary
Apa repository ini?\
  Ini adalah repository kerja Project Modul User Management RSGM Unair kelompok 1, matakuliah Rancang Bangun Perangkat Lunak, Departemen Sistem Informasi ITS\
\
Summary repository ?\
  dalam project ini kita melakukan development software untuk RSGM Unair menggunakan bahasa pemrograman java, dengan 5 modul utama,\
  modul tediri dari modul :
  
  1. Pendaftaran
  2. Pembayaran
  4. Rekam Medik
  3. Apotek
  5. Jaminan Kesehatan Nasional

Software Yang di butuhkan
 - Apache CoachDB, digunakan untuk database modul
 - Apache Ant, Mekanisme deploy
 - Apache Tomcat, Server untuk deploy Software
  
  
# rbpl_c_kelompok1
Kelompok 1 :
Zaidan Fathi Yakan - 05211940000092  
Naufal S A Sunandar - 05211940000104  
Surya Eka Adji Winanto - 05211840000097  
Naufal Fakhri Ardhan Laxito - 05211840000130  
  
  
# Timeline
 
15 Juni 2021 insisasi - 13 juli 2021
Requirement permodul. 
      
    - high level requirement  
    - GUI storyborad  
    - use case  
    - rubustness analysis  

# Setup
Setup Server
```
database name : rsgm_unair
```
dokumen view name - apache coachDB 
```
- user
- dokter
- pasien
- pendaftaran
- pembayaran
- rekammedik
- apotek
- igd
- jkn
```
script map function
```
function (doc) {
if(doc._id.startsWith("[blank]:")){
emit(doc._id, null);
}
}
```

Inisiasi Sofware
```
url_local_host/user_management/pre_seed
```

Akses Admin 
```
username : admin
password : admin123
````

command ant all-remove-install
```
ant gas
```
