CREATE DATABASE HepsiburadaDB;
GO 

USE HepsiburadaDB;
GO

CREATE TABLE Musteri (
	MusteriID INT IDENTITY(1,1) PRIMARY KEY,
	AdSoyad NVARCHAR(100) NOT NULL,
	Email NVARCHAR(100) NOT NULL,
	TelefonNumara NVARCHAR(20),
	Sehir NVARCHAR(50) NOT NULL,
	Adres NVARCHAR(200) NOT NULL
);
GO

CREATE TABLE Kategori (
	KategoriID INT IDENTITY(1,1) PRIMARY KEY,
	KategoriAdi NVARCHAR(100) NOT NULL
);
GO

CREATE TABLE Satici (
	SaticiID INT IDENTITY(1,1) PRIMARY KEY,
	MagazaAdi NVARCHAR(100) NOT NULL,
	Adres NVARCHAR(100) NOT NULL,
	MagazaPuan DECIMAL(2,1)
);
GO

CREATE TABLE Urun (
	UrunID INT IDENTITY(1,1) PRIMARY KEY,
	UrunAdi NVARCHAR(100) NOT NULL,
	Fiyat DECIMAL(10,2) NOT NULL,
	Stok INT NOT NULL,
	KategoriID INT NOT NULL,
	SaticiID INT NOT NULL,

	FOREIGN KEY (KategoriID) REFERENCES Kategori(KategoriID),
	FOREIGN KEY (SaticiID) REFERENCES Satici(SaticiID)
);
GO

CREATE TABLE Sepet (
	SepetID INT IDENTITY(1,1) PRIMARY KEY,
	MusteriID INT NOT NULL,
	OlusturmaTarihi DATETIME NOT NULL DEFAULT GETDATE(),

	FOREIGN KEY (MusteriID) REFERENCES Musteri(MusteriID)
);
GO

CREATE TABLE SepetDetay (
	SepetDetayID INT IDENTITY(1,1) PRIMARY KEY,
	SepetID INT NOT NULL,
	UrunID INT NOT NULL,
	Adet INT NOT NULL,

	FOREIGN KEY (SepetID) REFERENCES Sepet(SepetID),
	FOREIGN KEY (UrunID) REFERENCES Urun(UrunID)
);
GO

CREATE TABLE Siparis (
	SiparisID INT IDENTITY(1,1) PRIMARY KEY,
	MusteriID INT NOT NULL,
	SiparisTarihi DATETIME NOT NULL DEFAULT GETDATE(),
	SiparisDurumu NVARCHAR(50) NOT NULL,

	FOREIGN KEY (MusteriID) REFERENCES Musteri(MusteriID)
);
GO

CREATE TABLE SiparisDetay (
	SiparisDetayID INT IDENTITY(1,1) PRIMARY KEY,
	SiparisID INT NOT NULL,
	UrunID INT NOT NULL,
	Adet INT NOT NULL,

	FOREIGN KEY (SiparisID) REFERENCES Siparis(SiparisID),
	FOREIGN KEY (UrunID) REFERENCES Urun(UrunID)
);
GO

CREATE TABLE Odeme (
	OdemeID INT IDENTITY(1,1) PRIMARY KEY,
	SiparisID INT NOT NULL,
	OdemeTarihi DATETIME NOT NULL DEFAULT GETDATE(),
	OdemeYontemi NVARCHAR(50) NOT NULL,
	OdemeDurumu NVARCHAR(50) NOT NULL,

	FOREIGN KEY (SiparisID) REFERENCES Siparis(SiparisID)
);
GO

CREATE TABLE Kargo (
	KargoID INT IDENTITY(1,1) PRIMARY KEY,
	SiparisID INT NOT NULL,
	KargoFirmasi NVARCHAR(100) NOT NULL,
	TakipNo NVARCHAR(50),
	KargoDurumu NVARCHAR(50) NOT NULL,

	FOREIGN KEY (SiparisID) REFERENCES Siparis(SiparisID)
);
GO

INSERT INTO Musteri (AdSoyad,Email,TelefonNumara,Sehir,Adres)
VALUES
('Enes Akan', 'info@akanenes.com', '05550004747', 'Mardin', 'Midyat'),
('Mahir Şarlı', 'mahirnazi19@gmail.com', '05232327654', 'İstanbul', 'Maltepe'),
('Efe Kemal Işık', 'lonelyman@gmail.com', '056723482397', 'Sivas','Kangal'),
('Muhammed Dağkapı', 'marmaraboreksarayi@gmail.com', '02162671287','İstanbul', 'Maltepe Zümrütevleri'),
('Efe Beray Biçer', 'bicerefeberay@gmail.com', '05232346423', 'Sinop', 'Ayancık'),
('Abdulsamet Demirel', 'sametdemirel13@hotmail.com', '05438902309','Karaman','Kulu');
GO

SELECT * FROM Kategori

DELETE FROM Musteri
WHERE MusteriID BETWEEN 7 AND 12;
GO

INSERT INTO Kategori(KategoriAdi)
VALUES 
	('Elektronik'),
	('Hediyelik Eşya'),
	('Giyim'),
	('Spor'),
	('Ev ve Yaşam'),
	('Kitap'),
	('Kırtasiye'),
	('Bilgisayar'),
	('Telefon ve Aksesuar'),
	('Beyaz Eşya'),
	('Kozmetik'),
	('Oyuncak'),
	('Otomotiv'),
	('Bahçe ve Yapı Market'),
	('Anne ve Bebek');

