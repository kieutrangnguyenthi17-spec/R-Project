# Câu 1 - Lists cơ bản
# a. Tạo một list có tên student_lst
student_lst <- list(
  id=2311001,
  name="Nguyen Van An",
  scores=list(
    Toan=8.2,
    Thong_ke=7.5,
    R=9.0,
    Kinh_te_luong=6.8
  ),
  passed=TRUE,
  profile=list(
    major="Data Analytics",
    year=2
  )
)
# b. Kiểm tra cấu trúc của list
student_lst
## Kiểm tra kiểu dữ liệu
class(student_lst)
## Kiểm tra số lượng phần tử
length(student_lst)
## Xem tên các phần tử
names(student_lst)


# c. Truy xuất thành phần trong list
# Truy xuất tên sinh viên bằng 3 cách: dùng $, dùng [[ ]] với tên thành phần, và dùng [[ ]] với chỉ số vị 
# trí.
student_lst$name
student_lst[["name"]]
student_lst[[2]]

# d. So sánh [ ] và [[ ]]
# Trích thành phần scores bằng student_lst["scores"] và student_lst[["scores"]]. Dùng class() để giải 
# thích sự khác biệt giữa hai kết quả
## Trích bằng []
scores_1 <-student_lst["scores"]
## Trích bằng [[]]
scores_2 <-student_lst[["scores"]]
## Kiểm tra kiểu dữ liệu
class(scores_1)
class(scores_2)
## In kết quả để quan sát
scores_1
scores_2

# e. Thêm và xóa thành phần trong list
# Tính điểm trung bình của sinh viên và thêm vào list với tên mean_score. Sau đó xóa thành phần 
# passed khỏi list.

## Tính điểm trung bình 
mean_score <- mean(unlist(student_lst$scores))
## Thêm vào list
student_lst$mean_score <- mean_score
## Kiểm tra list
student_lst
## Xóa thành phần passed 
student_lst$passed <- NULL
## Kiểm tra list
student_lst

# Câu 2 - Lists, lapply(), sapply() và recursive lists Cho dữ liệu điểm của 4 môn học như sau:
math <- c(8.2, 7.5, 9.1, 6.8, 7.9)
statistics <- c(7.0, 8.5, 8.8, 7.2, NA)
r_programming <- c(9.0, 9.5, 8.7, 8.0, 9.2)
econometrics <- c(6.5, 7.1, 7.8, 6.9, 8.0)
# a. Tạo list điểm
# Tạo list score_lst gồm 4 thành phần tương ứng với 4 môn học ở trên.
score_lst <- list(
  math=math,
  statistics=statistics,
  r_programming=r_programming,
  econometrics=econometrics
)
score_lst

# b. Áp dụng hàm cho từng thành phần của list
# Dùng lapply() để tính trung vị của từng môn. Sau đó dùng sapply() để tính trung bình của từng môn, bỏ qua giá trị thiếu nếu có
median_lst <- lapply(score_lst, median, na.rm=TRUE)
## Xem kết quả
median_lst
## Tính trung bình bằng sapply()
mean_vec <- sapply(score_lst, mean, na.rm=TRUE)
## Xem kết quả
mean_vec

# c. Tìm môn có điểm trung bình cao nhất
# Dựa trên kết quả ở câu b, viết code để trả về tên môn có điểm trung bình cao nhất
top_subject <- names(which.max(mean_vec))
top_subject

# d. Làm phẳng list
# Dùng unlist() để chuyển score_lst thành một vector. Tính điểm trung bình chung của toàn bộ các 
# điểm, bỏ qua NA.
score_vector <- unlist(score_lst)
score_vector
overal_mean <- mean(score_vector, na.rm=TRUE)
overal_mean

# e. Recursive list
# • Tạo một list mới tên course_report gồm: semester = "HK1"; scores = score_lst; summary = 
#   list(n_subjects = ..., best_subject = ..., overall_mean = ...).
# • Sau đó truy xuất riêng giá trị best_subject từ list lồng nhau này
# Tạo summary 
summary_lst <- list(
  n_subjects = length(score_lst),
  best_subject = names(which.max(sapply(score_lst, mean,
                                        na.rm = TRUE))), 
  overall_mean = mean(unlist(score_lst), na.rm = TRUE)
  ) 
