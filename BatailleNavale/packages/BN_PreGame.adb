WITH Ada.Text_IO ;         USE Ada.Text_IO ;
WITH Aleatoire;   USE Aleatoire;

PACKAGE BODY BN_PreGame IS

   Liste_Longueur: CONSTANT T_Longueur:=(5,4,3,3,2);   --Liste de la longueur des bateaux
   Longueur : Integer;

   Coord0 , Coord: T_Coord;

   Direction : T_Direction;

   Bateaux_RestantsC, Bateaux_RestantsP : T_Longueur := (5,4,3,3,2); --nombre de cases intactes de chaque bateau




-----------
   FUNCTION CheckWinP RETURN Boolean IS
   BEGIN
      RETURN( Bateaux_RestantsP = (0,0,0,0,0) );
   END CheckWinP;


   FUNCTION CheckWinC RETURN Boolean IS
   BEGIN
      RETURN( RestantC = (0,0,0,0,0) );
   END CheckWinC;
-----------------

   FUNCTION Placement_Auto RETURN T_GrillesInit IS

      Bat :T_Grille := (1..10 => ('A'..'J' => ' ') );
      InfoBateaux : T_InfoBateaux:= (1..10 => ('A'..'J' => Croiseur) );
      GrillesInit : T_GrillesInit;



   BEGIN

      FOR Bateau IN Liste_Longueur'RANGE LOOP   --Parcours de la liste des bateaux

         <<RECOMMENCE>> --Des qu'il y a un probleme avec le placement du bateau rentré par le joueur (mauvaise saisie, croisement, sortie du plateau) , on recommence la placement du bateau ici.

         Initialise(1,10);   --Initialise la fonction Random (pour les Integer)


         Coord0 := ( Random , Random);   Coord := Coord0;   -- Le 2e random demande un type T_ord, il retourne un char dans 'A' ... 'J'
                                                            -- On a surchargé cette fonction dans "aleatoire.ads"

         IF Bat(Coord.X,Coord.Y) = '.' THEN   -- Y'a t-il déjà un bateau à ces coordonnées ?
            goto RECOMMENCE;
         ELSE
            Initialise(0,3);
            Direction := T_Direction'Val(Random);   --Tire une des directions (N,O,S,E) énumérés dans T_Direction

         END IF;


         Longueur := Liste_Longueur( Bateau );

         WHILE Longueur > 1 LOOP   --On vérifie que toutes les cases qu'occupera le bateau sont disponibles, et dans la map

            BEGIN

               CASE Direction IS
                  WHEN N => Coord.Y := T_Ord'Val(T_Ord'Pos(Coord.Y) -1);
                  WHEN S => Coord.Y := T_ord'val(T_ord'pos(Coord.Y) +1);
                  WHEN O => Coord.X := Coord.X -1;
                  WHEN E => Coord.X := Coord.X +1;
               END CASE;

            EXCEPTION               -- Si le bateau est sorti de la map
               WHEN OTHERS => goto RECOMMENCE;
            END;

            IF Bat(Coord.X,Coord.Y) = '.' THEN   --Si le bateau en a croisé un autre
                  goto RECOMMENCE;
            END IF;

            Longueur := Longueur - 1;

        END LOOP;

         Ecriture_Bateau(Bat, InfoBateaux, Bateau, Coord0, Direction );   --Si tout est bon, on rempli les grilles du nouveau bateau



      END LOOP;


      GrillesInit.GrilleBat := Bat;
      GrillesInit.InfoBat := InfoBateaux;

      RETURN(GrillesInit);

   END Placement_Auto;


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION Placement_Manuel RETURN T_GrillesInit IS

      Position : String(1..10);
      Nget : Integer;

      Bat :T_Grille := (1..10 => ('A'..'J' => ' ') );

      InfoBateaux : T_InfoBateaux:= (1..10 => ('A'..'J' => Croiseur) );


      GrillesInit : T_grillesinit;

   BEGIN

      FOR Bateau IN Liste_Longueur'RANGE LOOP

         <<RECOMMENCE>> --Des qu'il y a un probleme avec le placement du bateau rentré par le joueur (mauvaise saisie, croisement, sortie du plateau) , on recommence la placement du bateau ici.


         Put_Line("Placez une extremite du "& T_Bateau'Image(Bateau) & " (de taille "& Integer'Image(Liste_Longueur( Bateau )) & ")");
         Get_Line(Position,Nget);


         BEGIN
            Coord0 := ( Integer'Value( Position(2..Nget) ) , Position(1));   Coord := Coord0;
         EXCEPTION                                                            -- la gestion d'erreur permet de recommencer le placement au cas ou la saisie n'est pas conforme
            WHEN OTHERS => Put_Line("Saisie incorrecte");   goto RECOMMENCE;
         END;


         IF Bat(Coord.X,Coord.Y) = '.' THEN
            Put_Line("Cette case est deja prise:");
            goto RECOMMENCE;
         ELSE
            Put_Line("Donnez la direction du "& T_Bateau'Image(Bateau) & " (N, S, E, O)    (ou appuyez sur ENTREE pour replacer l'extremite)");
            Get_Line(Position,Nget);

            BEGIN
               Direction := T_Direction'Value(Position(1..1));
            EXCEPTION
               WHEN OTHERS => IF Nget>0 THEN Put_Line("Saisie incorrecte");  END IF;
                              goto RECOMMENCE;
            END;
         END IF;

         Longueur := Liste_Longueur( Bateau );

         WHILE Longueur > 1 and true LOOP

            BEGIN

               CASE Direction IS
                  WHEN N => Coord.Y := T_Ord'Val(T_Ord'Pos(Coord.Y) -1);
                  WHEN S => Coord.Y := T_ord'val(T_ord'pos(Coord.Y) +1);
                  WHEN O => Coord.X := Coord.X -1;
                  WHEN E => Coord.X := Coord.X +1;
               END CASE;

            EXCEPTION
               WHEN OTHERS => Put_Line("Ce bateau sort de la grille !");   goto RECOMMENCE;
            END;

            IF Bat(Coord.X,Coord.Y) = '.' THEN
                  Put_Line("Ce bateau en croise un autre !");
                  goto RECOMMENCE;
            END IF;

            Longueur := Longueur - 1;

         END LOOP;

         Ecriture_Bateau(Bat, InfoBateaux, Bateau, Coord0, Direction );
         New_Line(30);
         Affichage( (1..10 => ('A'..'J' => ' ') ) ,Bat);

      END LOOP;

      GrillesInit.GrilleBat := Bat;
      GrillesInit.InfoBat := InfoBateaux;

      RETURN(GrillesInit);

   END Placement_Manuel;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE Ecriture_Bateau(Bat: in out T_grille; InfoBateaux : in out T_InfoBateaux; Bateau : T_Bateau; Coord0 : T_Coord; Direction : T_Direction) IS --Remplit les cases occupées par le bateau placé
   BEGIN
      Longueur := Liste_Longueur( Bateau );
      Coord := Coord0;
      Bat(Coord.X,Coord.Y) := '.';
      InfoBateaux(Coord.X,Coord.Y) := Bateau;

      WHILE Longueur > 1 LOOP
         CASE Direction IS
            WHEN N => Coord.Y := T_Ord'Val(T_Ord'Pos(Coord.Y) -1);
            WHEN S => Coord.Y := T_Ord'Val(T_Ord'Pos(Coord.Y) +1);
            WHEN O => Coord.X := Coord.X -1;
            WHEN E => Coord.X := Coord.X +1;
         END CASE;
         Bat(Coord.X,Coord.Y) := '.';
         InfoBateaux(Coord.X,Coord.Y) := Bateau;

         Longueur := Longueur - 1;
      END LOOP;
   END Ecriture_Bateau;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

      FUNCTION GetGrilleBat(Grilles : T_GrillesInit) RETURN T_Grille IS
      BEGIN
         RETURN(Grilles.GrilleBat);
      END GetGrilleBat;

      FUNCTION GetInfoBat(Grilles : T_GrillesInit) RETURN T_InfoBateaux IS
      BEGIN
         RETURN(Grilles.InfoBat);
      END GetInfoBat;



