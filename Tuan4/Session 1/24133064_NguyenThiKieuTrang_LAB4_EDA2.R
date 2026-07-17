# title: "24133064_NguyenThiKieuTrang_LAB4_EDA2"
# date: "2026-05-18"


# Khởi tạo thư viện
library(ggplot2)
library(tidyverse)

# I. Dữ liệu: diamonds

# --- Khởi động dữ liệu ---
View(diamonds)
head(diamonds)

# --- 1. Phân tích dữ liệu ---

## 1. Mô tả cấu trúc dữ liệu
### Số dòng
nrow(diamonds)

### Số cột
ncol(diamonds)

### Kiểu dữ liệu
str(diamonds)

## 2. Phân loại biến thành
categorical_vars <- c("cut", "color", "clarity")
continuous_vars <- c("carat", "price", "x", "y", "z", "depth", "table")

categorical_vars
continuous_vars

## 3. Tính thống kê mô tả
summary(diamonds[, c("price", "carat", "x", "y", "z")])

## 4. Tạo bảng tần suất 
table(diamonds$cut)
table(diamonds$color)
table(diamonds$clarity)

## 5. Đặt ít nhất 6 câu hỏi EDA
### Giá kim cương như thế nào?(variation)
head(diamonds$price, 100)

### Trọng lượng carat tập trung ở khoảng nào?(variation)
head(diamonds$carat, 100)

### Loại cut nào phổ biến?(variation)
head(diamonds$cut)

### Kim cương nặng có giá cao hơn không ?(Covarition)
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point(alpha = 0.1)

### Chất lượng cut có ảnh hưởng đến giá không?(Covarition)
ggplot(diamonds, aes(x = cut, y = price)) +
  geom_boxplot()

### Nhóm cut thường đi với color nào?(Covarition)
ggplot(diamonds, aes(x = cut, y = color)) +
  geom_count()


# --- 2. Trực quan hóa dữ liệu: Thực hiện các biểu đồ ---

## 1. Bar chart cho cut, color, clarity
ggplot(diamonds, aes(x = cut)) +
  geom_bar()

ggplot(diamonds, aes(x = color)) +
  geom_bar()

ggplot(diamonds, aes(x = clarity)) +
  geom_bar()

## 2. Histogram cho carat và price. 
ggplot(diamonds, aes(x = carat)) +
  geom_histogram(fill = "skyblue", color = "black", binwidth = 0.1)

ggplot(diamonds, aes(x = price)) +
  geom_histogram(fill = "green", color = "black", binwidth = 500)

## 3. Boxplot price theo cut. 
ggplot(diamonds, aes(x = cut, y = price)) +
  geom_boxplot()

## 4. Boxplot price theo clarity.
ggplot(diamonds, aes(x = clarity, y = price)) +
  geom_boxplot()

## 5. Scatterplot giữa carat và price. 
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point()

## 6. Scatterplot có alpha hoặc geom_bin2d() để xử lý chồng điểm.
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point(color = "blue", alpha = 0.1)

ggplot(diamonds, aes(x = carat, y = price)) +
  geom_bin2d()

## 7. Heatmap hoặc geom_count() cho quan hệ giữa cut và color
ggplot(diamonds, aes(x = cut, y = color)) +
  geom_count()


# --- 3. Làm sạch dữ liệu ---

## 1. Kiểm tra outlier ở các biến x, y, z. 
summary(diamonds[, c("x", "y", "z")])

ggplot(diamonds, aes(y = x)) +
  geom_boxplot() +
  labs(title = "Boxplot biến x")

ggplot(diamonds, aes(y = y)) +
  geom_boxplot() +
  labs(title = "Boxplot biến y")

ggplot(diamonds, aes(y = z)) +
  geom_boxplot() +
  labs(title = "Boxplot biến z")

## 2. Lọc các quan sát có kích thước bất thường
outlier_size <- diamonds %>%
  filter(x == 0 | y == 0 | z == 0 | y < 3 | y > 20)
nrow(outlier_size)

