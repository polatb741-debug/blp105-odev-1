-- Berk Polat — 202507131015
-- Bölüm 4: Hafta 5 / Yapay Zeka Operatörlüğü (llm_ops)
-- Sonuç yorumları örnek veritabanındaki data/llm_ops.sql kayıtlarına dayanır.
-- Kendi ortamında çalıştırıp gerçek çıktıyla karşılaştır.

-- Soru 1: Kaç çağrı kaydedilmiş?
SELECT COUNT(*) AS cagri_sayisi
FROM llm_calls;
-- 12. Tabloda toplam 12 çağrı kaydı bulunuyor.

-- Soru 2: Kaç çağrı 2 saniyeden yavaş?
SELECT COUNT(*) AS yavas_cagri_sayisi
FROM llm_calls
WHERE latency_ms > 2000;
-- 5. Beş çağrının gecikmesi 2000 milisaniyeyi aşıyor.

-- Soru 3: Toplam maliyet ve toplam token sayısı
SELECT SUM(cost_usd) AS toplam_maliyet_usd,
       SUM(prompt_tokens + completion_tokens) AS toplam_token
FROM llm_calls;
-- 0.0631 | 14340. SUM(cost_usd) NULL olan faturayı atlar; token toplamı 14340'tır.

-- Soru 4: Ortalama gecikme, bir ondalık basamak
SELECT ROUND(AVG(latency_ms), 1) AS ortalama_gecikme_ms
FROM llm_calls;
-- 1848.3. On iki çağrının ortalama gecikmesi yaklaşık 1.848,3 ms'dir.

-- Soru 5: En hızlı ve en yavaş çağrı
SELECT MIN(latency_ms) AS en_hizli_ms,
       MAX(latency_ms) AS en_yavas_ms
FROM llm_calls;
-- 380 | 4100. En hızlı çağrı 380 ms, en yavaş çağrı 4100 ms sürmüştür.

-- Soru 6: Her iş türünde kaç çağrı var?
SELECT task_type, COUNT(*) AS cagri_sayisi
FROM llm_calls
GROUP BY task_type
ORDER BY task_type;
-- 5 satır döner. Beş farklı iş türü vardır; her satır bir iş türünün sayısıdır.

-- Soru 7: Her model için çağrı sayısı ve toplam maliyet
SELECT model_name,
       COUNT(*) AS cagri_sayisi,
       SUM(cost_usd) AS toplam_maliyet_usd
FROM llm_calls
GROUP BY model_name
ORDER BY toplam_maliyet_usd DESC NULLS LAST;
-- 7 satır döner. En yüksek toplam bilinen maliyet claude-sonnet modelindedir;
-- NULL maliyetli kayıt SUM hesabına eklenmez.

-- Soru 8: Her kullanıcının her iş türünden kaç çağrısı var?
SELECT user_name, task_type, COUNT(*) AS cagri_sayisi
FROM llm_calls
GROUP BY user_name, task_type
ORDER BY user_name NULLS LAST, task_type;
-- 12 satır döner. Aynı kullanıcı ve iş türü birleşimi bir satır oluşturur;
-- anonim kaydın user_name alanı NULL olarak ayrı grupta görünür.

-- Soru 9: İkiden fazla çağrısı olan modeller
SELECT model_name, COUNT(*) AS cagri_sayisi
FROM llm_calls
GROUP BY model_name
HAVING COUNT(*) > 2;
-- 1 satır döner. Yalnız gpt-4o üç çağrı ile ikiden fazla çağrı koşulunu sağlar.

-- Soru 10: Yalnız 500 ms'den yavaş çağrıları say, en az 2 çağrısı olan
-- modelleri ortalama gecikmesiyle göster.
SELECT model_name,
       COUNT(*) AS cagri_sayisi,
       ROUND(AVG(latency_ms), 1) AS ortalama_gecikme_ms
FROM llm_calls
WHERE latency_ms > 500
GROUP BY model_name
HAVING COUNT(*) >= 2
ORDER BY model_name;
-- 3 satır döner: WHERE önce 500 ms veya daha hızlı çağrıları eler;
-- HAVING ise filtre sonrası iki çağrıdan az kalan model gruplarını eler.

-- Soru 11: Tek sorguda toplam ve sütunların dolu değer sayıları
SELECT COUNT(*) AS toplam_satir,
       COUNT(id) AS id_dolu,
       COUNT(model_name) AS model_dolu,
       COUNT(user_name) AS kullanici_dolu,
       COUNT(task_type) AS is_turu_dolu,
       COUNT(prompt_tokens) AS prompt_dolu,
       COUNT(completion_tokens) AS completion_dolu,
       COUNT(latency_ms) AS gecikme_dolu,
       COUNT(cost_usd) AS maliyet_dolu,
       COUNT(created_at) AS tarih_dolu
FROM llm_calls;
-- 12 satır kaydı var; user_name ve cost_usd sütunlarında 11'er dolu değer,
-- diğer listelenen sütunlarda 12'şer dolu değer vardır. İki NULL bulunur.

-- Soru 12: Faturası gelmemiş çağrılar
SELECT id, model_name, cost_usd
FROM llm_calls
WHERE cost_usd IS NULL;
-- 1 satır döner. 11 numaralı çağrının maliyeti henüz bilinmiyor.
-- cost_usd = NULL doğru bir NULL testi değildir; IS NULL kullanılmalıdır.

-- Soru 13: Maliyetin ortalaması: NULL değerleri atlayarak ve sıfır sayarak
SELECT ROUND(AVG(cost_usd), 6) AS null_atlaninca,
       ROUND(AVG(COALESCE(cost_usd, 0)), 6) AS null_sifir_sayilinca
FROM llm_calls;
-- Yaklaşık 0.005736 | 0.005258 USD. İkinci ortalama 12 kaydı da paydada sayar.
-- Eksik fatura gerçekten sıfır harcama demek olmadığından, bilinen maliyetlerin
-- ortalaması için AVG(cost_usd) daha dürüsttür; eksik değer ayrıca belirtilmelidir.

-- Soru 14: Günlük çağrı sayısı ve toplam maliyet
SELECT created_at::date AS gun,
       COUNT(*) AS cagri_sayisi,
       SUM(cost_usd) AS toplam_maliyet_usd
FROM llm_calls
GROUP BY created_at::date
ORDER BY gun;
-- 6 satır döner. En çok çağrı 2026-10-16 günündedir (5 çağrı);
-- maliyet daha düşük görünür çünkü o gün ucuz modeller kullanılmıştır ve
-- 11 numaralı çağrının faturası NULL olduğu için toplam maliyete katılmaz.

-- Soru 15: Gecikme kategorileri ve her kategorinin çağrı sayısı/ortalaması
SELECT CASE
         WHEN latency_ms < 1000 THEN 'Hızlı'
         WHEN latency_ms < 2500 THEN 'Orta'
         ELSE 'Yavaş'
       END AS gecikme_kategorisi,
       COUNT(*) AS cagri_sayisi,
       ROUND(AVG(latency_ms), 1) AS ortalama_gecikme_ms
FROM llm_calls
GROUP BY CASE
           WHEN latency_ms < 1000 THEN 'Hızlı'
           WHEN latency_ms < 2500 THEN 'Orta'
           ELSE 'Yavaş'
         END
ORDER BY gecikme_kategorisi;
-- 3 satır döner. Bu veride Hızlı: 4 (ortalama 607.5 ms), Orta: 4
-- (1775.0 ms), Yavaş: 4 (3162.5 ms) çağrı vardır.