------
   PROCEDURE InitRestantC IS
   BEGIN
      Bateaux_RestantsC:=(5,4,3,3,2);
   END;

   PROCEDURE InitRestantP IS
   BEGIN
      Bateaux_RestantsP:=(5,4,3,3,2);
   END;

   FUNCTION RestantC RETURN T_Longueur IS
   BEGIN
      RETURN Bateaux_RestantsC;
   END;


   FUNCTION RestantP RETURN T_Longueur IS
   BEGIN
      RETURN Bateaux_RestantsP;
   END;

   FUNCTION RestantC(Bat : T_Bateau) RETURN Integer IS
   BEGIN
      RETURN Bateaux_RestantsC(bat);
   END;

   FUNCTION RestantP(Bat : T_Bateau) RETURN Integer IS
   BEGIN
      RETURN Bateaux_RestantsP(bat);
   END;

   PROCEDURE LoadRestantP(Long:T_Longueur) IS
   BEGIN
      Bateaux_RestantsP:=Long;
   END;

   PROCEDURE LoadRestantC(Long:T_Longueur) IS
   BEGIN
      Bateaux_RestantsC:=Long;
   END;

   PROCEDURE DiminueRestantC(Bat : T_Bateau) IS
   BEGIN
      Bateaux_RestantsC(Bat) := Bateaux_RestantsC(Bat) - 1;
   END;

   PROCEDURE DiminueRestantP(Bat : T_Bateau) IS
   BEGIN
      Bateaux_RestantsP(Bat) := Bateaux_RestantsP(Bat) - 1;
   END;

------

   --Getters
   FUNCTION GetX(c : T_Coord) RETURN T_Abs IS
   BEGIN
      RETURN(c.X);
   END;

   FUNCTION GetY(C : T_Coord) RETURN T_Ord IS
   BEGIN
      RETURN(C.Y);
   END;

   --Setters
   FUNCTION SetCoord(X : T_Abs;Y : T_Ord) RETURN T_Coord IS
      C : T_Coord;
   BEGIN
      C.X := X;
      C.Y := Y;
      RETURN(C);
   END;
   FUNCTION SetX(C : T_Coord;X : T_Abs) RETURN T_Coord IS
      C0 : T_Coord := C;
   BEGIN
      C0.X := X;
      RETURN(C0);
   END;
   FUNCTION SetY(C : T_Coord;Y : T_Ord) RETURN T_Coord IS
      C0 : T_Coord := C;
   BEGIN
      C0.Y := Y;
      RETURN(C0);
   END;


----------------------------------------------------------------------------------

   FUNCTION GetInfoBateaux(I : T_InfoBateaux ; C : T_Coord) RETURN T_Bateau IS
   BEGIN
      RETURN I( C.X, C.Y );
   END;


END BN_PreGame ;