## 3. Tạo hai phiên bản dữ liệu: 
### Phiên bản loại bỏ outlier; 
diamonds_remove <- diamonds %>%
  filter(!(x == 0 | y == 0 | z == 0 | y < 3 | y > 20))
nrow(diamonds)
nrow(diamonds_remove)

### Phiên bản chuyển outlier thành NA. 
diamonds_na <- diamonds %>%
  mutate(
    x = ifelse(x == 0, NA, x),
    y = ifelse(y == 0 | y < 3 | y > 20, NA, y),
    z = ifelse(z == 0, NA, z)
  )
colSums(is.na(diamonds_na))

## 4. So sánh biểu đồ và thống kê mô tả trước/sau làm sạch.
summary(diamonds[, c("x", "y", "z")])
summary(diamonds_remove[, c("x", "y", "z")])
summary(diamonds_na[, c("x", "y", "z")])

## 5. Giải thích lựa chọn xử lý cuối cùng. 
# (Phần này là nhận xét định tính, được ẩn dưới dạng comment trong file .R)


# --- 4. Câu hỏi ---

## 1. Biến carat có quan hệ như thế nào với price?
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point() +
  geom_smooth() +
  labs(title = "Mối quan hệ giữa carat và price", x = "Carat", y = "Price")

## 2. Kim cương có cut tốt hơn có luôn đắt hơn không?
ggplot(diamonds, aes(x = cut, y = price)) +
  geom_boxplot() +
  labs(title = "Giá kim cương theo chất lượng Cut", x = "Cut", y = "Price")

## 3. Có outlier nào trong kích thước kim cương không? 
outlier_size

## 4. Outlier ảnh hưởng thế nào đến phân tích? 
# (Phần nhận xét ẩn dạng comment)

## 5. Nếu tư vấn cho cửa hàng, nên chú ý biến nào nhất khi định giá kim cương? 
cor(diamonds_remove$carat, diamonds_remove$price)



# II. Dữ liệu mpg


# --- 1. Phân tích dữ liệu ---
data("mpg")
View(mpg)
head(mpg)

## 1. Mô tả cấu trúc dữ liệu mpg. 
### Số dòng
nrow(mpg)

### Số cột
ncol(mpg)

### Kiểu dữ liệu
str(mpg)

## 2. Phân loại biến: 
### biến phân loại: manufacturer, model, class, drv, fl, trans;
categortical_vars <- c("manufacturer", "model", "class", "drv", "fl", "trans")
categortical_vars

### biến định lượng: displ, year, cyl, cty, hwy.
continous_vars <- c("displ", "year", "cyl", "cty", "hwy")
continous_vars

## 3. Tính thống kê mô tả cho cty, hwy, displ. 
summary(mpg[, c("cty", "hwy", "displ")])

## 4. Tạo bảng tóm tắt hwy theo class. 
mpg %>%
  group_by(class) %>%
  summarise(
    mean_hwy = mean(hwy),
    min_hwy = min(hwy),
    max_hwy = max(hwy)
  )

## 5. Tạo bảng tóm tắt hwy theo drv. 
mpg %>%
  group_by(drv) %>%
  summarise(
    mean_hwy = mean(hwy),
    min_hwy = min(hwy),
    max_hwy = max(hwy)
  )

## 6. Đặt ít nhất 5 câu hỏi EDA.
### 1.Loại xe nào có hwy cao nhất?
ggplot(mpg, aes(x = class, y = hwy)) +
  geom_boxplot() +
  labs(title = "Loại xe có hwy cao nhất", x = "Class", y = "hwy")

### 2.Xe có dung tích động cơ lớn có tiêu hao nhiên liệu nhiều hơn không?
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth() +
  labs(title = "Mối quan hệ giữa dung tích động cơ và tiêu hao năng lượng", x = "Displ", y = "hwy")

### 3.Dẫn động nào tiết kiệm nhiên liệu nhất?
ggplot(mpg, aes(x = drv, y = hwy)) +
  geom_boxplot() +
  labs(title = "Dẫn động tiết kiệm nhiên liệu nhất", x = "drv", y = "hwy")

