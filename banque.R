# les dataframe en R
# creer un df 
library(ggplot2)
install.packages("ggplot2")
library(ggthemes)
install.packages(ggthemes)
#caret equivalent de sickitlearn
df <- read.csv('shampoo-sales.csv', sep = "," )
# lire un fichier .txt et ajouter le nom #des colonnes 
####### load data 
credit <- read.table('credit.txt', col.names = c("Comptes", "Duree_credit", "Historique_credit", "Objet_credit", "Montant_credit", "Epargne", "Anciennete_emploi", "taux_effort", "Situation_familiale", "Garanties", "Anciennete_domicile", "Biens", "Age", "Autres_credits", "Statut_domicile", "Nb_credits", "Type_emploi", "Nb_pers_charge", "Telephone", "Etranger", "Cible"))
# visualisation  et analyse des données 
summary(credit)
colnames(credit)# show df columns names
credit
getwd()
#les fonctions de base sur python 
describe(credit)
getwd()
# visualisation 

credit.columns
pD1 <- ggplot(credit, aes(x=credit$Duree_credit, y=credit$Cible))
