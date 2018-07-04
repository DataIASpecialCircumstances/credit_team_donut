install_library <- function()
  #########################################################################
#####                 Importation Package                           #####
#install.packages('Hmisc')
#install.packages('ggplot2')
#install.packages('questionr')
#install.packages('maptools')
library("dplyr")
library('maptools')
library("questionr")
#### test

telechargement_data <- function()
  #########################################################################
#####                 Téléchargement donnée                        #####
column_name = c("Comptes", "Duree_credit", "Historique_credit", "Objet_credit", "Montant_credit", "Epargne", "Anciennete_emploi", "taux_effort", "Situation_familiale", "Garanties", "Anciennete_domicile", "Biens", "Age", "Autres_credits", "Statut_domicile", "Nb_credits", "Type_emploi", "Nb_pers_charge", "Telephone", "Etranger", "Cible")

#Q : Importer le fichier credit.txt dans une variable ?
credit <- read.table('data/credit.txt', sep=' ', col.names = column_name )
class(credit) #data frame

# Q : Importer le fichier au format csv dans une variable ?
#csv <- read.csv('chemain/nom_fichier.csv', sep=',')

pretraitement <- function()
  ########################################################################
#####                 Prétraitement des données                    #####
# Q : Observer une premiere fois les données
head(credit)

summary(credit)
#si on a importer la lib questionr
describe(credit)

# Cliquer sur Tools > Addins > numeric... >
#my_structure <- str(credit)
#dplyr::select_if(credit, is.numeric)
nom_col_bin <- c('Nb_pers_charge', 'Téléphone', "Etranger", "Cible")

nom_col_numerique <- c('Duree_credit', 'Montant_credit', "Age", "Nb_credits")

nom_col_nominal <- c("Historique_credit", "Objet_credit", "Situation_familiale", "Garanties", "Biens", "Autres_credits", "Statut_domicile", "Type_emploi")

nom_col_categoriel <- c("Comptes", "Epargne", "Anciennete_emploi", "Anciennete_domicile", "taux_effort")

hist(credit$Age) 
plot(credit$Etranger, credit$Cible)
plot(credit$Garanties, credit$Cible)

split_data <- function()   
  ########################################################################
#####              Split des données Train/Test                    #####




mes_models <- function()
  ########################################################################
#####                    Entrainement (model)                      #####
#Regression logistique sur var cible


print("Fin")