## Team Script0rs - Inge & David 17 January 2017
## Lesson 08 - Main

## Load necessary bands and VCF data
load("data/GewataB1.rda")
load("data/GewataB2.rda")
load("data/GewataB3.rda")
load("data/GewataB4.rda")
load("data/GewataB5.rda")
load("data/GewataB7.rda")
load("data/vcfGewata.rda")

## Produce plot demonstrating relationship between Landsat and VCF
RelationshipGewata <- brick(GewataB1, GewataB4, GewataB7, vcfGewata)
pairs(RelationshipGewata)

## Create Gewata DataFrame
Gewata <- brick(GewataB1, GewataB2, GewataB3, GewataB4, GewataB5, GewataB7, vcfGewata)
Gewata <- calc(Gewata, fun=function(x) x/10000)
names(Gewata) <- c("Band1", "Band2", "Band3", "Band4", "Band5", "Band7", "VCF")
Gewatadf <- as.data.frame(getValues(Gewata))

                            