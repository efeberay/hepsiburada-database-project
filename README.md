# Hepsiburada Database Project

## Türkçe

### Proje Açıklaması

Bu proje, Hepsiburada benzeri bir e-ticaret sistemi için hazırlanmış SQL Server veritabanı tasarımıdır.

Projede müşteri, satıcı, ürün, kategori, sepet, sipariş, ödeme ve kargo bilgileri ayrı tablolar halinde oluşturulmuştur. Tablolar arasında primary key ve foreign key ilişkileri kullanılarak ilişkisel bir veritabanı yapısı kurulmuştur.

Bu proje, veritabanı dersi kapsamında hazırlanmıştır.

---

### Kullanılan Teknolojiler

- Microsoft SQL Server
- SQL Server Management Studio
- T-SQL

---

### Veritabanı Adı

```sql
HepsiburadaDB
```

---

### Tablolar

| Tablo Adı | Açıklama |
|---|---|
| Musteri | Müşteri bilgilerini tutar |
| Kategori | Ürün kategorilerini tutar |
| Satici | Satıcı / mağaza bilgilerini tutar |
| Urun | Ürün bilgilerini tutar |
| Sepet | Müşterilerin sepet bilgilerini tutar |
| SepetDetay | Sepette bulunan ürünleri tutar |
| Siparis | Sipariş bilgilerini tutar |
| SiparisDetay | Sipariş edilen ürünleri tutar |
| Odeme | Ödeme bilgilerini tutar |
| Kargo | Kargo bilgilerini tutar |

---

### Veritabanı İlişkileri

Bu veritabanında aşağıdaki ilişkiler kurulmuştur:

- Bir müşteri bir veya birden fazla sepet oluşturabilir.
- Bir sepet içerisinde birden fazla ürün bulunabilir.
- Bir müşteri bir veya birden fazla sipariş verebilir.
- Bir sipariş içerisinde birden fazla ürün bulunabilir.
- Her ürün bir kategoriye bağlıdır.
- Her ürün bir satıcıya bağlıdır.
- Her siparişin ödeme bilgisi bulunur.
- Her siparişin kargo bilgisi bulunur.

---

### Temel İlişki Yapısı

```text
Musteri → Sepet → SepetDetay → Urun
Musteri → Siparis → SiparisDetay → Urun
Kategori → Urun
Satici → Urun
Siparis → Odeme
Siparis → Kargo
```

---

### Projede Kullanılan SQL Konuları

- Database oluşturma
- Table oluşturma
- Primary Key
- Foreign Key
- Identity
- Insert işlemleri
- DateTime kullanımı
- Decimal veri tipi
- JOIN sorguları
- GROUP BY
- SUM fonksiyonu

---

### Örnek JOIN Sorguları

#### Ürünleri kategori ve satıcı bilgileriyle listeleme

```sql
SELECT
    Urun.UrunID,
    Urun.UrunAdi,
    Urun.Fiyat,
    Urun.Stok,
    Kategori.KategoriAdi,
    Satici.MagazaAdi,
    Satici.Adres AS MagazaAdres,
    Satici.MagazaPuan
FROM Urun
JOIN Kategori ON Urun.KategoriID = Kategori.KategoriID
JOIN Satici ON Urun.SaticiID = Satici.SaticiID;
```

#### Müşterilerin sepetindeki ürünleri listeleme

```sql
SELECT
    Musteri.AdSoyad,
    Sepet.SepetID,
    Urun.UrunAdi,
    Urun.Fiyat,
    SepetDetay.Adet,
    Urun.Fiyat * SepetDetay.Adet AS SepetTutari
FROM SepetDetay
JOIN Sepet ON SepetDetay.SepetID = Sepet.SepetID
JOIN Musteri ON Sepet.MusteriID = Musteri.MusteriID
JOIN Urun ON SepetDetay.UrunID = Urun.UrunID;
```

#### Sipariş detaylarını listeleme