INSERT INTO Satici (MagazaAdi, Adres, MagazaPuan)
VALUES
	('TeknoPlus Market', 'İstanbul / Kadıköy', 4.8),
	('Hediye Sepeti Mağazası', 'İstanbul / Üsküdar', 4.6),
	('ModaLife Giyim', 'Bursa / Osmangazi', 4.5),
	('SporAktif Mağazası', 'Ankara / Çankaya', 4.7),
	('EvKonfor Mağazası', 'İzmir / Bornova', 4.4),
	('KitapDurağı', 'Eskişehir / Tepebaşı', 4.9),
	('OfisKırtasiye', 'Konya / Selçuklu', 4.3),
	('PC Dünyası', 'İstanbul / Şişli', 4.8),
	('MobilAksesuar Store', 'Antalya / Muratpaşa', 4.5),
	('GüzellikMarket', 'İstanbul / Maltepe', 4.6);
GO
INSERT INTO Urun (UrunAdi, Fiyat, Stok, KategoriID, SaticiID)
VALUES
('Bluetooth Kulaklık', 899.90, 45, 1, 1),
('Akıllı Saat', 2499.00, 25, 1, 1),

('Kişiye Özel Kupa', 179.90, 80, 2, 2),
('Dekoratif Kar Küresi', 249.90, 35, 2, 2),

('Erkek Kot Pantolon', 799.90, 50, 3, 3),
('Kadın Oversize Sweatshirt', 649.90, 40, 3, 3),

('Futbol Topu', 549.90, 60, 4, 4),
('Dambıl Seti 10 KG', 1199.00, 20, 4, 4),

('Kahve Makinesi', 3299.00, 18, 5, 5),
('Nevresim Takımı', 899.90, 30, 5, 5),

('Suç ve Ceza', 189.90, 100, 6, 6),
('Kürk Mantolu Madonna', 129.90, 120, 6, 6),

('Defter Seti', 149.90, 90, 7, 7),
('Tükenmez Kalem 10lu Paket', 89.90, 150, 7, 7),

('Oyuncu Laptopu', 45999.00, 8, 8, 8),
('Mekanik Klavye', 1899.00, 22, 8, 8),

('Samsung Galaxy S23 Kılıfı', 299.90, 70, 9, 9),
('Type-C Hızlı Şarj Kablosu', 199.90, 100, 9, 9),

('Parfüm 100 ML', 1599.00, 25, 11, 10),
('Cilt Bakım Kremi', 449.90, 40, 11, 10);
GO

SELECT * FROM Urun

INSERT INTO Sepet (MusteriID, OlusturmaTarihi)
VALUES
(1, '2026-01-12 14:25:00'),
(2, '2026-02-03 19:40:00'),
(3, '2026-03-18 11:10:00'),
(4, '2026-04-07 16:55:00'),
(5, '2026-05-10 22:30:00'),
(6, '2026-05-15 09:20:00');
GO

INSERT INTO SepetDetay (SepetID, UrunID, Adet)
VALUES
-- Enes Akan
(1, 1, 1),
(1, 3, 2),
(1, 11, 1),

-- Mahir Şarlı
(2, 5, 1),
(2, 16, 1),

-- Efe Kemal Işık
(3, 7, 1),
(3, 8, 1),
(3, 14, 3),

-- Muhammed Dağkapı
(4, 9, 1),
(4, 10, 2),

-- Efe Beray Biçer
(5, 15, 1),
(5, 17, 2),
(5, 18, 1),

-- Abdulsamet Demirel
(6, 4, 1),
(6, 19, 1);
GO

SELECT * FROM Sepet
SELECT * FROM SepetDetay

INSERT INTO Siparis (MusteriID, SiparisDurumu)
VALUES
(1, 'Onaylandı'),
(2, 'Kargoya Verildi'),
(3, 'Hazırlanıyor'),
(4, 'Onaylandı'),
(5, 'Teslim Edildi'),
(6, 'Onaylandı');
GO
SELECT * FROM Siparis

INSERT INTO SiparisDetay (SiparisID, UrunID, Adet)
VALUES
-- Enes Akan
(1, 1, 1),
(1, 3, 2),

-- Mahir Şarlı
(2, 5, 1),
(2, 16, 1),

-- Efe Kemal Işık
(3, 7, 1),
(3, 8, 1),

-- Muhammed Dağkapı
(4, 9, 1),
(4, 10, 2),

-- Efe Beray Biçer
(5, 15, 1),
(5, 17, 2),
(5, 18, 1),

-- Abdulsamet Demirel
(6, 4, 1),
(6, 19, 1);
GO

INSERT INTO Odeme (SiparisID, OdemeYontemi, OdemeDurumu)
VALUES
(1, 'Kredi Kartı', 'Başarılı'),
(2, 'Banka Kartı', 'Başarılı'),
(3, 'Havale/EFT', 'Beklemede'),
(4, 'Kredi Kartı', 'Başarılı'),
(5, 'Kredi Kartı', 'Başarılı'),
(6, 'Kapıda Ödeme', 'Beklemede');
GO

INSERT INTO Kargo (SiparisID, KargoFirmasi, TakipNo, KargoDurumu)
VALUES
(1, 'HepsiJet', 'HJ123456789', 'Hazırlanıyor'),
(2, 'Yurtiçi Kargo', 'YK987654321', 'Yolda'),
(3, 'Aras Kargo', 'AR456789123', 'Hazırlanıyor'),
(4, 'HepsiJet', 'HJ654987321', 'Hazırlanıyor'),
(5, 'MNG Kargo', 'MNG789456123', 'Teslim Edildi'),
(6, 'Sürat Kargo', 'SK147258369', 'Şubede');
GO

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