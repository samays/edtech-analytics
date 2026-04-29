# EdTech Platform Analytics

**Claude + ChatGPT + BigQuery** ile uçtan uca veri analizi vaka çalışması.

## 📌 Proje Özeti

Bir çevrim içi eğitim platformunun kullanıcı davranışlarını analiz ederek retention ve dönüşüm oranlarını iyileştirmeye yönelik veri odaklı öneriler ürettim.

**Kullanılan araçlar:**
- Claude — veri analizi ve metrik planlaması
- ChatGPT — SQL sorgu geliştirme
- Google BigQuery Sandbox — sorgu çalıştırma (ücretsiz)

---

## 📂 Repo Yapısı

```
edtech-analytics/
├── data/
│   └── edtech_sessions.csv       # Ham veri seti
├── sql/
│   ├── 01_completion_rate.sql    # Kurs bazında completion rate
│   ├── 02_retention.sql          # D1 / D7 retention
│   ├── 03_conversion.sql         # Free → Premium dönüşüm
│   ├── 04_avg_session.sql        # Ortalama session süresi
│   └── 05_device_segment.sql     # Cihaz × abonelik segmenti
└── README.md
```

---

## 📊 Veri Seti

| Alan | Tip | Açıklama |
|------|-----|----------|
| `date` | DATE | Oturum tarihi |
| `user_id` | STRING | Kullanıcı kimliği |
| `course_id` | STRING | Kurs kimliği (C101, C102, C103) |
| `lesson_completed` | BOOLEAN | Ders tamamlandı mı? |
| `time_spent` | INTEGER | Oturumda geçirilen süre (dk) |
| `device_type` | STRING | mobile / desktop / tablet |
| `subscription_type` | STRING | free / premium |

**Kapsam:** 52 oturum · 32 kullanıcı · 3 kurs · Ocak–Şubat 2024

---

## 🔍 Temel Bulgular

| Metrik | Değer | Durum |
|--------|-------|-------|
| D1 Retention | %6.25 | 🔴 Kritik |
| Genel Completion Rate | %71 | 🟡 Orta |
| C103 Completion | %100 | 🟢 İyi |
| C101 Completion | %55 | 🔴 Düşük |
| Tablet ort. session | 51 dk | 🟢 En yüksek |
| Mobile Free ort. session | 29 dk | 🔴 En düşük |

---

## 📋 SQL Sorguları — BigQuery

Tüm sorgular `sql/` klasöründe. BigQuery'de çalıştırmak için:

1. [BigQuery Sandbox](https://console.cloud.google.com/bigquery) açın (ücretsiz)
2. Dataset oluşturun: `edtech`
3. `data/edtech_sessions.csv` dosyasını `sessions` tablosu olarak yükleyin
4. `sql/` klasöründeki sorguları sırayla çalıştırın

---

## 🧪 A/B Test Planı

| Test | Hipotez | Hedef | Süre |
|------|---------|-------|------|
| Onboarding Nudge | 24s bildirim D7 retention artırır | %19 → %28 | 4 hafta |
| C101 Micro-lesson | Kısa dersler completion artırır | %55 → %75 | 3 hafta |
| Premium Preview | Önizleme dönüşüm artırır | +%15 | 6 hafta |

---

## 🚀 Nasıl Başlarsınız?

```bash
git clone https://github.com/KULLANICI_ADINIZ/edtech-analytics.git
cd edtech-analytics
```

BigQuery'de tabloyu oluşturmak için direkt SQL da kullanabilirsiniz:

```sql
CREATE OR REPLACE TABLE `edtech.sessions` AS
SELECT * FROM UNNEST([
  STRUCT('2024-01-01' AS date,'U001' AS user_id,'C101' AS course_id,
         true AS lesson_completed,45 AS time_spent,'mobile' AS device_type,'free' AS subscription_type)
  -- data/edtech_sessions.csv dosyasından tam veri
]);
```

---

## 📎 İlgili Kaynaklar

- [BigQuery Sandbox — Ücretsiz Başlangıç](https://cloud.google.com/bigquery/docs/sandbox)
- [LinkedIn Carousel Paylaşımı](#) ← LinkedIn post linkinizi ekleyin

---

*Bu proje AI destekli veri analizi workflow'unu keşfetmek amacıyla hazırlanmıştır.*
