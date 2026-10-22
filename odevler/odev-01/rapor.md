# Ödev 1 Raporu

**Ad Soyad:** Berk Polat  
**Öğrenci No:** 202507131015  
**Program:** Yapay Zeka Operatörlüğü  
**Veritabanı:** llm_ops  
**PR bağlantısı:** PR açıldıktan sonra buraya eklenecek.

## 1. Ne yaptım
Bölüm 1'de döngüyle listeyi izledim, eşik üstündeki en uzun kesintisiz diziyi buldum ve sözlükle ders kayıtlarını saydım. Bölüm 2'de veritabanı, DBMS ve birincil anahtar kavramlarını kendi cümlelerimle açıkladım. Bölüm 3'te SELECT, WHERE, sıralama ve metin arama sorguları; Bölüm 4'te COUNT, SUM, AVG, GROUP BY, HAVING, CASE ve NULL kontrolleri hazırladım.

## 2. Beklemediğim sonuç ve özel sorular
- **Parantez tuzağı:** Bu veri setinde parantezli ve parantezsiz sorguların ikisi de 3 satır veriyor; çünkü iki code kaydının da maliyeti 0.01 doların üzerinde. Bu örnekte satır farkı yok, ancak SQL'de AND, OR işleminden önce değerlendirildiği için başka veride sonuç değişebilir.
- **Türkçe sıralama:** Soru 14'te varsayılan sıralama ile COLLATE "tr-TR-x-icu" sıralamasını karşılaştıracağım. Yer değiştiren isimleri sorguyu kendi PostgreSQL ortamımda çalıştırdıktan sonra buraya yazmalıyım; ortamın yerel ayarını doğrulamadan isim uydurmayacağım.
- **Kayıp kayıtlar:** cost_usd < 0.01 ve cost_usd >= 0.01 sonuçlarının toplamı 11 kayıt verir; tabloda 12 kayıt vardır. Kalan kayıt 11 numaralı çağrıdır; maliyeti NULL olduğu için iki karşılaştırmanın da sonucuna girmez.
- **İki ortalama:** Bilinen maliyetlerin ortalaması yaklaşık 0.005736 USD, NULL değerini sıfır sayan ortalama yaklaşık 0.005258 USD'dir. Aradaki fark yaklaşık 0.000478 USD'dir. Eksik fatura sıfır maliyet anlamına gelmediği için bilinen maliyetlerin ortalamasını kullanıp eksik kaydı ayrıca belirtmek daha dürüsttür.

## 3. Hata ve çözümü
**Teslimden önce doldurulacak:** Sorguları kendi PostgreSQL ortamımda çalıştırırken aldığım gerçek hata mesajını, nedenini ve nasıl düzelttiğimi buraya yazacağım. Gerçekte yaşamadığım bir hatayı yaşanmış gibi göstermeyeceğim.

## 4. Yapay zekâ kullanım beyanı
ChatGPT kullandım. Bölüm 1 için algoritmayı adım adım kontrol etmesini; Bölüm 2 için kavramları sadeleştirmesini; Bölüm 3 ve 4 için sorgu taslakları ve beklenen satır sayılarını hazırlamasını istedim. Çıktıları ders reposundaki data/llm_ops.sql kayıtları ve lab föyleriyle karşılaştırdım. **Sorguları kendi PostgreSQL ortamımda çalıştırıp gerçek satır sayılarını, yerel ayar gereksinimini ve rapordaki hata örneğini son kez doğrulamalıyım.**

## 5. Bana sorun
SQL'de AND ve OR önceliği ile NULL değerlerin karşılaştırmalarda neden sonuç dışı kaldığını bir örnek üzerinden tekrar görmek istiyorum.

**Not:** Bu rapor taslağıdır. Sorgular kendi ortamımda çalıştırılıp Türkçe sıralama ve gerçek hata mesajı doğrulandıktan sonra yazdırılmalıdır.
