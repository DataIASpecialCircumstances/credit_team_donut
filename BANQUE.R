
#Credit Project

#LIBRAIRIES : 

#install.packages(Hmisc)
library(Hmisc)
#install.packages(questionr)
library(questionr)


#LOAD DATASET : 

column_name <- c( "Comptes", "Duree_credit", "Historique_credit", "Objet_credit", "Montant_credit", "Epargne", "Anciennete_emploi", "taux_effort", "Situation_familiale", "Garanties", "Anciennete_domicile", "Biens", "Age", "Autres_credits", "Statut_domicile", "Nb_credits", "Type_emploi", "Nb_pers_charge", "Telephone", "Etranger", "Cible")

df <- read.csv(file= 'credit.txt', sep = '', col.names = column_name)


#DESCRIBE DATASET : 


str(df) #la struture
summary(df)
describe(df) #pas de NA !

#REPLACE VALUES : 

#Comptes: 
#install.packages(plyr)
#install.packages(dplyr)
install.packages(maptools)

from <- c("A11", "A12", "A13", "A14")
to <- c("CC < 0Euros", "0euros <= CC < 200Euros", 'CC > 200Euros', 'Pas de compte')
df$Comptes <- with(df, mapvalues(Comptes, from, to)) # changement dans une colonne précise



# HISTOGRAMMES Montant_credit : 

hist_1 <- hist(df$Montant_credit, freq =FALSE)

hist_1$breaks

hist_2 <- hist(df$Montant_credit, breaks = 200, xlab = "Montant_credit", main = "Histogram of the loan amount")

# PLOT AGE
plot(df$Age, ylab="Age")

# outliers Age > 70

index_highage <- which(df$Age > 70)
index_highage




# create dataset new_df 
new_df <- df[-index_highage, ]
new_df


# MISSING INPUTS
summary(df) # aucun " NA's "

# DELETE NA : 
#index_NA <- which(is.na(df$Age))
#df_no_NA <- df[-c(index_NA), ]

# REPLACE: median imputation
#index_NA <- which(is.na(df$Age))
#df_replace <- df
#df_replace$Age[index_NA] <- median(df$Age, na.rm = TRUE)

#KEEP

















# PLOT AGE & ...
plot(new_df$Age, new_df$Cible, xlab = "Age", ylab = "Cible")
plot(new_df$Age, new_df$Montant_credit, xlab = "Age", ylab = "Montant du crédit")