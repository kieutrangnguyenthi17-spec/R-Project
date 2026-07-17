# PHẦN 1: DỮ LIỆU MẪU
# 1.1 Dữ liệu sinh viên (students)
students <- data.frame(
  hoten = c("Nguyen An","Tran Binh","Le Cuong","Pham Dung","Hoang Em","Vu Phuc",
            "Dang Giang","Bui Hoa","Cao Ich","Dinh Kim","Do Long","Ha My"),
  lop =
    c("12A","12A","12B","12B","12A","12C","12C","12B","12A","12C","12B","12C"),
  gioitinh= c("Nam","Nu","Nam","Nu","Nam","Nam","Nu","Nu","Nam","Nu","Nam","Nu"),
  toan = c(9.0, 7.5, 6.0, 8.5, 5.0, 9.5, 7.0, 8.0, 4.5, 8.5, 6.5, 9.0),
  ly = c(8.5, 7.0, 5.5, 9.0, 5.0, 9.0, 7.5, 7.5, 5.0, 8.0, 6.0, 9.5),
  hoa = c(8.0, 8.5, 6.0, 8.5, 5.5, 9.5, 7.0, 8.0, 4.5, 9.0, 6.5, 8.5),
  van = c(7.5, 9.0, 7.0, 8.0, 6.0, 8.5, 8.5, 9.5, 5.5, 7.5, 7.0, 9.0),
  anh = c(8.0, 8.5, 6.5, 7.5, 5.5, 9.0, 8.0, 8.5, 5.0, 8.5, 6.0, 9.5),
  diemtb = c(8.2, 8.1, 6.2, 8.3, 5.4, 9.1, 7.6, 8.3, 4.9, 8.3, 6.4, 9.1)
)
# 1.2 Dữ liệu bán hàng (sales)
sales <- data.frame(
  thang = c(1,1,1,1,2,2,2,2,3,3,3,3),
  khuvuc =
    c("Bac","Nam","Bac","Nam","Bac","Nam","Bac","Nam","Bac","Nam","Bac","Nam"),
  sanpham = c("Laptop","Laptop","Phone","Phone","Laptop","Laptop","Phone","Phone",
              "Laptop","Laptop","Phone","Phone"),
  soluong = c(15,12,50,60,18,20,55,70,22,25,60,80),
  dongia = c(22000,22000,5500,5500,22000,22000,5500,5500,22000,22000,5500,5500),
  doanhthu = c(330000,264000,275000,330000,396000,440000,302500,385000,
               484000,550000,330000,440000)
)
# PHẦN 2: BÀI TẬP XỬ LÝ DỮ LIỆU (dplyr)
# Bài 1 – Chọn cột và lọc dòng (select, filter)
# Yêu cầu:
# • 1a. Chọn các cột: hoten, lop, gioitinh, diemtb từ bảng students.

select(students, hoten, lop, gioitinh,diemtb)

# • 1b. Lọc những sinh viên có điểm trung bình ≥ 8.0.

students %>% 
  filter(diemtb>=8)

# • 1c. Lọc sinh viên nữ thuộc lớp 12A hoặc 12B.

students %>%
  filter(gioitinh=="Nu" & (lop=="12A"|lop=="12B"))

# • 1d. Lọc sinh viên có điểm Toán > 8.0 VÀ điểm Văn > 8.0.

students %>%
  filter(toan >8 & van > 8)

# Bài 2 – Sắp xếp và lấy mẫu (arrange, slice)
# Yêu cầu:
# • 2a. Sắp xếp danh sách sinh viên theo điểm Toán giảm dần.

students %>%
  arrange(desc(toan))

# • 2b. Hiển thị Top 3 sinh viên có điểm trung bình cao nhất.

students %>%
  arrange(desc(toan)) %>%
  head(3)

# • 2c. Hiển thị 3 sinh viên có điểm trung bình thấp nhất.

