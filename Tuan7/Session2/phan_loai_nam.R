
# Bài toán phân loại nấm bằng Logistic Regression và Decision Tree

# 1. Đọc dữ liệu
data <- read.csv("mushrooms.csv", stringsAsFactors = TRUE)

# 2. Tiền xử lý dữ liệu
# Kiểm tra và loại bỏ thuộc tính không thay đổi
table(data$veil.type)  # Nếu chỉ có 1 giá trị thì loại bỏ
data$veil.type <- NULL  # Loại bỏ vì không mang thông tin

# 3. Chia tập train/test
set.seed(123)
sample_index <- sample(1:nrow(data), 0.8 * nrow(data))
train_data <- data[sample_index, ]
test_data <- data[-sample_index, ]

# 4. Logistic Regression
log_model <- glm(class ~ ., data = train_data, family = binomial)
summary(log_model)
log_pred_probs <- predict(log_model, newdata = test_data, type = "response")
log_pred <- ifelse(log_pred_probs > 0.5, "p", "e")
log_pred <- factor(log_pred, levels = levels(test_data$class))
log_accuracy <- mean(log_pred == test_data$class)
print(paste("Độ chính xác Logistic Regression:", round(log_accuracy, 4)))

# 5. Decision Tree
library(rpart)
library(rpart.plot)
tree_model <- rpart(class ~ ., data = train_data, method = "class")
rpart.plot(tree_model)
tree_pred <- predict(tree_model, newdata = test_data, type = "class")
tree_accuracy <- mean(tree_pred == test_data$class)
print(paste("Độ chính xác Decision Tree:", round(tree_accuracy, 4)))