# Tạo recursive list 
course_report <- list( semester = "HK1", scores = score_lst, summary = summary_lst ) 
# Xem kết quả 
course_report 
# Truy xuất best_subject 
course_report$summary$best_subject

# Câu 3 - Data Frames cơ bản
# Tạo data frame students_df từ các vector sau:

id <- c(101, 102, 103, 104, 105, 106, 107, 108)
name <- c("An", "Binh", "Chi", "Dung", "Ha", "Khanh", "Linh", "Minh")
gender <- c("M", "M", "F", "M", "F", "M", "F", "M")
class <- c("A", "B", "A", "C", "B", "A", "C", "B")
attendance <- c(90, 75, 88, 60, 95, 80, 70, 85)
midterm <- c(7.8, 6.0, 8.5, 5.5, 9.0, 7.2, 6.8, 8.0)
final <- c(8.5, 6.5, 9.0, 5.0, 9.4, 7.8, 7.0, 8.2)
# a. Tạo data frame
# Tạo students_df, trong đó gender và class là factor. Kiểm tra cấu trúc bằng str().

student_df <- data.frame(id,name,gender=factor(gender),class=factor(class),attendance,midterm,final)
student_df
str(student_df)

# b. Truy xuất cột và dòng

# 1. Trích cột name bằng $.

student_df$name

# 2. Trích cột final bằng [[ ]].

student_df[["final"]]

# 3. Trích dòng thứ 2 đến dòng thứ 5.

student_df[2:5, ]

# 4. Trích các cột name, class, final.

student_df[,c("name","class","final")]

# c. Tạo biến mới
# Thêm biến total_score, tính theo công thức: total_score = 0.4 × midterm + 0.6 × final. Sau đó thêm 
# biến result, nhận giá trị "Pass" nếu total_score >= 5.5, ngược lại là "Fail".

student_df$midterm <-
  as.numeric(as.character(student_df$midterm))
student_df$final <-
  as.numeric(as.character(student_df$final))
student_df$total_score <-0.4 * student_df$midterm + 0.6 * student_df$final
student_df$total_score
student_df$result <- ifelse(
  student_df$total_score >= 5.5,
  "Pass",
  "Fail"
)
student_df

# d. Lọc dữ liệu
# Trích ra các sinh viên:
# 1. Thuộc lớp A.

student_df[student_df$class=="A",]

# 2. Có attendance >= 80 và total_score >= 8.

student_df[(student_df$attendance>=80)&(student_df$total_score>=8),]

# 3. Là nữ và có kết quả Pass.

student_df[(student_df$gender=="F")&(student_df$result=="Pass"),]

# e. Sắp xếp dữ liệu
# Sắp xếp students_df theo total_score giảm dần. Sau đó tạo biến rank thể hiện thứ hạng của sinh viên 
# theo điểm tổng.

student_df <- student_df[order(student_df$total_score,
        decreasing = TRUE),
]
student_df
student_df$rank <- 1:nrow(student_df)
student_df

# Câu 4 - Data Frames: thêm dòng, thêm cột, merge

# a. Thêm cột city
# Cho vector city sau. Thêm vector này vào students_df dưới dạng một cột mới.

city <- c("HCM", "HN", "DN", "HCM", "CT", "HN", "DN", "HCM")
student_df$city <-city
student_df

# b. Thêm sinh viên mới
# Tạo một data frame new_students_df gồm 2 sinh viên mới như bảng dưới đây. Kết hợp 
# new_students_df vào students_df để tạo all_students_df. Sau đó tính lại total_score, result và rank 
# cho toàn bộ dữ liệu.
# id name gender class attendance midterm final total_score result rank city
# 109 Nam M C 92 8.1 8.6 NA NA NA HN
# 110 Oanh F A 78 7.4 7.9 NA NA NA HCM