students %>%
  arrange(diemtb) %>%
  head(3)


# • 2d. Sắp xếp theo lớp tăng dần, trong mỗi lớp sắp xếp theo điểm TB giảm dần.

students%>%
  arrange(lop, desc(diemtb)) 
 
# Bài 3 – Tạo biến mới (mutate)
# Bài tập R – dplyr & ggplot2 | Trang 4
# Yêu cầu:
# • 3a. Tạo cột diem_khtn = trung bình của Toán, Lý, Hóa.

students%>%
  mutate(diem_khtn=(toan+ly+hoa)/3)

# • 3b. Tạo cột diem_khxh = trung bình của Văn, Anh.

students%>%
  mutate(diem_khxh=(van+anh)/2)

# • 3c. Tạo cột xeploai dựa vào diemtb: "Xuất sắc" (≥9.0), "Giỏi" (≥8.0), "Khá" (≥6.5),
# "Trung bình" (còn lại).

students%>%
  mutate(
    xeploai=case_when(
      diemtb>=9 ~ "Xuat sac",
      diemtb>=8 ~ "Gioi",
      diemtb>=6.5 ~ "Kha",
      TRUE ~ "Trung binh"
    )
  )


# • 3d. Tạo cột vuot_trung_binh = TRUE nếu diemtb > trung bình chung của lớp.

students%>%
  mutate(vuot_trung_binh= diemtb>(mean(diemtb, na.rm=TRUE)))

# Bài 4 – Tổng hợp theo nhóm (group_by, summarise)
# Yêu cầu:
# • 4a. Tính điểm trung bình mỗi môn theo từng lớp.

students%>%
  group_by(lop)%>%
  summarise(
    tb_toan=mean(toan, na.rm=TRUE),
    tb_ly=mean(ly, na.rm=TRUE),
    tb_hoa=mean(hoa, na.rm=TRUE),
    tb_van=mean(van, na.rm=TRUE),
    tb_anh=mean(anh, na.rm=TRUE)
  )

# • 4b. Đếm số sinh viên Nam/Nữ trong mỗi lớp.

students %>%
  group_by(lop, gioitinh) %>%
  summarise(
    soluong=n()
  )
  
# • 4c. Tìm điểm Toán cao nhất và thấp nhất của mỗi lớp.

students%>%
  group_by(lop) %>%
  summarise(   
    diem_cao_nhat = max(diemtb),
    diem_thap_nhat = min(diemtb)
  )

# • 4d. Tính tổng doanh thu theo từng khu vực trong bảng sales.

sales %>%
  group_by(khuvuc, doanhthu) %>%
  summarise(
    tong_doanh_thu = sum(doanhthu, na.rm = TRUE)
  )

# Bài 5 – Kết hợp dữ liệu (join)

# Tạo thêm bảng phu luc ghi thông tin giáo viên chủ nhiệm:
  gvcn <- data.frame(
    lop = c("12A", "12B", "12C"),
    gvcn = c("Co Lan", "Thay Minh", "Co Huong"),
    phonghoc = c("P201", "P305", "P102")
  )

# Yêu cầu:
# • 5a. Dùng inner_join() để ghép students với gvcn theo cột lop.

students%>%
  inner_join(gvcn,by="lop")

# • 5b. Hiển thị danh sách sinh viên kèm tên giáo viên chủ nhiệm và phòng học.

students%>%
  inner_join(gvcn,by="lop")%>%
  select(hoten,lop,gvcn,phonghoc)

# • 5c. Tạo bảng thống kê: mỗi lớp có bao nhiêu sinh viên, điểm TB của lớp là bao nhiêu,
# GVCN là ai

students %>%
  inner_join(gvcn, by = "lop") %>%
  group_by(lop, gvcn) %>%
  summarise(
    so_sinh_vien = n(),
    diem_tb_lop = mean(diemtb, na.rm = TRUE)
  )
