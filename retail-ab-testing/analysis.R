ab_data <- read.csv("data/uplift_train.csv")
head(ab_data)
dim(ab_data)
str(ab_data)

# Κενές τιμές ανά στήλη
colSums(is.na(ab_data))

# Επαναλαμβανόμενοι κωδικοί πελατών
sum(duplicated(ab_data$client_id))

# Πλήθος πελατών χωρίς και με SMS
table(ab_data$treatment_flg)

# Πλήθος πελατών που δεν αγόρασαν και που αγόρασαν
table(ab_data$target)

# Αγορές και μη αγορές ανά ομάδα
table(ab_data$treatment_flg, ab_data$target)

# Αποθηκεύουμε τον πίνακα διπλής εισόδου
purchase_table <- table(ab_data$treatment_flg, ab_data$target)

# Ποσοστά ανά γραμμή
prop.table(purchase_table, margin = 1) * 100


test_result <- prop.test(
  purchase_table[c("1", "0"), c("1", "0")], 
  alternative = "two.sided",                
  conf.level = 0.95                         
)

test_result
