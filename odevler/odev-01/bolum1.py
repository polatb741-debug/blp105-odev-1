# Berk Polat — 202507131015
# Bölüm 1: Algoritma ve izleme

# Soru 1.1 — İz sürme
numbers = [4, 7, 2, 9, 5, 1, 8]
total = 0
result = []

# İzleme tablosu (i, total, result):
# 0, 4, []
# 1, 4, [7]
# 2, 6, [7]
# 3, 6, [7, 9]
# 4, 6, [7, 9, 5]
# 5, 6, [7, 9, 5, 1]
# 6, 14, [7, 9, 5, 1]
for i in range(len(numbers)):
    if numbers[i] % 2 == 0:
        total = total + numbers[i]
    else:
        result.append(numbers[i])

print("Soru 1.1 toplam:", total)       # 14
print("Soru 1.1 tek sayılar:", result)  # [7, 9, 5, 1]
# Tahmin kontrolü: Çift sayılar (4, 2, 8) toplandığında 14 eder;
# tek sayılar sırayla result listesine eklenir.


# Soru 1.2 — Eşik üstündeki en uzun kesintisiz seri
readings = [18, 21, 23, 25, 24, 26, 27, 19, 20, 22, 23, 24, 25, 26]
threshold = 22

# Sözde kod:
# en_uzun = 0, mevcut = 0
# Her okumayı sırayla kontrol et:
#   okuma eşikten büyükse mevcut sayacını artır ve en_uzun ile karşılaştır
#   değilse mevcut sayacını sıfırla
# Sonuç en_uzun değeridir.

longest = 0
current = 0

for reading in readings:
    if reading > threshold:
        current = current + 1
        if current > longest:
            longest = current
    else:
        current = 0

print("Soru 1.2 en uzun seri:", longest)  # 5


# Soru 1.3 — Sözlük kullanarak elle gruplama
records = [
    {"student": "Ece", "course": "VTYS"},
    {"student": "Ali", "course": "Yapay Zeka"},
    {"student": "Ece", "course": "Yapay Zeka"},
    {"student": "Can", "course": "VTYS"},
    {"student": "Ali", "course": "VTYS"},
    {"student": "Ece", "course": "Robotik"},
]

course_counts = {}
for record in records:
    course = record["course"]
    if course in course_counts:
        course_counts[course] = course_counts[course] + 1
    else:
        course_counts[course] = 1

print("Soru 1.3 ders sayıları:", course_counts)
# Beklenen: {'VTYS': 3, 'Yapay Zeka': 2, 'Robotik': 1}
# Benzerlik: Sözlükte aynı dersin kayıtlarını saymak, SQL'de GROUP BY
# ile kayıtları aynı ders adına göre gruplamaya benzer.
