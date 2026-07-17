# Buổi 1 - Nhập môn R
# Họ tên: Nguyễn Thị Kiều Trang
# Mã sinh viên: 24133064
# character: chuoi ky tu
# logical: true/false
# class: kiem tra kieu du lieu

# 1. Tạo vector nation gồm 6 tên quốc gia:
nation <- c('ireland', 'england', 'scotland', 'wales', 'france', 'italy')
# 2. Dùng class(nation)
class(nation)
nation[1]
nation[-2]
nation[4:6]
# 3. Tạo vector has_r_experience
has_r_experience <- c(TRUE, FALSE, FALSE, TRUE, FALSE, TRUE)
class(has_r_experience)
# 4. Dùng !, &, | để tạo ít nhất 3 biểu thức logic
!has_r_experience
has_r_experience & c(TRUE, TRUE, FALSE, TRUE, FALSE, TRUE)
has_r_experience | c(FALSE, FALSE, TRUE, FALSE, TRUE, FALSE)
# 5. Thử nation + 2 và ghi lại vì sao R báo lỗi.
#nation + 2 # dòng này dự kiến báo lỗi nếu bỏ dấu #