```sql
SELECT
    Musteri.AdSoyad,
    Siparis.SiparisID,
    Siparis.SiparisTarihi,
    Siparis.SiparisDurumu,
    Urun.UrunAdi,
    Urun.Fiyat,
    SiparisDetay.Adet,
    Urun.Fiyat * SiparisDetay.Adet AS HesaplananTutar
FROM SiparisDetay
JOIN Siparis ON SiparisDetay.SiparisID = Siparis.SiparisID
JOIN Musteri ON Siparis.MusteriID = Musteri.MusteriID
JOIN Urun ON SiparisDetay.UrunID = Urun.UrunID;
```

#### Sipariş toplam tutarını hesaplama

```sql
SELECT
    Siparis.SiparisID,
    Musteri.AdSoyad,
    SUM(Urun.Fiyat * SiparisDetay.Adet) AS ToplamTutar
FROM SiparisDetay
JOIN Siparis ON SiparisDetay.SiparisID = Siparis.SiparisID
JOIN Musteri ON Siparis.MusteriID = Musteri.MusteriID
JOIN Urun ON SiparisDetay.UrunID = Urun.UrunID
GROUP BY Siparis.SiparisID, Musteri.AdSoyad;
```

#### Sipariş, ödeme ve kargo bilgilerini listeleme

```sql
SELECT
    Musteri.AdSoyad,
    Siparis.SiparisID,
    Siparis.SiparisTarihi,
    Siparis.SiparisDurumu,
    Odeme.OdemeYontemi,
    Odeme.OdemeDurumu,
    Kargo.KargoFirmasi,
    Kargo.TakipNo,
    Kargo.KargoDurumu
FROM Siparis
JOIN Musteri ON Siparis.MusteriID = Musteri.MusteriID
JOIN Odeme ON Siparis.SiparisID = Odeme.SiparisID
JOIN Kargo ON Siparis.SiparisID = Kargo.SiparisID;
```

---

### Dosya Yapısı

```text
hepsiburada-database-project/
│
├── README.md
├── hepsiburada_db.sql
├── hepsiburada_db.bak
├── diagram.png
└── screenshots/
    ├── database-diagram.png
    ├── tables.png
    ├── product-seller-join.png
    └── order-payment-shipping-join.png
```

---

### Kurulum

1. SQL Server Management Studio uygulamasını açın.
2. `hepsiburada_db.sql` dosyasını açın.
3. SQL kodlarını çalıştırın.
4. `HepsiburadaDB` adlı veritabanı oluşacaktır.
5. Tablolar, örnek veriler ve ilişkiler otomatik olarak eklenecektir.

Alternatif olarak `.bak` dosyası kullanılarak veritabanı geri yüklenebilir.

---

### Proje Amacı

Bu projenin amacı, e-ticaret sistemlerinde kullanılan temel veritabanı yapısını öğrenmek ve tablolar arası ilişkileri uygulamalı olarak göstermektir.

Projede müşteri, ürün, kategori, satıcı, sepet, sipariş, ödeme ve kargo gibi temel e-ticaret yapıları veritabanı üzerinde modellenmiştir.

---

## English

### Project Description

This project is a SQL Server database design for an e-commerce system similar to Hepsiburada.

The project includes separate tables for customers, sellers, products, categories, carts, orders, payments and shipping information. A relational database structure was created using primary key and foreign key relationships between tables.

This project was prepared as part of a database course.

---

### Technologies Used

- Microsoft SQL Server
- SQL Server Management Studio
- T-SQL

---

### Database Name

```sql
HepsiburadaDB
```

---

### Tables

| Table Name | Description |
|---|---|
| Musteri | Stores customer information |
| Kategori | Stores product categories |
| Satici | Stores seller / store information |
| Urun | Stores product information |
| Sepet | Stores shopping cart information |
| SepetDetay | Stores products inside carts |
| Siparis | Stores order information |
| SiparisDetay | Stores products inside orders |
| Odeme | Stores payment information |
| Kargo | Stores shipping information |

---

### Database Relationships

The database includes the following relationships:

- A customer can have one or more shopping carts.
- A shopping cart can contain multiple products.
- A customer can place one or more orders.
- An order can contain multiple products.
- Each product belongs to a category.
- Each product belongs to a seller.
- Each order has payment information.
- Each order has shipping information.

---

### Main Relationship Structure

```text
Musteri → Sepet → SepetDetay → Urun
Musteri → Siparis → SiparisDetay → Urun
Kategori → Urun
Satici → Urun
Siparis → Odeme
Siparis → Kargo
```

