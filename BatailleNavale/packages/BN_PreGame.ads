WITH BN_Util;   USE BN_Util;

PACKAGE BN_PreGame IS

   TYPE T_Bateau IS PRIVATE;

   TYPE T_Direction IS PRIVATE;

   TYPE T_Longueur IS PRIVATE;
   --Constructors
   PROCEDURE InitRestantC;
   PROCEDURE InitRestantP;
   --Getters
   FUNCTION RestantC RETURN T_Longueur;
   FUNCTION RestantP RETURN T_Longueur;
   FUNCTION RestantC(bat : T_Bateau) RETURN Integer;
   FUNCTION RestantP(bat : T_Bateau) RETURN Integer;
   --Setters
   PROCEDURE LoadRestantC(long:T_Longueur);
   PROCEDURE LoadRestantP(Long:T_Longueur);
   PROCEDURE DiminueRestantC(bat : T_Bateau);
   PROCEDURE DiminueRestantP(bat : T_Bateau);

   --CheckWin
   FUNCTION CheckWinP RETURN Boolean;
   FUNCTION CheckWinC RETURN Boolean;


   TYPE T_Coord IS PRIVATE;
   --Getters
   FUNCTION GetX(c : T_Coord) RETURN T_Abs;
   FUNCTION GetY(c : T_Coord) RETURN T_Ord;
   --Setters
   FUNCTION SetCoord(x : T_Abs;y : T_Ord) RETURN T_Coord;
   FUNCTION SetX(C : T_Coord; X : T_Abs) RETURN T_Coord;
   FUNCTION SetY(C : T_Coord; y : T_Ord) RETURN T_Coord;


--   TYPE T_InfoBateaux IS PRIVATE;
--   --Getters
--   FUNCTION GetInfoBateaux(I : T_InfoBateaux ; C : T_Coord) RETURN T_Bateau;

   TYPE T_GrillesInit IS PRIVATE;
   --Constructors
   FUNCTION Placement_Manuel RETURN T_GrillesInit ;
   FUNCTION Placement_Auto RETURN T_GrillesInit;
   --Getters
   FUNCTION GetGrilleBat(grilles : T_GrillesInit) return T_Grille;
   FUNCTION GetInfoBat(grilles : T_GrillesInit) return T_InfoBateaux;


   PROCEDURE Ecriture_Bateau(Bat: IN OUT T_Grille; InfoBateaux : IN OUT T_InfoBateaux; Bateau : T_Bateau; Coord0 : T_Coord; Direction : T_Direction);






   PRIVATE

   TYPE T_Bateau IS (Porte_Avions,Croiseur,Contre_Torpilleur,Sous_Marin,Torpilleur);

   TYPE T_Longueur IS ARRAY(T_Bateau) OF Integer;

   TYPE T_Direction IS (N,O,S,E);

   TYPE T_Coord IS RECORD   X: T_Abs;   Y: T_Ord;   END RECORD;

   TYPE T_InfoBateaux IS ARRAY(T_Abs,T_Ord) OF T_Bateau;

   TYPE T_GrillesInit IS RECORD GrilleBat : T_Grille; InfoBat : T_InfoBateaux; END RECORD;

END BN_PreGame ;

