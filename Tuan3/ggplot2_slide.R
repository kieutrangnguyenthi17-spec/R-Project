# Nguyễn Thị Kiều Trang
# mssv: 24133064
# Data visulization with ggplot2

# load mpdata

data(mpg)
head(mpg)

# Xem cấu trúc của mpg data

str(mpg)

# Tạo biểu đồ với ggplot

ggplot(data=mpg)+geom_point(mapping=aes(x=displ, y=hwy))

# Mapping

ggplot(data=mpg, mapping = aes(x=displ, y=hwy))+geom_point()

# Global mapping

ggplot(mpg, mapping=aes(x=displ, y=hwy))+geom_point()

# Local mapping

ggplot(mpg,mapping=aes(x=displt, y=hwy))+geom_point(mapping=aes(color=class))

## Thiết lập locally

ggplot(data=mpg, mapping =aes(x=displ, y=hwy))+ geom_point(mapping=aes(color=class))+geom_smooth(data=filter(mpg,displ<5))

# Aesthetics - thuộc tính thẫm mỹ

ggplot(data=mpg)+geom_point(aes(x=displ,y=hwy,color=class))

## Một màu

ggplot(data=mpg)+geom_point(aes(x=displ,y=hwy,color="green"))

## Size aesthetic

ggplot(data=mpg)+geom_point(mapping=aes(x=displ, y=hwy, size=class))

## Alpha aesthetic - transparency

ggplot
(data=mpg)+geom_point(mapping=aes(x=displ, y=hwy, alpha=class))

## Shape aesthetic - Hình dạng của điểm dữ liệu

ggplot(data=mpg)+geom_point(mapping=aes(x=displ, y=hwy, shape=class))

## Kết hợp nhiều aesthetic

ggplot(data=mpg)+geom_point(mapping=aes(x=displ, y=hwy, size=class, color=class))

# Faceting - tách biểu đồ con

## Facet_wrap

ggplot(data=mpg)+geom_point(mapping=aes(x=displ, y=hwy))+facet_wrap(~ class, nrow=2)

## facet_grid

ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy))+facet_grid(drv ~ cyl)

## Không facet theo dòng hoặc cột

ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy))+facet_grid(. ~ cyl)
                          
# Goems - geometric objects

## Geom_smooth

ggplot(data=mpg)+geom_smooth(mapping=aes(x=displ,y=hwu))

ggplot(data=mpg)+geom_smooth(mapping=aes(x=displ,y=hwu, linetype=drv))

## Kết hợp geom_point, geom_smooth

ggplot(data=mpg, mapping=aes(x=displ, y=hwy, color=drv)) + geom_point()+geom_smooth()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth()

## Kết hợp geom_point, geom_smooth, local mapping

ggplot(data=mpg, mapping=aes(x=displ, y=hwy))+geom_point(mapping=aes(color=class))+geom+smooth(data=filter(mpg, class=="subcompact"),se=FALSE)




