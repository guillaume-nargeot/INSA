/* % Gestion de configuration
 * Creation : 25 mars 98
 * Auteur : M.J. Pedrono
 * Modifications : 
 * Derniere modification : 
 *
 */

/*
 * %Module
 *   Nom            : trinaif
 *   Nom du fichier : trinaif.c
 *                  
 *
 *   Fonctions de ce module :
 *  		void tri_naif (int t[], int taille)
 *		     trie le tableau d'entiers t[0..taille-1]   
 */ 
 
/* 
 * %Fichiers include systeme
 */


/* 
 * %Fichiers include de l'application
*/
#include "service.h" 
#include "trinaif.h"
#include <time.h>
#include <stdio.h>

typedef enum {false=0,true=1} bool;

/*
 * %Fonction globale
 * Nom : tri_naif
 * Definition : trie le tableau d'entiers t[0..taille-1]
 * Argument : int t[],int taille ; le tableau t est modifie
 * Resultat : void
 * Variables globales utilisees 
 * Fonctions appelees : echanger 
 * Fonctions appelantes : main(princ.c)
 * Erreur detectee : 
 * Commentaires :  
 * Creation              : 
 * Auteur/Origine        : 
 * Modifications         :
 * Derniere modification :
 *		     
 */
 

void tri_naif(int t[], int taille)
{ 
    int i;
    clock_t d=clock();
    
    bool fin=false;
    
    while(!fin){
        fin=true;
        
        for(i=0;i<taille-1;i++){
            if(t[i]>t[i+1]){
                echanger(&t[i],&t[i+1]);
                fin=false;      
            }  
        }
    }    
    
    printf("Duree du tri_naif : %e \n",(double)(clock()-d));

}/* tri_naif */

 