### 4.Loại xe nào phổ biến nhất?
ggplot(mpg, aes(x = class)) +
  geom_bar() +
  labs(title = "Loại xe phổ biến nhất")

### 5.Có mối quan hệ giữa displ và hwy không?
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth() +
  labs(title = "Mối quan hệ giữa dung tích động cơ và tiêu hao năng lượng", x = "Displ", y = "hwy")
cor(mpg$displ, mpg$hwy)


# --- 2. Trực quan hóa dữ liệu ---

## 1. Bar chart số lượng xe theo class. 
ggplot(mpg, aes(x = class)) +
  geom_bar() +
  labs(title = "Biểu đồ số lượng xe theo Class")

## 2. Boxplot hwy theo class.
ggplot(mpg, aes(x = class, y = hwy)) +
  geom_boxplot() +
  labs(title = "Biểu đồ hwy theo class")

## 3. Boxplot cty theo class. 
ggplot(mpg, aes(x = class, y = cty)) +
  geom_boxplot() +
  labs(title = "Biểu đồ cty theo class")

## 4. Boxplot hwy theo drv.
ggplot(mpg, aes(x = drv, y = hwy)) +
  geom_boxplot() +
  labs(title = "Biểu đồ hwy theo drv")

## 5. Scatterplot giữa displ và hwy. 
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  labs(title = "Biểu đồ phân tán của displ và hwy", x = "displ", y = "hwy")

## 6. Scatterplot giữa displ và cty. 
ggplot(mpg, aes(x = displ, y = cty)) +
  geom_point() +
  labs(title = "Biểu đồ phân tán của displ và cty", x = "displ", y = "cty")

## 7. Scatterplot displ – hwy, tô màu theo class. 
ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point() +
  labs(title = "Biểu đồ phân tán của displ và hwy", x = "displ", y = "hwy")

## 8. Facet theo drv hoặc class. 
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_wrap(~drv) +
  labs(title = "Biểu đồ facet theo hệ thống dẫn động(drv)", x = "displ", y = "hwy")


# --- 3. Làm sạch dữ liệu ---

## 1. Kiểm tra missing values trong toàn bộ dữ liệu.
colSums(is.na(mpg))

## 2. Kiểm tra các nhóm class có số lượng quan sát quá nhỏ.
table(mpg$class)

## 3. Kiểm tra giá trị bất thường: hwy > 40; hwy < 15; cty > hwy; displ quá lớn hoặc quá nhỏ. 
outlier <- mpg %>%
  filter(hwy > 40 | hwy < 15 | cty > hwy | displ > 7 | displ < 1)
outlier

## 4. Đề xuất cách xử lý các quan sát bất thường.
# (Nhận xét ẩn dạng comment)

## 5. Giải thích có nên loại bỏ outlier hay giữ lại.
# (Nhận xét ẩn dạng comment)


# --- 4. Câu hỏi ---

## 1. Loại xe nào tiết kiệm nhiên liệu đường cao tốc nhất? 
mpg %>%
  group_by(class) %>%
  summarise(mean_hwy = mean(hwy)) %>%
  arrange(desc(mean_hwy))

## 2. Dung tích động cơ lớn có làm giảm hwy không? 
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  labs(title = "Biểu đồ phân tán của displ và hwy", x = "displ", y = "hwy")

## 3. Xe dẫn động nào có hiệu quả nhiên liệu tốt hơn? 
ggplot(mpg, aes(x = drv, y = hwy)) +
  geom_boxplot() +
  labs(title = "Biểu đồ hwy theo drv")

## 4. Có nhóm xe nào đi ngược xu hướng chung không? 
ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point() +
  labs(title = "Biểu đồ phân tán của displ và hwy", x = "displ", y = "hwy")

## 5. Nếu người tiêu dùng ưu tiên tiết kiệm nhiên liệu, nên chọn nhóm xe nào?
# (Nhận xét ẩn dạng comment)



