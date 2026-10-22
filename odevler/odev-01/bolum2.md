# Bölüm 2 — Veritabanı kavramları
**Berk Polat — 202507131015**

## 1. Excel dosyalarında veri tutmanın sorunları
Aynı bilgi birden fazla Excel dosyasında tutulursa bir dosya güncellenip diğeri eski kalabilir; veritabanında bilgi tek yerde tutulup tutarlılık korunabilir. Birden çok kişi aynı anda dosyayı düzenlediğinde değişiklikler çakışabilir; veritabanı işlemleri ve eşzamanlılık kontrolleri bunu yönetir. Dosyalar büyüdükçe doğru kaydı bulmak ve kimlerin neyi değiştirdiğini denetlemek zorlaşır; SQL sorguları, yetkilendirme ve kısıtlar bu işleri daha kontrollü yapar.

## 2. Birincil anahtar
Birincil anahtar, tablodaki her kaydı diğerlerinden benzersiz biçimde ayırt eder ve aynı anahtarın iki kayıtta kullanılmasını engeller. Öğrenci numarası her öğrenci için tekil ve değişmez verildiği sürece iyi bir birincil anahtardır. Ad soyad uygun değildir; iki kişinin adı aynı olabilir ve bir kişi adını değiştirebilir.

## 3. DBMS ile veritabanı arasındaki fark
Veritabanı, düzenlenmiş verilerin kendisidir; DBMS ise bu verileri oluşturmak, sorgulamak, güncellemek ve korumak için kullanılan yazılımdır. PostgreSQL bir DBMS'dir.

## 4. Aynı kaydı iki kişinin değiştirmesi
DBMS eşzamanlı işlemleri ve kilitleme/işlem kurallarıyla çakışmaları yönetir; kullanılan işlem biçimine göre bir değişiklik bekletilebilir veya çakışma bildirilebilir.