new_students_df <- data.frame(
  id = c(109, 110),
  name = c("Nam", "Oanh"),
  gender = factor(c("M", "F")),
  class = factor(c("C", "A")),
  attendance = c(92, 78),
  midterm = c(8.1, 7.4),
  final = c(8.6, 7.9),
  total_score = NA,
  result = NA,
  rank = NA,
  city = c("HN", "HCM")
)
new_students_df
# Gộp vào student_df
all_students_df <- rbind(
  student_df,
  new_students_df
)
all_students_df
# Tính lại total_score
all_students_df$total_score <-
  0.4 * all_students_df$midterm +
  0.6 * all_students_df$final
# Tạo lại result
all_students_df$result <- ifelse(
  all_students_df$total_score >= 5.5,
  "Pass",
  "Fail"
)
# Sắp xếp giảm dần
all_students_df <- all_students_df[
  order(
    all_students_df$total_score,
    decreasing = TRUE
  ),
]
# Tạo lại rank
all_students_df$rank <-
  1:nrow(all_students_df)
all_students_df

# c. Merge data frames
# Tạo data frame class_info_df gồm thông tin dưới đây. Dùng merge() để kết hợp all_students_df với 
# class_info_df theo biến class.
# class lecturer room
# A Dr. Lan R101
# B Dr. Phuc R202
# C Dr. Minh R303

class_info_df <- data.frame(
  class = c("A", "B", "C"),
  lecturer = c(
    "Dr.Lan",
    "Dr.Phuc",
    "Dr.Minh"
  ),
  room = c(
    "R101",
    "R202",
    "R303"
  )
)
class_info_df
# Merge

merged_df <- merge(
  all_students_df,
  class_info_df,
  by = "class"
)
merged_df

# d. Dùng lapply() hoặc sapply() trên data frame
# Dùng sapply() để kiểm tra class của từng cột trong data frame sau khi merge. Sau đó dùng sapply() 
# để tính số lượng giá trị thiếu trong từng cột.

# Kiểm tra class của từng cột
sapply(
  merged_df,
  class
)
# Đếm số lượng giá trị thiếu trong từng cột
sapply(
  merged_df,
  function(x){
    sum(is.na(x))
  }
)

# Câu 5 - Factors cơ bản
# Cho vector mô tả mức độ hài lòng của sinh viên với môn học:

satisfaction <- c("High", "Medium", "Low", "High", "Medium", "High", "Low", "Medium", 
                  "High", "Low")
program <- c("Finance", "Marketing", "Finance", "Analytics", "Analytics",
             "Finance", "Marketing", "Analytics", "Finance", "Marketing")

# a. Tạo factor
# Tạo program_factor từ program. Tạo satisfaction_factor là ordered factor với thứ tự level: Low < 
#   Medium < High.

program_factor <- factor(program)
satisfaction_factor <- factor(satisfaction, levels=c("Low","Medium", "High"),ordered=TRUE)

# b. Kiểm tra factor
# Dùng class(), levels(), str() và unclass() để kiểm tra hai factor vừa tạo.

class(program_factor)
class(satisfaction_factor)

levels(program_factor)
levels(satisfaction_factor)

str(program_factor)
str(satisfaction_factor)

unclass(program_factor)
unclass(satisfaction_factor)

# c. Đếm tần suất
# Dùng table() để đếm số sinh viên theo program_factor và theo satisfaction_factor.

table(program_factor)
table(satisfaction_factor)

# d. So sánh ordered factor
# Viết code để xác định sinh viên nào có mức hài lòng từ Medium trở lên.

satisfaction[satisfaction_factor>="Medium"]

# e. Thay đổi level
# Đổi tên level Medium thành Med trong satisfaction_factor. Kiểm tra lại kết quả bằng levels().

levels(satisfaction_factor)[levels(satisfaction_factor) == "Medium"] <- "Med"

# Kiểm tra lại levels

levels(satisfaction_factor)

# Xem factor sau khi đổi tên

satisfaction_factor

# Câu 6 - Factors và phân tích nhóm
# Sử dụng all_students_df đã tạo ở Câu 4.
# a. Chuyển biến sang factor Đảm bảo rằng gender, class, result và city trong all_students_df là factor.

all_students_df$gender <- factor(all_students_df$gender)
all_students_df$class <- factor(all_students_df$class)
all_students_df$result <- factor(all_students_df$result)
all_students_df$city <- factor(all_students_df$city)
str(all_students_df)