# III. Dữ liệu: starwars


# --- 1. Phân tích dữ liệu ---
data("starwars")

## 1. Mô tả cấu trúc dữ liệu starwars. 
### Số dòng
nrow(starwars)

### Số cột
ncol(starwars)

### Kiểu dữ liệu
str(starwars)

## 2. Xác định biến định lượng: height; mass; birth_year. 
quantitative_vars <- c("height", "mass", "birth_year")
quantitative_vars

## 3. Xác định biến phân loại
categorical3_vars <- c("sex", "gender", "species", "homeworld", "hair_color", "eye_color", "skin_color")
categorical3_vars

## 4. Kiểm tra missing values trong từng biến. 
colSums(is.na(starwars))

starwars %>%
  summarise(
    missing_height = sum(is.na(height)),
    missing_mass = sum(is.na(mass)),
    missing_birth_year = sum(is.na(birth_year)),
    missing_gender = sum(is.na(gender)),
    missing_species = sum(is.na(species))
  )

## 5. Tạo bảng tần suất cho gender, species, hair_color. 
table(starwars$gender)
table(starwars$species)
table(starwars$hair_color)

starwars %>% count(gender, sort = TRUE)
starwars %>% count(species, sort = TRUE)
starwars %>% count(hair_color, sort = TRUE)

## 6. Tính thống kê mô tả cho height và mass. 
summary(starwars[, c("height", "mass")])


# --- 2. Trực quan hóa dữ liệu ---

## 1. Histogram cho height. 
ggplot(starwars, aes(x = height)) +
  geom_histogram() +
  labs(title = "Phân bố chiều cao nhân vật", x = "Chiều cao", y = "Số lượng")

## 2. Histogram cho mass. 
ggplot(starwars, aes(x = mass)) +
  geom_histogram() +
  xlim(0, 200) +
  labs(title = "Phân bố cân nặng nhân vật", x = "Cân nặng", y = "Số lượng")

## 3. Density plot cho height. 
ggplot(starwars, aes(x = height)) +
  geom_density(na.rm = TRUE) +
  labs(title = "Density plot chiều cao", x = "Chiều cao", y = "Mật độ")

## 4. Boxplot cho height.
ggplot(starwars, aes(y = height)) +
  geom_boxplot() +
  labs(title = "Boxplot chiều cao", y = "Chiều cao")

## 5. Boxplot cho mass.
ggplot(starwars, aes(y = mass)) +
  geom_boxplot() +
  ylim(0, 160) +
  labs(title = "Boxplot cân nặng", y = "Cân nặng")

## 6. Bar chart cho gender. 
ggplot(starwars, aes(x = gender)) +
  geom_bar() +
  labs(title = "Số lượng nhân vật theo gender", x = "Gender", y = "Số lượng")

## 7. Bar chart cho species, chỉ giữ nhóm có từ 2 quan sát trở lên. 
species_2 <- starwars %>%
  count(species) %>%
  filter(n >= 2)

ggplot(species_2, aes(x = reorder(species, n), y = n)) +
  geom_col() +
  coord_flip() +
  labs(title = "Số lượng nhân vật theo species từ 2 quan sát trở lên", x = "Species", y = "Số lượng")

## 8. Boxplot height theo gender. 
ggplot(starwars, aes(x = gender, y = height)) +
  geom_boxplot() +
  labs(title = "Chiều cao theo gender", x = "Gender", y = "Chiều cao")

## 9. Faceted histogram của height theo gender. 
ggplot(starwars, aes(x = height)) +
  geom_histogram() +
  facet_wrap(~ gender) +
  labs(title = "Phân bố chiều cao tách theo giới tính", x = "Chiều cao (cm)", y = "Số lượng")

## 10. Scatterplot giữa height và mass. 
ggplot(starwars, aes(x = height, y = mass)) +
  geom_point() +
  ylim(0, 160) +
  labs(title = "Mối quan hệ giữa chiều cao và cân nặng", x = "Chiều cao", y = "Cân nặng")


