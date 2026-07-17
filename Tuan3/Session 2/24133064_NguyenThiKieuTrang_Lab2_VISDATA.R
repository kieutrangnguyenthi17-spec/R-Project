# Nguyễn Thị Kiều Trang
# 24133064

library(tidyverse)

# Phần 1. Với dữ liệu recent_grads

recent_grads <-read.csv("recent_grads.csv")

## Q1.
# Khám phá cấu trúc dữ liệu recent_grads: xem 
# số dòng, số cột, tên biến, kiểu dữ liệu, vài 
# dòng đầu và thống kê mô tả của các biến 
# chính

### xem số và số cột

dim(recent_grads)

### Xem tên biến

names(recent_grads)

### Xem kiểu dữ liệu và cấu trúc

str(recent_grads)

### Xem vài dòng đầu

head(recent_grads, 10)

### Thống kê mô tả cơ bản

summary(recent_grads)

### Biến phân loại

recent_grads %>%
  select(Major, Major_category) %>%
  head()

### Biến định lượng

recent_grads %>%
  select(Total, Median, Unemployment_rate, ShareWomen) %>%
  summary()

# Bảng/tóm tắt dữ liệu và nhận xét ngắn về biến định lượng, biến phân 
# loại.

### Bảng tóm tắt dữ liệu

recent_grads %>%
  select(Major, Major_category,
         Total, Median,
         Unemployment_rate,
         ShareWomen) %>%
  summary()

# Nhận xét:
# Q2
# Vẽ biểu đồ histogram của thu nhập trung vị Median. 
# Mỗi cột thể hiện số lượng ngành nằm trong một khoảng thu nhập

ggplot(recent_grads, aes(x = Median)) +
  geom_histogram(
    bins = 20,
    fill = "skyblue",
    color = "black"
  ) +
  labs(
    title = "Histogram of Median Income",
    x = "Median Income",
    y = "Number of Majors"
  ) +
  theme_minimal()

# Một histogram có tiêu đề, nhãn trục x/y; giải thích trục x lấy từ Median và 
# trục y là số lượng ngành được ggplot2 tự đếm

 # - Trục x lấy từ biến Median, thể hiện mức thu nhập trung vị của các ngành học.
 # - Trục y là số lượng ngành học trong mỗi khoảng thu nhập và được ggplot2 tự động đếm thông qua geom_histogram().
 # - Mỗi cột biểu diễn số ngành có mức thu nhập nằm trong khoảng tương ứng.

## Q3

## Thử thay đổi độ rộng khoảng của histogram và so sánh sự khác biệt.

### Histogram với binwidth nhỏ

ggplot(recent_grads, aes(x = Median)) +
  geom_histogram(
    binwidth = 2000,
    fill = "skyblue",
    color = "black"
  ) +
  labs(
    title = "Histogram with Small Binwidth",
    x = "Median Income",
    y = "Number of Majors"
  ) +
  theme_minimal()

### Histogram với binwidth lớn

ggplot(recent_grads, aes(x = Median)) +
  geom_histogram(
    binwidth = 10000,
    fill = "orange",
    color = "black"
  ) +
  labs(
    title = "Histogram with Large Binwidth",
    x = "Median Income",
    y = "Number of Majors"
  ) +
  theme_minimal()
# * Nhận xét *
#  - Khi binwidth nhỏ, histogram có nhiều cột hơn và thể hiện chi tiết phân phối dữ liệu rõ hơn.
#  - Khi binwidth lớn, số cột giảm và biểu đồ nhìn tổng quát hơn nhưng mất bớt chi tiết.
#  - Việc thay đổi binwidth ảnh hưởng trực tiếp đến cách quan sát hình dạng phân phối của dữ liệu.

# Q4

top10_major <- recent_grads %>%
  arrange(desc(Median)) %>%
  slice(1:10)

ggplot(top10_major, aes(x=reorder(Major, Median), y=Median))+
  geom_col(fill="steelblue")+
  coord_flip()+
  labs(
    title="Top 10 Major with Highest Median Income", 
    x="Major",
    y="Median Income"
  )+
  theme_minimal()

# Q5
# Vẽ scatter plot để phân tích mối quan hệ giữa 
# tỷ lệ thất nghiệp và thu nhập trung vị.

ggplot(data=recent_grads, aes(x=Unemployed_rate, y=Median))+
  geom_point(color = "blue", alpha = 0.7) +
  geom_smooth(method = "lm",
              se = FALSE,
              color = "red") +
  labs(
    title = "Scatter Plot of Unemployment Rate vs Median Income",
    x = "Unemployment Rate",
    y = "Median Income"
  ) +
  theme_minimal()

## Q6
# So sánh phân phối thu nhập trung vị giữa các nhóm ngành bằng boxplot.

ggplot(recent_grads, aes(x=Major_category,y=Median,fill=Major_category))+
  geom_boxplot()+
  labs(
    title="Median Income by Major Category", 
    x="Major Category",
    y="Median Income"
  )+
  theme_minimal()+
  theme(
    axis.text.x=element_text(angle=90)
  )

## Q7
# Biểu đồ facet

ggplot(recent_grads,
       aes(x = Median)) +
  geom_histogram(
    bins = 15,
    fill = "skyblue",
    color = "black"
  ) +
  facet_wrap(~Major_category) +
  labs(
    title = "Distribution of Median Income by Major Category",
    x = "Median Income",
    y = "Number of Majors"
  ) +
  theme_minimal()

## Q8

### Tạo một biểu đồ tự chọn có sử dụng ít nhất hai aesthetics ngoài x/y

