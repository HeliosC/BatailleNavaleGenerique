WITH BN_Util;   USE BN_Util;
WITH BN_PreGame; USE BN_PreGame;



PACKAGE BN_Game IS


   PROCEDURE CoupP (EssaisP : IN OUT T_Grille; BatC : IN OUT T_Grille; InfoBateauxC : IN T_InfoBateaux; BoolSave : IN OUT Boolean);

   PROCEDURE CoupC (EssaisC : IN OUT T_Grille; BatP : IN OUT T_Grille; InfoBateauxP : IN T_InfoBateaux);

--   FUNCTION CheckWinP RETURN Boolean;

--   FUNCTION CheckWinC RETURN Boolean;





--   TYPE T_SAVE IS RECORD                                                 ---- A partit d'ici, tout est relatif a la sauvegarde pour récupérer des données d'autres classe, et les modifier
--      EssaisP : T_Grille;   BatP : T_Grille; InfoBatP : T_InfoBateaux;
--      EssaisC : T_Grille;   BatC : T_Grille; InfoBatC : T_InfoBateaux;
--      RestP:T_Longueur;   RestC :T_Longueur;
--      Bool : boolean;
--   END RECORD;

--   TYPE T_Longueur IS PRIVATE;
--   --Constructors
--   PROCEDURE InitRestantC;
--   PROCEDURE InitRestantP;
--   --Getters
--   FUNCTION RestantC RETURN T_Longueur;
--   FUNCTION RestantP RETURN T_Longueur;
--   --Setters
--   PROCEDURE LoadRestantC(long:T_Longueur);
--   PROCEDURE LoadRestantP(long:T_Longueur);




--   PROCEDURE SAVE(
--      EssaisP : T_Grille;
--      BatP : T_Grille;
--      InfoBateauxP : T_InfoBateaux;

--      EssaisC : T_Grille;
--      BatC : T_Grille;
--      InfoBateauxC : T_InfoBateaux;

--      RestP: T_Longueur;
--      restC: T_Longueur;

--      Nom   : String);

--   FUNCTION LOAD(Nom: String) return T_SAVE;

   --PRIVATE
      
   --TYPE T_Longueur IS ARRAY(T_Bateau) OF Integer;
   


END BN_Game;

