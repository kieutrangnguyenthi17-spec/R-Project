# Buổi 1 - Nhập môn R
# Họ tên: Nguyễn Thị Kiều Trang
# Mã sinh viên: 24133064

#1. Tạo các object: 
age <- 20
income <- 4500000
is_married <- FALSE
years_married <- 0
#2. Tạo height_m và weight_kg - tạo bmi
height_m <- 1.65
weight_kg <- 60
bmi <- weight_kg / height_m ^ 2
#3. Tạo object bmi_rounded bằng round(bmi, 2).
bmi_rounded <- round(bmi, 2)
bmi_rounded
#4. Quan sát Environment:
# age (numeric)
# bmi (numeric)
# bmi_rounded (numeric)
# height_m (numeric)
# income (numeric)
# is_married (logical())
# weight_kg (numeric)
# years_married (numeric)
#5. Thử đặt tên sai
# 8age <- 10 → lỗi vì tên biến không được bắt đầu bằng số
# student-age <- 20 → lỗi vì dấu "-" được hiểu là phép trừ (student - age)