# --- 3. Làm sạch dữ liệu ---

## 1. Kiểm tra missing values trong height, mass, gender, species.
starwars %>%
  summarise(
    missing_height = sum(is.na(height)),
    missing_mass = sum(is.na(mass)),
    missing_gender = sum(is.na(gender)),
    missing_species = sum(is.na(species))
  )

## 2. Tạo bảng số lượng missing values cho từng biến.
missing_table <- data.frame(
  variable = names(starwars),
  missing_count = colSums(is.na(starwars))
)
missing_table

## 3. Phát hiện outlier trong mass, đặc biệt các quan sát có mass > 500. 
mass_outlier <- starwars %>%
  filter(mass > 500)
mass_outlier

## 4. Vẽ scatterplot height – mass trước và sau khi loại outlier. 
### Trước khi loại outlier
ggplot(starwars, aes(x = height, y = mass)) +
  geom_point() +
  ylim(0, 180) +
  labs(title = "Height và mass trước khi loại outlier", x = "Height", y = "Mass")

### Sau khi loại outlier
starwars_no_outlier <- starwars %>%
  filter(is.na(mass) | mass <= 500)

ggplot(starwars_no_outlier, aes(x = height, y = mass)) +
  geom_point(na.rm = TRUE) +
  labs(title = "Height và mass sau khi loại outlier mass > 500", x = "Height", y = "Mass")

## 5. Gộp nhóm hiếm trong hair_color hoặc species thành "Other". 
starwars_grouped <- starwars %>%
  add_count(hair_color, name = "hair_count") %>%
  mutate(
    hair_color_grouped = ifelse(hair_count < 2 | is.na(hair_color), "Other", hair_color)
  )

## 6. So sánh biểu đồ trước/sau khi gộp nhóm. 
### Trước khi gộp
ggplot(starwars, aes(x = hair_color)) +
  geom_bar() +
  coord_flip() +
  labs(title = "Hair color trước khi gộp nhóm", x = "Hair color", y = "Số lượng")

### Sau khi gộp
ggplot(starwars_grouped, aes(x = hair_color_grouped)) +
  geom_bar() +
  coord_flip() +
  labs(title = "Hair color sau khi gộp nhóm hiếm", x = "Hair color", y = "Số lượng")


# --- 4. Câu hỏi ---

## 1. Chiều cao nhân vật phân phối như thế nào? 
ggplot(starwars, aes(x = height)) +
  geom_histogram() +
  labs(title = "Phân bố chiều cao nhân vật", x = "Chiều cao", y = "Số lượng")

## 2. Cân nặng có bị ảnh hưởng mạnh bởi outlier không?
### Hình 1: Biểu đồ bị ảnh hưởng bởi Outlier (Để thang đo tự nhiên)
p1 <- ggplot(starwars, aes(y = mass)) +
  geom_boxplot() +
  labs(title = "Thang đo bị outlier kéo dãn", y = "Cân nặng gốc (kg)") +
  theme_minimal()
p1

### Hình 2: Biểu đồ sau khi giới hạn trục để nhìn rõ dữ liệu số đông
p2 <- ggplot(starwars, aes(y = mass)) +
  geom_boxplot() +
  ylim(0, 160) + 
  labs(title = "Khi giới hạn trục (Zoom cận cảnh)", y = "Cân nặng phóng to (kg)") +
  theme_minimal()
p2

## 3. Nhóm gender nào chiếm đa số? 
starwars %>%
  count(gender, sort = TRUE)

## 4. Có sự khác biệt chiều cao giữa các nhóm gender không? 
ggplot(starwars, aes(x = height)) +
  geom_histogram() +
  facet_wrap(~ gender) +
  labs(title = "Phân bố chiều cao tách theo giới tính", x = "Chiều cao (cm)", y = "Số lượng")

## 5. Có nên loại bỏ nhân vật có mass quá lớn không? Vì sao? 
# (Nhận xét ẩn dạng comment)