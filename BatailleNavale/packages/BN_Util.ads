PACKAGE BN_Util IS

   SUBTYPE T_abs IS Integer RANGE 1..10;
   SUBTYPE T_Ord IS Character RANGE 'A'..'J';



   TYPE T_Etat IS (' ','.','O','X');   -- ' ' : case vierge
                                       -- '.' : case bateau non touch�e
                                       -- 'X' : case bateau touch�e
                                       -- 'O' : tire dans l'eau

   TYPE T_Grille IS ARRAY(T_Abs,T_Ord) OF T_Etat;


   TYPE T_InfoBateaux IS PRIVATE;
   --Getters
   FUNCTION GetInfoBateaux(I : T_InfoBateaux ; C : T_Coord) RETURN T_Bateau;


   PROCEDURE Affichage(Essais : T_Grille; Bat : T_Grille);

   --PROCEDURE VICTOIRE;

   --PROCEDURE DEFAITE;

   PROCEDURE FichierExecutable;


END BN_Util ;

