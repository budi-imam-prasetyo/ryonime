# Dokumentasi RyoNime

## 📜 Tentang RyoNime
RyoNime adalah alat pencarian dan pemutaran anime berbasis CLI yang mengkhususkan diri pada konten ber-subtitle Indonesia dari channel Muse Indonesia. Projek ini merupakan modifikasi dari [animek-cli](https://github.com/THEUNFORGIVENNN/animek-cli) dengan penambahan fitur dan peningkatan stabilitas.

## ✨ Fitur Utama
1. **Pemilihan Resolusi Video**  
   Pengguna dapat memilih kualitas video sesuai preferensi (360p, 480p, 720p, atau kualitas terbaik)

2. **Dukungan Multi-Pemutar**  
   Mendukung berbagai pemutar video: MPV (direkomendasikan), VLC, dan IINA (untuk macOS)

3. **Antarmuka Interaktif**  
   Menu navigasi intuitif dengan dukungan tombol panah dan tampilan berwarna

4. **Informasi Video Lengkap**  
   Menampilkan durasi video sebelum diputar untuk membantu pengambilan keputusan

5. **Filter Konten Otomatis**  
   Otomatis menyaring video dengan durasi lebih dari 1 jam

6. **Penanganan Error Komprehensif**  
   Sistem notifikasi error yang informatif dengan solusi praktis

## 📥 Prasyarat dan Instalasi

### Dependensi Wajib
```bash
# Instal yt-dlp
pip3 install yt-dlp

# Instal salah satu pemutar video:
# Untuk MPV (direkomendasikan)
sudo apt install mpv

# Untuk VLC
sudo apt install vlc

# Untuk IINA (macOS)
brew install iina
```

### Instalasi RyoNime
```bash
# Download script
wget https://raw.githubusercontent.com/username/ryonime/main/ryonime.sh

# Berikan izin eksekusi
chmod +x ryonime.sh

# Jalankan aplikasi
./ryonime.sh

# Jika ingin dijalankan tanpa (.sh)

    mv ryonime.sh ryonime
    mv ryonime ~/.local/bin/
```

## 🖥️ Penggunaan
1. Jalankan script di terminal
2. Masukkan judul anime yang ingin dicari
3. Pilih video dari daftar hasil
4. Pilih kualitas resolusi yang diinginkan
5. Pilih pemutar video yang tersedia
6. Video akan diputar secara otomatis

```bash
Contoh alur:
$ ryonime
[?] Masukkan judul anime: Jujutsu Kaisen
[~] Mencari "Jujutsu Kaisen" di channel Muse Indonesia...
[+] Ditemukan 15 hasil:
──────────────────────────────────
 1. Jujutsu Kaisen Episode 1
 2. Jujutsu Kaisen Episode 2
 ...
──────────────────────────────────
[?] Pilih video [1-15]: 1
[~] Mendapatkan kualitas video...
[?] Pilih kualitas video:
 1. Kualitas terbaik (default)
 2. 720p
 3. 480p
[▶] Memutar: Jujutsu Kaisen Episode 1...
```

## 🛠️ Fitur Teknis Tambahan
Proyek ini telah ditingkatkan dengan beberapa fitur teknis:

### 1. Sistem Deteksi Pemutar Otomatis
Script secara otomatis mendeteksi aplikasi pemutar video yang terinstall di sistem pengguna dan menyesuaikan opsi yang tersedia

### 2. Navigasi Berbasis Panah
Antarmuka yang mendukung navigasi dengan tombol panah untuk pengalaman pengguna yang lebih intuitif

### 3. Validasi Input Terlapis
Sistem validasi input multi-level untuk memastikan stabilitas aplikasi pada berbagai kondisi penggunaan

### 4. Sistem Pelaporan Error Terstruktur
Mekanisme penanganan error yang memberikan informasi spesifik dan solusi praktis untuk berbagai skenario error

## 🔧 Modifikasi
Pengguna dapat melakukan modifikasi sesuai kebutuhan:
```bash
# Ganti channel sumber
CHANNEL_ID="UCxxxxxxxxxxxxxxxxx"  # Ganti dengan ID channel YouTube lain

# Sesuaikan jumlah hasil maksimal
MAX_RESULTS=30  # Default: 20

# Tambahkan opsi yt-dlp tambahan
YTDLP_OPTS="--format bestvideo[height<=720]+bestaudio/best[height<=720]"
```

## 🤝 Kontribusi
Kontribusi untuk pengembangan RyoNime dapat dilakukan melalui:
1. Pelaporan issue di repositori
2. Mengajukan pull request untuk perbaikan bug
3. Mengusulkan fitur baru melalui diskusi

## 📃 Lisensi
Proyek ini dilisensikan di bawah [GPL-3.0 License](LICENSE). Pengguna diizinkan untuk:
- Menggunakan secara komersial
- Memodifikasi
- Mendistribusikan
- Menggunakan secara pribadi

Dengan ketentuan:
- Menyertakan pemberitahuan hak cipta
- Menyertakan salinan lisensi
- Perubahan besar harus didokumentasikan

## 📞 Kontak
Untuk pertanyaan lebih lanjut, silakan buka issue di repositori GitHub proyek ini.