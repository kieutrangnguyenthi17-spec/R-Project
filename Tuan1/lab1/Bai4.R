# Buổi 1 - Nhập môn R
# Họ tên: Nguyễn Thị Kiều Trang
# Mã sinh viên: 24133064

# 1. Tạo vector primes gồm 10 số nguyên tố đầu tiên
primes <- c(2, 3, 5, 7, 11, 13, 17, 19, 23, 29)
# 2. Tạo primes_plus_one, primes_half và primes_squared.
primes_plus_one <- primes + 1
primes_half <- primes / 2
primes_squared <- primes ^ 2
# 3. Tính length(primes), sum(primes), mean(primes), median(primes), sd(primes).
length(primes)
sum(primes)
mean(primes)
median(primes)
sd(primes)
# 4. giải thích “vector hóa” 
# Vector hóa : khi R tự động thực hiện phép tính trên từng phần tử của vector mà
# không cần dùng vòng lặp
# Ví dụ: primes + 1 sẽ cộng 1 vào từng số trong vector primes.
# 5. Tạo một vector score
score <- c(6, 7.5, 8, 5.5, 9, 6.5)
mean(score)