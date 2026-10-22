-- Berk Polat — 202507131015
-- Bölüm 3: Hafta 4 / Yapay Zeka Operatörlüğü (llm_ops)
-- Not: Satır sayıları seed verisindeki kayıtlara göre hesaplanmıştır.
-- Sorguları kendi PostgreSQL ortamında çalıştırıp sonuçları karşılaştır.

-- Soru 1: Bütün çağrıların id'si ve model adı
SELECT id, model_name
FROM llm_calls;
-- 12 satır döndü.

-- Soru 2: Model adı ve toplam token sayısı
SELECT model_name AS model,
       prompt_tokens + completion_tokens AS total_tokens
FROM llm_calls;
-- 12 satır döndü.

-- Soru 3: Gecikmesi 2 saniyeyi aşan çağrılar (sütun milisaniye)
SELECT id, model_name, latency_ms
FROM llm_calls
WHERE latency_ms > 2000;
-- 5 satır döndü.

-- Soru 4: Ece'nin yaptığı çağrılar
SELECT id, model_name, user_name
FROM llm_calls
WHERE user_name = 'Ece';
-- 3 satır döndü.

-- Soru 5: Sohbet (chat) dışındaki çağrılar
SELECT id, model_name, task_type
FROM llm_calls
WHERE task_type <> 'chat';
-- 9 satır döndü.

-- Soru 6: Adı claude ile başlayan, 1 saniyeden yavaş çağrılar
SELECT id, model_name, latency_ms
FROM llm_calls
WHERE model_name LIKE 'claude%'
  AND latency_ms > 1000;
-- 2 satır döndü.

-- Soru 7: Kod veya çeviri işi olan, maliyeti 0.01 doları aşan çağrılar
SELECT id, task_type, cost_usd
FROM llm_calls
WHERE (task_type = 'code' OR task_type = 'translate')
  AND cost_usd > 0.01;
-- 3 satır döndü.
-- Bu veri setinde parantezli/parantezsiz sürüm de 3 satır verir:
-- iki code kaydının da maliyeti zaten 0.01 üzerindedir. Mantıksal öncelik
-- yine önemlidir; başka veride sonuçlar farklılaşabilir.

-- Soru 8: Gecikmesi 500 ile 1500 ms arasındaki çağrılar (uçlar dahil)
SELECT id, model_name, latency_ms
FROM llm_calls
WHERE latency_ms BETWEEN 500 AND 1500;
-- 3 satır döndü.

-- Soru 9: gpt ailesine yapılan çağrılar
SELECT id, model_name
FROM llm_calls
WHERE model_name IN ('gpt-4o', 'gpt-4o-mini');
-- 4 satır döndü.

-- Soru 10: Model adında mini geçen çağrılar
SELECT id, model_name
FROM llm_calls
WHERE model_name ILIKE '%mini%';
-- 1 satır döndü.

-- Soru 11: Önce kullanıcı, kullanıcı içinde maliyet pahalıdan ucuza
SELECT id, user_name, cost_usd
FROM llm_calls
ORDER BY user_name, cost_usd DESC;
-- 12 satır döndü.

-- Soru 12: En pahalı 3 çağrı (NULL maliyetler en üstte gösterilmez)
SELECT id, model_name, cost_usd
FROM llm_calls
WHERE cost_usd IS NOT NULL
ORDER BY cost_usd DESC
LIMIT 3;
-- 3 satır döndü.

-- Soru 13: Hangi iş türleri var?
SELECT DISTINCT task_type
FROM llm_calls
ORDER BY task_type;
-- 5 satır döndü.

-- Soru 14: Kullanıcı adlarını tekrarsız Türkçe sıralama
SELECT DISTINCT user_name
FROM llm_calls
WHERE user_name IS NOT NULL
ORDER BY user_name COLLATE "tr-TR-x-icu";
-- 5 satır döndü.
-- Not: PostgreSQL kurulumunda tr-TR-x-icu yerel ayarı yoksa önce
-- mevcut ICU yerel ayarlarını kontrol etmek gerekir.

-- Soru 15: 14 Ekim'den sonra yapılan, 1 saniyeden yavaş çağrılar
SELECT id, model_name, latency_ms
FROM llm_calls
WHERE created_at > TIMESTAMPTZ '2026-10-14 23:59:59+03'
  AND latency_ms > 1000
ORDER BY latency_ms DESC;
-- 5 satır döndü.
