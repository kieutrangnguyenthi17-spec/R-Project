# Buổi 1 - Nhập môn R
# Họ tên: Nguyễn Thị Kiều Trang
# Mã sinh viên: 24133064

# 1. Tạo data frame students_df với các cột: 
students_df <- data.frame(
  name = c('An', 'Binh', 'Chi', 'Dung', 'Ha', 'Linh'),
  age = c(19, 20, 19, 21, 20, 22),
  major = c('Finance', 'Marketing', 'Finance', 'Accounting', 'Finance', 'MIS'),
  has_r_experience = c(TRUE, FALSE, FALSE, TRUE, FALSE, TRUE),
  pretest = c(6, 5, 7.5, 8, 6.5, 9)
)
# 2. In students_df ra Console; dùng View(students_df) nếu đang dùng RStudio.
students_df
View(students_df)
# 3. Kiểm tra số dòng, số cột và tên cột bằng nrow(), ncol(), names().
nrow(students_df)
ncol(students_df)
names(students_df)
# 4. Truy cập cột pretest bằng students_df$pretest và students_df[["pretest"]].
students_df$pretest
students_df[['pretest']]
# 5. Trích dòng thứ 3, trích cột age, và trích ô ở dòng 2 cột 5.
students_df[3, ]
students_df[, 'age']
students_df[2, 5]