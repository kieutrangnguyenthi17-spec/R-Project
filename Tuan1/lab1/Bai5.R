# Buổi 1 - Nhập môn R
# Họ tên: Nguyễn Thị Kiều Trang
# Mã sinh viên: 24133064

# 1. Từ vector primes, trích phần tử thứ 1, thứ 5 và nhóm phần tử thứ 2 đến thứ 5.
primes[1]
primes[5]
primes[2:5]
# 2. Trích các phần tử thứ 7, thứ 5, thứ 3 theo đúng thứ tự đó.
primes[c(7, 5, 3)]
# 3. Tạo vector primes_less_than_20 bằng điều kiện primes < 20
primes_less_than_20 <- primes[primes < 20]
# 4. Tạo vector primes_not_3 bằng cách loại bỏ giá trị 3 hoặc loại bỏ phần tử thứ 2.
primes_not_second <- primes[-2]
# 5. So sánh primes == 7, primes != 3, primes >= 11
# giải thích kết quả TRUE/FALSE.
primes == 7
primes != 3
primes >= 11
# Giải thích:
# Các phép so sánh trả về TRUE hoặc FALSE cho từng phần tử.
# TRUE nghĩa là phần tử thỏa điều kiện → được giữ lại khi lọc.
# FALSE nghĩa là không thỏa → bị loại bỏ.
