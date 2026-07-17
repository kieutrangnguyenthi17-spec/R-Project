library(dplyr)
# Thông tin về các nhân vật trong loạt phim Star Wars.

glimpse(starwars)

# Hiện các dòng đầu tiên 

head(starwars)

# CHọn cột

select(starwars, name, height, mass, gender)

# Chọn dòng 

filter(starwars, sex=='male' & height > 180)

# Toán tử pipe

filter(select(starwars, name, height, mass, sex),
       sex == 'male' & height > 180)

starwars %>%
  select(name, height, mass, sex) %>%
  filter(sex == 'male' & height > 180)

# Loại bỏ cột

starwars %>%
select(-c(hair_color, skin_color, eye_color,
            films, vehicles, starships))

# Chọn các cột liên tiếp 

starwars %>%
select (name:mass)

# Sắp xếp các dòng theo thứ tự với arrange

starwars %>%
  select(name:mass) %>%
  arrange(mass)

# Sắp xếp các dòng theo thứ tự giảm dần với arrange và desc

starwars %>%
  select(name:mass) %>%
  arrange(desc(mass))

# Chọn các dòng theo chỉ số với slice

starwars %>%
  select(name:mass) %>%
  slice(1:5)

# Ghi chú mã với #

starwars %>%
  #select(name:mass) %>% # dòng này không thực thi
  slice(1:3) # chọn dòng

# Chọn các dòng theo chỉ số với slice

nrows = nrow(starwars) # lấy số dòng của data frame
starwars %>%
  select(name:mass) %>%
  slice((nrows - 3):nrows)

# Chọn các dòng theo điều kiện với filter

starwars %>%
  filter(height > 220) %>%
  select(name, height, mass, gender, homeworld, species)

# Chọn các dòng theo nhiều điều kiện với filter

starwars %>%
  filter(
    height > 200,
    mass > 100
  ) %>%
  select(name, height, mass, gender, homeworld, species)

# Lọc để chọn các dòng duy nhất với distinct

starwars %>%
  distinct(species, homeworld) %>%
  arrange(species, homeworld)

# Tạo bảng tần số với count

starwars %>%
  count(species, gender) %>%
  arrange(species, gender)

# Tạo thêm biến mới với mutate

starwars %>%
  mutate(
    bmi = mass / (height/100)^2
  ) %>%
  select(name, bmi, gender) %>%
  arrange(name)

# Tổng hợp với summarise

starwars %>%
  summarise(
    avg_height = mean(height, na.rm = T),
    avg_mass = mean(mass, na.rm = T)
  )

# Tổng hợp với summarise và group_by

starwars %>%
  group_by(gender) %>%
  summarise(
    avg_height = mean(height, na.rm = T),
    avg_mass = mean(mass, na.rm = T),
    num_chars = n()
  )
