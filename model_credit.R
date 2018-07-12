install_library <- function()
#########################################################################
#####                 Importation Package                           #####
rm(list=ls()) #on vide la 

#install.packages('Hmisc')
#install.packages('ggplot2')
#install.packages('questionr')
#install.packages('maptools')
#install.packages("dummies")
#install.packages("ade4")
library("ade4")
library("dplyr")
library('maptools')
library("questionr")
library("ROCR")
library("naivebayes")

telechargement_data <- function()
#########################################################################
#####                 Téléchargement donnée                        #####
column_name = c("Comptes", "Duree_credit", "Historique_credit", "Objet_credit", "Montant_credit", "Epargne", "Anciennete_emploi", "taux_effort", "Situation_familiale", "Garanties", "Anciennete_domicile", "Biens", "Age", "Autres_credits", "Statut_domicile", "Nb_credits", "Type_emploi", "Nb_pers_charge", "Telephone", "Etranger", "Cible")
df_initial <- read.table('data/credit.txt', sep=' ', col.names = column_name) #readr or 
credit <- read.table('data/credit.txt', sep=' ', col.names = column_name)
#csv <- read.csv('chemain/nom_fichier.csv', sep=',')


Visualisation <- function()
########################################################################
#####                 Visualisation des données                    #####
# Observation une premiere fois les données
head(credit)

summary(credit)

describe(credit) #si on a importer la lib questionr

class(credit) #data frame
sum(is.null(credit)) # il n'y a pas de valeur null
table(credit$Cible) # il y a plus de validation que de refus d'accorder un credit


# Cliquer sur Tools > Addins > numeric... >
#my_structure <- str(credit)

hist(credit$Age)
boxplot(credit$Duree_credit)
plot(credit$Etranger, credit$Cible)
plot(credit$Garanties, credit$Cible)

pretraitement <- function()
########################################################################
#####                 Prétraitement des données                    #####
#dplyr::select_if(credit, is.numeric)
nom_col_bin <- c('Nb_pers_charge', 'Telephone', "Etranger", "Cible")

nom_col_numerique <- c('Duree_credit', 'Montant_credit', "Age", "Nb_credits")

#cols <- colnames(credit)[which(sapply(credit, function(x) is.factor(x) & !is.ordered(x)))]
nom_col_nominal <- c("Historique_credit", "Objet_credit", "Situation_familiale", "Garanties", "Biens", "Autres_credits", "Statut_domicile", "Type_emploi")

nom_col_categoriel <- c("Comptes", "Epargne", "Anciennete_emploi", "Anciennete_domicile", "taux_effort")


#Variable Etranger => A201:0 // A202: 1
credit$Etranger <- plyr::mapvalues(credit$Etranger, from=c("A201","A202"), to=c(0,1))

credit$Telephone <- plyr::mapvalues(credit$Telephone, from=c("A191","A192"), to=c(0,1))

#Variable Cible => 1 : 1 // 2 : 0
credit$Cible<- plyr::mapvalues(credit$Cible, from=c(1, 2),to=c(1,0))


#### One hot encoding on Nominal col
ad <- acm.disjonctif(subset(credit, select=nom_col_nominal))
credit <- cbind(credit, ad) # add new col to credit
credit[nom_col_nominal] <- NULL # delet col nom in credit

#### traitement categorial col
# Variable Comptes => "A11" = 0 ,"A12" = 1 ,"A13" = 2, "A14" = 3
credit$Comptes <- plyr::mapvalues(credit$Comptes, from=c("A11","A12","A13", "A14"), to=c(0,1,2,3))

credit$Epargne <- plyr::mapvalues(credit$Epargne, from=c("A61","A62","A63", "A64","A65"), to=c(0,1,2,3,4))

credit$Anciennete_emploi <- plyr::mapvalues(credit$Anciennete_emploi, from=c("A71","A72","A73", "A74","A75"), to=c(0,1,2,3,4))

split_data <- function()   
########################################################################
#####              Split des données Train/Test                    #####

data <- sample(2, nrow(credit), replace=TRUE, prob = c(0.70,0.30))
train_data <- credit[data == 1,]
nrow(train_data)

test_data <- credit[data == 2,]

mes_models <- function()
########################################################################
#####                    Entrainement (model)                      #####
#regression logisitique
modellogistique <- glm(formula = Cible ~ ., data = train_data)


# Classification with Gaussian Naive Bayes
library(e1071)
modelNB <- naiveBayes(Cible ~ ., data = train_data)

# Classification with Nearest Neighbors
#library(class)
#modelKNN <- knn(train_data, test_data, cl=)


# Classification with LinearSVC
# https://stackoverflow.com/questions/36341381/how-to-plot-svm-classification-hyperplane

# Classification with DecisionTreeClassifier


Prediction <- function()
########################################################################
#####                         Prediction                           #####
predictlogistique <- predict(modellogistique, test_data, type="raw")[,2]
classes <- as.factor(as.numeric(predictlogistique >= 0.5))
scores <- data.frame(classes, predictlogistique)

predictNB <- predict(modelNB, test_data)
classes <- as.factor(as.numeric(predictNB >= 0.5))
scores <- data.frame(classes, predictNB)
#mmetric(test_data$Cible, predictNB, c("ACCURACY", "PRECISION", "TPR", "F1")) 


#predictKNN <- predict(modelKNN, test_data)
#classes <- as.factor(as.numeric(predictlogistique >= 0.5))
#scores <- data.frame(classes, predictlogistique)
