# -*- coding: utf-8 -*-
"""
Created on Thu Jun 28 15:39:18 2018
@author: audrey roumieux
Projet:
Description:
"""
import numpy as np
import pandas as pd

#%%
# 1 - Chargement des données
column_name = ["Comptes", "Duree_credit", "Historique_credit", "Objet_credit", "Montant_credit", "Epargne", "Anciennete_emploi", "taux_effort", "Situation_familiale", "Garanties", "Anciennete_domicile", "Biens", "Age", "Autres_credits", "Statut_domicile", "Nb_credits", "Type_emploi", "Nb_pers_charge", "Telephone", "Etranger", "Cible"]

df = pd.read_csv('.\Sayf_R\data\credit.txt', sep = ' ', names = column_name)
# df.columns = column_name


#%%
# 2 - Prétraitement des données
df.head()

print(np.shape(df))

#visualisation des données
df.info()     # n'existe pas en R, on ne peut pas recupere les information fournie
df.describe() # ne marche que sur les colonnes numerique

df.isna()

#%%
# 4 - Split des données Train/Test


#%%
# 5 - Entrainement model