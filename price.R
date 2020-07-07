#Loading all libraries
packages <- c("caret", "data.table", "ggplot2")
suppressPackageStartupMessages(invisible(lapply(packages, library, character.only = TRUE)))

#Importing Dataset
dataset <- fread("Automobile_data.csv")
head(dataset)

#Converting all missing values to NA
dataset[dataset == "?"] <- NA
head(dataset)

#Check number of NA in each column of the dataset
colSums(is.na(dataset))

#Data preprocessing
dataset$`normalized-losses` <- as.numeric(dataset$`normalized-losses`)
dataset$`normalized-losses`[is.na(dataset$`normalized-losses`)] <- mean(dataset$`normalized-losses`, na.rm = TRUE)

dataset$`num-of-doors` <- factor(dataset$`num-of-doors`,
                                 levels = c('four', 'two'),
                                 labels = c(1, 2))
dataset$`num-of-doors`[is.na(dataset$`num-of-doors`)] <- levels(dataset$`num-of-doors`)[round(runif(1, min = 1, max = 2))]

dataset$bore <- as.numeric(dataset$bore)
dataset$bore[is.na(dataset$bore)] <- mean(dataset$bore, na.rm = TRUE)

dataset$stroke <- as.numeric(dataset$stroke)
dataset$stroke[is.na(dataset$stroke)] <- mean(dataset$stroke, na.rm = TRUE)

dataset$stroke <- as.numeric(dataset$stroke)
dataset$stroke[is.na(dataset$stroke)] <- mean(dataset$stroke, na.rm = TRUE)

dataset$horsepower <- as.numeric(dataset$horsepower)
dataset$horsepower[is.na(dataset$horsepower)] <- mean(dataset$horsepower, na.rm = TRUE)

dataset$`peak-rpm` <- as.numeric(dataset$`peak-rpm`)
dataset$`peak-rpm`[is.na(dataset$`peak-rpm`)] <- mean(dataset$`peak-rpm`, na.rm = TRUE)

dataset$price <- as.numeric(dataset$price)
dataset$price[is.na(dataset$price)] <- mean(dataset$price, na.rm = TRUE)

dataset$`num-of-cylinders` <- factor(dataset$`num-of-cylinders`, 
                                     levels = c('eight', 'five', 'four', 'six', 'three', 'twelve', 'two'),
                                     labels = c(1, 2, 3, 4, 5, 6, 7))

dataset$`fuel-system` <- factor(dataset$`fuel-system`,
                                levels = c('1bbl', '2bbl', '4bbl', 'idi', 'mfi', 'mpfi', 'spdi', 'spfi'),
                                labels = c(1, 2, 3, 4, 5, 6, 7, 8))

dataset$`engine-type` <- factor(dataset$`engine-type`,
                                levels = c('dohc', 'dohcv', 'l', 'ohc', 'ohcf', 'ohcv', 'rotor'),
                                labels = c(1, 2, 3, 4, 5, 6, 7))

dataset$make <- factor(dataset$make,
                       levels = c("alfa-romero", "audi", "bmw", "chevrolet", "dodge", "honda", "isuzu", "jaguar", "mazda", "mercedes-benz", "mercury",
                                  "mitsubishi", "nissan", "peugot", "plymouth", "porsche", "renault", "saab", "subaru", "toyota", "volkswagen", "volvo"),
                       labels = 1:22)

dataset$`fuel-type` <- factor(dataset$`fuel-type`,
                              levels = c('diesel', 'gas'),
                              labels = c(1, 2))

dataset$aspiration <- factor(dataset$aspiration,
                             levels = c('std', 'turbo'),
                             labels = c(1, 2))

dataset$`body-style` <- factor(dataset$`body-style`,
                               levels = c("convertible", "hardtop", "hatchback", "sedan", "wagon"),
                               labels = c(1, 2, 3, 4, 5))

dataset$`drive-wheels` <- factor(dataset$`drive-wheels`,
                                 levels = c('4wd', 'fwd', 'rwd'),
                                 labels = c(1, 2, 3))

dataset$`engine-location` <- factor(dataset$`engine-location`,
                                    levels = c('front', 'rear'), 
                                    labels = c(1, 2))

inTrain <- createDataPartition(dataset$price, p = 0.7, list = FALSE)
training <- dataset[inTrain, ]
testing <- dataset[-inTrain, ]

model = train(price ~ 'engine-location' + 'curb-weight' + 'num-of-cylinders' + 'engine-size' + horsepower, 
              data = dataset, model = "rf", ntree = 50)