# b. Bảng chéo : Tạo bảng chéo giữa class và gender. Sau đó dùng addmargins() để thêm tổng dòng và tổng cột.

cross_table <- table(all_students_df$class, all_students_df$gender)
cross_table
addmargins(cross_table)

# c. Dùng tapply() Tính điểm total_score trung bình theo class. Sau đó tính điểm total_score trung bình theo đồng thời class và gender.

# Điểm total_score trung bình theo class

tapply(all_students_df$total_score,
       all_students_df$class, mean)

# Điểm total_score trung bình theo class và gender

tapply(all_students_df$total_score,
       list(all_students_df$class,
            all_students_df$gender),mean)

# d. Dùng aggregate() Dùng aggregate() để tính trung bình của attendance, midterm, final và total_score theo class.

aggregate(cbind(attendance,
                midterm,
                final,
                total_score) ~ class,
          data = all_students_df,
          FUN = mean)

# e. Dùng split() Dùng split() để tách all_students_df theo class. Sau đó dùng lapply() để lấy sinh viên có total_score cao nhất trong từng lớp.

# Tách dữ liệu theo class

split_class <- split(all_students_df, all_students_df$class)

# Lấy sinh viên có total_score cao nhất trong từng lớp

top_students <- lapply(split_class, function(x) {
  x[which.max(x$total_score), ]
})
top_students

# f. Phân loại điểm bằng cut()
# Tạo biến grade_level dựa trên total_score theo quy tắc dưới đây. Sau đó dùng table() để đếm số sinh viên theo grade_level.
# Khoảng điểm total_score Nhãn grade_level

all_students_df$grade_level <- cut(
  all_students_df$total_score,
  breaks = c(0, 5.5, 7, 8.5, 10),
  labels = c("Fail", "Average", "Good", "Excellent"),
  right = FALSE,
  include.lowest = TRUE
)

# Đếm số sinh viên theo grade_level

table(all_students_df$grade_level)

# Xem kết quả

all_students_df[, c("total_score", "grade_level")]

# Câu 7 - Bài tập tổng hợp

# Tạo một list tên analysis_report gồm các thành phần sau:

# 1. data: data frame all_students_df sau khi đã thêm biến grade_level.

analysis_report <-list(
  data=all_students_df,
  class_summary=aggregate(
    cbind(attendance,
          midterm,
          final,
          total_score)~class,
    data=all_students_df,
    FUN=mean
  ),

# 2. class_summary: kết quả trung bình theo lớp ở Câu 6d.

class_gender_table = addmargins(
  table(all_students_df$class,
        all_students_df$gender)
),
# 3. class_gender_table: bảng chéo có tổng dòng và tổng cột ở Câu 6b.

class_gender_table = addmargins(
  table(all_students_df$class,
        all_students_df$gender)
),

# 4. top_students: kết quả sinh viên có điểm cao nhất trong từng lớp ở Câu 6e.

top_students = lapply(
  split(all_students_df, all_students_df$class),
  function(x) {
    x[which.max(x$total_score), ]
  }
)
)

# Sau đó thực hiện các yêu cầu:

# a. Kiểm tra cấu trúc list tổng hợp
# Dùng str() để xem cấu trúc của analysis_report.

str(analysis_report)

# b. Truy xuất kết quả từ list
# Truy xuất riêng bảng class_summary và danh sách top_students từ analysis_report.

# Bảng class_summary
analysis_report$class_summary

# Danh sách top_students
analysis_report$top_students

# c. Câu hỏi diễn giải ngắn
# Dựa trên kết quả phân tích, viết 3-5 dòng nhận xét về:
#   • Lớp nào có điểm trung bình cao nhất?

analysis_report$class_summary[
  which.max(analysis_report$class_summary$total_score),
]

#   • Nhóm giới tính nào có điểm trung bình cao hơn trong từng lớp?

tapply(
  all_students_df$total_score,
  list(all_students_df$class,
       all_students_df$gender),
  mean
)

#   • Có bao nhiêu sinh viên thuộc nhóm Excellent?

table(all_students_df$grade_level)