---

### SQL Concepts Used

- Database creation
- Table creation
- Primary Key
- Foreign Key
- Identity
- Insert operations
- DateTime usage
- Decimal data type
- JOIN queries
- GROUP BY
- SUM function

---

### Example JOIN Queries

#### Listing products with category and seller information

```sql
SELECT
    Urun.UrunID,
    Urun.UrunAdi,
    Urun.Fiyat,
    Urun.Stok,
    Kategori.KategoriAdi,
    Satici.MagazaAdi,
    Satici.Adres AS MagazaAdres,
    Satici.MagazaPuan
FROM Urun
JOIN Kategori ON Urun.KategoriID = Kategori.KategoriID
JOIN Satici ON Urun.SaticiID = Satici.SaticiID;
```

#### Listing products in customer carts

```sql
SELECT
    Musteri.AdSoyad,
    Sepet.SepetID,
    Urun.UrunAdi,
    Urun.Fiyat,
    SepetDetay.Adet,
    Urun.Fiyat * SepetDetay.Adet AS SepetTutari
FROM SepetDetay
JOIN Sepet ON SepetDetay.SepetID = Sepet.SepetID
JOIN Musteri ON Sepet.MusteriID = Musteri.MusteriID
JOIN Urun ON SepetDetay.UrunID = Urun.UrunID;
```

#### Listing order details

```sql
SELECT
    Musteri.AdSoyad,
    Siparis.SiparisID,
    Siparis.SiparisTarihi,
    Siparis.SiparisDurumu,
    Urun.UrunAdi,
    Urun.Fiyat,
    SiparisDetay.Adet,
    Urun.Fiyat * SiparisDetay.Adet AS HesaplananTutar
FROM SiparisDetay
JOIN Siparis ON SiparisDetay.SiparisID = Siparis.SiparisID
JOIN Musteri ON Siparis.MusteriID = Musteri.MusteriID
JOIN Urun ON SiparisDetay.UrunID = Urun.UrunID;
```

#### Calculating total order amount

```sql
SELECT
    Siparis.SiparisID,
    Musteri.AdSoyad,
    SUM(Urun.Fiyat * SiparisDetay.Adet) AS ToplamTutar
FROM SiparisDetay
JOIN Siparis ON SiparisDetay.SiparisID = Siparis.SiparisID
JOIN Musteri ON Siparis.MusteriID = Musteri.MusteriID
JOIN Urun ON SiparisDetay.UrunID = Urun.UrunID
GROUP BY Siparis.SiparisID, Musteri.AdSoyad;
```

#### Listing order, payment and shipping information

```sql
SELECT
    Musteri.AdSoyad,
    Siparis.SiparisID,
    Siparis.SiparisTarihi,
    Siparis.SiparisDurumu,
    Odeme.OdemeYontemi,
    Odeme.OdemeDurumu,
    Kargo.KargoFirmasi,
    Kargo.TakipNo,
    Kargo.KargoDurumu
FROM Siparis
JOIN Musteri ON Siparis.MusteriID = Musteri.MusteriID
JOIN Odeme ON Siparis.SiparisID = Odeme.SiparisID
JOIN Kargo ON Siparis.SiparisID = Kargo.SiparisID;
```

---

### File Structure

```text
hepsiburada-database-project/
│
├── README.md
├── hepsiburada_db.sql
├── hepsiburada_db.bak
├── diagram.png
└── screenshots/
    ├── database-diagram.png
    ├── tables.png
    ├── product-seller-join.png
    └── order-payment-shipping-join.png
```

---

### Installation

1. Open SQL Server Management Studio.
2. Open the `hepsiburada_db.sql` file.
3. Run the SQL script.
4. The `HepsiburadaDB` database will be created.
5. Tables, sample data and relationships will be added automatically.

Alternatively, the database can be restored using the `.bak` file.

---

### Project Purpose

The purpose of this project is to understand the basic database structure used in e-commerce systems and to demonstrate table relationships practically.

The project models basic e-commerce structures such as customers, products, categories, sellers, carts, orders, payments and shipping in a relational database.

---

### Author

Prepared by **Efe Beray Biçer**.