ggplot(recent_grads,
       aes(x = ShareWomen,
           y = Median,
           color = Major_category,
           size = Total,
           alpha = Unemployment_rate)) +
  geom_point() +
  labs(
    title = "Median Income by Share of Women",
    x = "ShareWomen",
    y = "Median Income",
    color = "Major Category",
    size = "Total Students",
    alpha = "Unemployment Rate"
  ) +
  theme_minimal()

### Giải thích: biến nào được map vào color/size/alpha, thuộc tính nào là giá trị cố định.

# Phần 2: Với dữ liệu company_sales

## Q1

company_sales <-read.csv("company_sales.csv")

### Biểu đồ đường thể hiện sự thay đổi của total_profit theo month_number.

ggplot(company_sales, aes(x=month_number, y=total_profit))+
  geom_line(color = "blue", linewidth = 1)+
  labs(
    title="Tổng lợi nhuận theo từng tháng",
    x = "Month Number",
    y = "Total Profit")+
  theme_minimal()

## Q2

### Vẽ biểu đồ đường thể hiện tổng số sản phẩm bán ra theo tháng

ggplot(company_sales, aes(x=month_number, y=total_units))+
  geom_line(color="green", linewidth = 1)+
  labs(
    title="Tổng số sản phẩm bán ra theo tháng",
    x = "Month Number",
    y = "Total units")+
  theme_minimal()

## Q3

### So sánh doanh số bán của facecream và facewash theo tháng.

ggplot(company_sales, aes(x = month_number)) +
  geom_line(aes(y = facecream, color = "Face Cream"),
            linewidth = 1) +
  geom_line(aes(y = facewash, color = "Face Wash"),
            linewidth = 1) +
  labs(
    title = "So sánh doanh số Face Cream và Face Wash theo tháng",
    x = "Month Number",
    y = "Sales",
    color = "Product"
  ) +
  theme_minimal()

### So sánh số lượng bán ra của hai sản phẩm

## Q4

### Biểu đồ cột thể hiện doanh số toothpaste theo tháng

ggplot(company_sales, aes(x=month_number, y=toothpaste))+
  geom_col()+
  labs(
    title="Doanh số toothpaste theo tháng",
    x="Month Number",
    y="Toothpaste")+
  theme_minimal()

## Q5

### Biểu đồ histogram của tổng lợi nhuận

ggplot(company_sales, aes(x = total_profit)) +
  geom_histogram(
    bins = 10,
    fill = "skyblue",
    color = "black"
  ) +
  labs(
    title = "Biểu đồ histogram của tổng lợi nhuận",
    x = "Total Profit",
    y = "Frequency"
  ) +
  theme_minimal()

## Q6

### Biểu đồ phân tán để kiểm tra mối quan hệ giữa tổng số sản phẩm bán ra và tổng lợi nhuận

ggplot(company_sales,
       aes(x = total_units,
           y = total_profit)) +
  geom_point(color = "blue", size = 3) +
  labs(
    title = "Mối quan hệ giữa tổng số sản phẩm bán ra và tổng lợi nhuận",
    x = "Total Units",
    y = "Total Profit"
  ) +
  theme_minimal()

## Q7

### Biểu đồ đường so sánh doanh số của tất cả sản phẩm

company_sales_long <- company_sales %>%
  pivot_longer(
    cols = c(facecream, facewash, toothpaste,
             bathingsoap, shampoo, moisturizer),
    names_to = "Product",
    values_to = "Sales"
  )

ggplot(company_sales_long,
       aes(x = month_number,
           y = Sales,
           color = Product)) +
  geom_line(linewidth = 1) +
  labs(
    title = "So sánh doanh số của tất cả sản phẩm theo tháng",
    x = "Month Number",
    y = "Sales",
    color = "Product"
  ) +
  theme_minimal()

## Q8

###  Tổng số lượng bán ra trong cả năm cho từng sản phẩm

product_sales <- company_sales %>%
  summarise(
    facecream = sum(facecream),
    facewash = sum(facewash),
    toothpaste = sum(toothpaste),
    bathingsoap = sum(bathingsoap),
    shampoo = sum(shampoo),
    moisturizer = sum(moisturizer)
  ) %>%
  pivot_longer(
    cols = everything(),
    names_to = "Product",
    values_to = "Total_Sales"
  )

### Vẽ biểu đồ cột

ggplot(product_sales,
       aes(x = Product,
           y = Total_Sales,
           fill = Product)) +
  geom_col() +
  labs(
    title = "Tổng doanh số cả năm theo từng sản phẩm",
    x = "Product",
    y = "Total Sales"
  ) +
  theme_minimal()

## Q9

### Vẽ boxplot cho doanh số của từng sản phẩm

ggplot(company_sales_long,
       aes(x = Product,
           y = Sales,
           fill = Product)) +
  geom_boxplot() +
  labs(
    title = "So sánh phân phối doanh số giữa các sản phẩm",
    x = "Product",
    y = "Sales"
  ) +
  theme_minimal()

## Q10

### Biểu đồ thể hiện tỷ trọng doanh số từng sản phẩm trong cả năm

product_sales <- product_sales %>%
  mutate(
    Percentage = Total_Sales / sum(Total_Sales) * 100
  )

ggplot(product_sales,
       aes(x = "",
           y = Percentage,
           fill = Product)) +
  geom_col(width = 1) +
  coord_polar(theta = "y") +
  labs(
    title = "Tỷ trọng doanh số từng sản phẩm trong cả năm",
    fill = "Product"
  ) +
  theme_void()