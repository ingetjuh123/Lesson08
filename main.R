## Team Script0rs - Inge & David 17 January 2017
## Lesson 08 - Main

library(raster)
library(sp)
library(hydroGOF)

## Load necessary bands and VCF data
load("data/GewataB1.rda")
load("data/GewataB2.rda")
load("data/GewataB3.rda")
load("data/GewataB4.rda")
load("data/GewataB5.rda")
load("data/GewataB7.rda")
load("data/vcfGewata.rda")
load("data/trainingPoly.rda")

## Produce plot demonstrating relationship between Landsat and VCF
RelationshipGewata <- brick(GewataB1, GewataB4, GewataB7, vcfGewata)
pairs(RelationshipGewata)

## Create Gewata DataFrame
Gewatabrick <- brick(GewataB1, GewataB2, GewataB3, GewataB4, GewataB5, GewataB7)
Gewatabrick <- calc(Gewatabrick, fun=function(x) x/10000)

## Extract NA values from vcf data
vcfGewata[vcfGewata > 100] <- NA
Gewata <- addLayer(Gewatabrick, vcfGewata)
names(Gewata) <- c("Band1", "Band2", "Band3", "Band4", "Band5", "Band7", "VCF")
Gewatadf <- as.data.frame(getValues(Gewata))

## Create model
model <- lm(VCF ~ Band1 + Band2 + Band3 + Band4 + Band5 + Band7, data = Gewatadf)                           
summary(model)

## Create predicted tree cover raster
predictedTreeCover <- predict(Gewata, model = model, na.rm=TRUE)
predictedTreeCover[predictedTreeCover < 0] <- NA

## plot predicted tree cover raster with original VCF raster
opar <- par(mfrow=c(1,2))
plot(predictedTreeCover)
plot(vcfGewata)

## Use RMSE function
rmse(predictedTreeCover[], vcfGewata[], na.rm=TRUE)

## 
