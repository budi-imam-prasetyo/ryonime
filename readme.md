# Dokumentasi RyoNime (Versi Terbaru)

## 📜 Tentang RyoNime
RyoNime adalah alat pencarian dan pemutaran anime berbasis CLI yang mengkhususkan diri pada konten ber-subtitle Indonesia dari channel Muse Indonesia. Projek ini merupakan modifikasi dari [animek-cli](https://github.com/THEUNFORGIVENNN/animek-cli) dengan penambahan fitur **auto-update** dan peningkatan stabilitas.

## ✨ Fitur Utama
1. **Pemilihan Resolusi Video**  
   Pilih kualitas video sesuai preferensi (360p, 480p, 720p, atau kualitas terbaik)
   
2. **Dukungan Multi-Pemutar**  
   Otomatis mendeteksi pemutar video: MPV (direkomendasikan), VLC, dan IINA (macOS)

3. **Antarmuka Interaktif Modern**  
   - Tampilan berwarna dengan navigasi panah  
   - Animasi loading  
   - Panel informasi lengkap  

4. **Sistem Auto-Update**  
   - Update ke versi terbaru tanpa chmod ulang  
   - Notifikasi versi baru  
   - Backup otomatis sebelum update  

5. **Filter Cerdas**  
   - Auto-skip video >1 jam  
   - Tampilkan durasi video sebelum diputar  

## 🚀 Instalasi Cepat

### Untuk Semua Platform:
```bash
# Download script
wget https://raw.githubusercontent.com/budi-imam-prasetyo/ryonime/main/ryonime.sh

# Berikan izin eksekusi
chmod +x ryonime.sh

# Jalankan
./ryonime.sh
```

### Instalasi Permanen (Linux/macOS):
```bash
# Pindahkan ke PATH sistem
mkdir -p ~/.local/bin
mv ryonime.sh ~/.local/bin/ryonime
chmod +x ~/.local/bin/ryonime

# Sekarang bisa dijalankan dari mana saja:
ryonime
```

> **Catatan**: Pastikan `~/.local/bin` ada di PATH Anda. Tambahkan di `~/.bashrc` atau `~/.zshrc`:
> ```bash
> export PATH="$HOME/.local/bin:$PATH"
> ```

## 🔄 Cara Update
RyoNime bisa diupdate dengan 3 cara:

1. **Melalui Menu Aplikasi**  
   Setelah selesai menonton, pilih opsi `[U] Update`
   
2. **Via Command Line**  
   ```bash
   ryonime --update
   ```
   
3. **Otomatis**  
   Aplikasi akan beri notifikasi jika ada versi baru

## 🖥️ Penggunaan
```bash
# Jalankan aplikasi
ryonime

# Tampilkan bantuan
ryonime --help

# Update versi terbaru
ryonime --update
```

### Alur Kerja:
```bash
$ ryonime
[?] Masukkan judul anime: Jujutsu Kaisen
[~] Mencari "Jujutsu Kaisen" di channel Muse Indonesia...
[+] Ditemukan 15 hasil:
╭──────────────────────────────────────────────────────╮
│ 1. Jujutsu Kaisen Episode 1                         00:23:45 │
│ 2. Jujutsu Kaisen Episode 2                         00:24:10 │
╰──────────────────────────────────────────────────────╯
[?] Pilih video [1-15]: 1
[~] Mendapatkan kualitas video...
[?] Pilih kualitas video:
  > Kualitas terbaik (default)
    720p
    480p
[?] Pilih pemutar video:
  > mpv
    vlc
[▶] Memutar: Jujutsu Kaisen Episode 1...
```

## 🆕 Fitur Auto-Update
RyoNime memiliki sistem update otomatis yang canggih:

- **Cek Versi Harian** - Aplikasi otomatis cek versi baru setiap hari
- **One-Click Update** - Update dengan satu klik tanpa terminal
- **Backup Otomatis** - Script lama di-backup sebelum diupdate
- **Restore Otomatis** - Kembali ke versi lama jika update gagal
- **Pertahankan Permission** - Tidak perlu chmod ulang setelah update

![Demo Auto-Update](https://example.com/ryonime-update-demo.gif)

## 🛠️ Konfigurasi Lanjutan
### Ubah Sumber Anime:
```bash
# Edit script dan ganti CHANNEL_ID
nano ~/.local/bin/ryonime

# Ganti dengan ID channel YouTube lain
CHANNEL_ID="UCxxxxxxxxxxxxxxxxx"
```

### Opsi Tambahan:
```bash
# Maksimal hasil pencarian (default: 15)
MAX_RESULTS=30

# Format video default
YTDLP_OPTS="--format bestvideo[height<=1080]+bestaudio/best"
```

## 🤝 Kontribusi
Kontribusi diterima melalui:
1. Pelaporan issue
2. Pull request untuk perbaikan bug
3. Usulan fitur baru
4. Perbaikan dokumentasi

## 📃 Lisensi
Proyek ini dilisensikan di bawah **[GPL-3.0 License](LICENSE)**. 

Anda diperbolehkan:
- Menggunakan secara komersial ✅
- Memodifikasi ✏️
- Mendistribusikan 📤
- Menggunakan secara pribadi 🔒

Dengan ketentuan:
- Menyertakan pemberitahuan hak cipta ©️
- Menyertakan salinan lisensi 📄
- Perubahan besar harus didokumentasikan 📝

## 📞 Kontak
- Issues: [https://github.com/budi-imam-prasetyo/ryonime/issues](https://github.com/budi-imam-prasetyo/ryonime/issues)
- Email: budi.imam.prasetyo@example.com

---

**RyoNime** © 2024 - Anime Gratis, Bahagia Tanpa Iklan!