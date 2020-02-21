WITH Text_Io;   USE Text_Io;
WITH Aleatoire;   USE Aleatoire;
WITH Ada.Strings.Unbounded;   USE Ada.Strings.Unbounded;
WITH BN_PreGame; USE BN_PreGame;


PACKAGE BODY BN_Game IS

--   Bateaux_RestantsC, Bateaux_RestantsP : T_Longueur := (5,4,3,3,2); --nombre de cases intactes de chaque bateau

--   FUNCTION CheckWinP RETURN Boolean IS
--   BEGIN
--      RETURN( Bateaux_RestantsP = (0,0,0,0,0) );
--   END CheckWinP;


--   FUNCTION CheckWinC RETURN Boolean IS
--   BEGIN
--      RETURN( RestantC = (0,0,0,0,0) );
--   END CheckWinC;


   PROCEDURE CoupP (EssaisP : IN OUT T_Grille; BatC : IN OUT T_Grille; InfoBateauxC : in T_InfoBateaux; BoolSave : IN OUT Boolean) IS

      Position : String(1..10);   --Coordonnes entrees par le joueur

      Nget : Integer;

      Bool : Boolean := False;

      Coord : T_Coord;

   BEGIN

      WHILE NOT Bool LOOP
         Bool := True;   --Des qu'il y a un probleme avec le coup joué par le joueur (mauvaise saisie, coup deja joué) , ce booleen passe a False

         Put_Line("Jouez un coup");
         Get_Line(Position,Nget);

         IF Nget>=4 AND THEN Position(1..4)="SAVE" THEN
            BoolSave :=True;
            exit;
         END IF;



         BEGIN
            --Coord := ( Integer'Value( Position(2..Nget) ) , Position(1));
            Coord := SetCoord( Integer'Value( Position(2..Nget) ) , Position(1));
         EXCEPTION                                                            -- la gestion d'erreur permet de recommencer le placement au cas ou la saisie n'est pas conforme
            WHEN OTHERS => Put_Line("Saisie incorrecte");   Bool := False;
         END;


         IF Bool THEN
         --IF T_Etat'Pos( EssaisP(GetX(coord),GetY(coord)) ) > 1 THEN
         IF T_Etat'Pos( EssaisP(GetX(Coord),GetY(Coord)) ) > 1 THEN
            Put_Line("Ce coup a deja ete joue");
            Bool := False;
         ELSE
            New_Line(50);
            --Put_Line("Vous avez joue en " & T_ord'image(GetY(coord))(2) & T_abs'image(GetX(coord)) & " :");
            Put_Line("Vous avez joue en " & T_ord'image(GetY(coord))(2) & T_abs'image(GetX(coord)) & " :");

            IF BatC(GetX(coord),GetY(coord)) = '.' THEN   --Cas d'une touche
                  --Bateaux_RestantsP(InfoBateauxC(GetX(coord),GetY(coord))) := Bateaux_RestantsP(InfoBateauxC(GetX(coord),GetY(coord))) - 1; --On récupre le bateau touché pour diminuer son nombre de cases intactes
                  DiminueRestantP( GetInfoBateaux(InfoBateauxC, coord) ); --On récupre le bateau touché pour diminuer son nombre de cases intactes

               IF RestantP( GetInfoBateaux(InfoBateauxC, coord) ) = 0 THEN --Si plus aucune case n'est intacte pour le bateau touché, affiche "coulé !"
                     Put_Line("Coule !");
               ELSE
                  Put_Line("Touche !");
               END IF;
               BatC(GetX(coord),GetY(coord)) := 'X';      --Ecriture du coup dans les grilles
               EssaisP(GetX(coord),GetY(coord)) := 'X';
            ELSE
               Put_Line("Rate !");
               BatC(GetX(coord),GetY(coord)) := 'O';
               EssaisP(GetX(coord),GetY(coord)) := 'O';

            END IF;


            END IF; END IF;



      END LOOP;



   END CoupP;

--------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE CoupC (essaisC : in out T_grille; batP : in out T_grille; InfoBateauxP : in T_InfoBateaux) is

      Bool : Boolean := False;

      Coord : T_Coord;

   BEGIN

      WHILE NOT Bool LOOP
      Bool := True;

         Initialise(1,10);
--         Coord := ( Random , Random );
         Coord := SetCoord( Random , Random );



         IF T_Etat'Pos( EssaisC(GetX(coord),GetY(coord)) ) > 1 THEN
            Bool := False;
         ELSE
            New_Line(50);
            Put_Line("L'ordinateur joue en " & T_ord'image(GetY(coord))(2) & T_abs'image(GetX(coord)) & " :");
            IF BatP(GetX(coord),GetY(coord)) = '.' THEN
               --Bateaux_RestantsC(InfoBateauxP(GetX(Coord),GetY(Coord))) := Bateaux_RestantsC(InfoBateauxP(GetX(Coord),GetY(Coord))) - 1;
               DiminueRestantC( GetInfoBateaux(InfoBateauxP, coord) );

               IF RestantC( GetInfoBateaux(InfoBateauxP, coord) )= 0 THEN
                     Put_Line("Coule !");
               ELSE
                  Put_Line("Touche !");
               END IF;
               BatP(GetX(coord),GetY(coord)) := 'X';
               EssaisC(GetX(coord),GetY(coord)) := 'X';
            ELSE
               Put_Line("Rate !");
               BatP(GetX(coord),GetY(coord)) := 'O';
               EssaisC(GetX(coord),GetY(coord)) := 'O';

            END IF;


            END IF;


      END LOOP;

   END CoupC;



--   PROCEDURE InitRestantC IS
--   BEGIN
--      Bateaux_RestantsC=(5,4,3,3,2);
--   END;
--
--   PROCEDURE InitRestantP IS
--   BEGIN
--      Bateaux_RestantsP=(5,4,3,3,2);
--   END;

--   FUNCTION RestantC RETURN T_Longueur IS
--   BEGIN
--      RETURN Bateaux_RestantsC;
--   END;


--   FUNCTION RestantP RETURN T_Longueur IS
--   BEGIN
--      RETURN Bateaux_RestantsP;
--   END;

--   PROCEDURE LoadRestantP(Long:T_Longueur) IS
--   BEGIN
--      Bateaux_RestantsP:=Long;
--   END;

--   PROCEDURE LoadRestantC(Long:T_Longueur) IS
--   BEGIN
--      Bateaux_RestantsC:=Long;
--   END;

   --------------------------------------------------------------------------------------------------------------------------------
   ---------------------------SAUVEGARDE------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------

--   PROCEDURE SAVE(
--      EssaisP : T_Grille;
--      BatP : T_Grille;
--      InfoBateauxP : T_InfoBateaux;

--      EssaisC : T_Grille;
--      BatC : T_Grille;
--      InfoBateauxC : T_InfoBateaux;

--      RestP: T_Longueur;
--      RestC: T_Longueur;

--      Nom   : String      ) IS

--      F : File_Type;
--   BEGIN
--      Create(F,Name => Nom&".save");

--      FOR J IN EssaisP 'RANGE(2) LOOP
--         FOR I IN EssaisP 'RANGE LOOP
--            put(F,T_Etat'Image( EssaisP(I,J) )(2));
--         END LOOP;
--         new_line(F);
--      END LOOP;
--      FOR J IN EssaisP 'RANGE(2) LOOP
--         FOR I IN EssaisP 'RANGE LOOP
--            put(F,T_Etat'Image( BatP (I,J) )(2));
--         END LOOP;
--         new_line(F);
--      END LOOP;
--      FOR J IN EssaisP 'RANGE(2) LOOP
--         FOR I IN EssaisP 'RANGE LOOP
--            put(F,Integer'Image( T_Bateau'Pos(InfoBateauxP(I,J)) ));
--         END LOOP;
--         new_line(F);
--      END LOOP;


--      FOR J IN EssaisP 'RANGE(2) LOOP
--         FOR I IN EssaisP 'RANGE LOOP
--            put(F,T_Etat'Image( EssaisC(I,J) )(2));
--         END LOOP;
--         new_line(F);
--      END LOOP;
--      FOR J IN EssaisP 'RANGE(2) LOOP
--         FOR I IN EssaisP 'RANGE LOOP
--            put(F,T_Etat'Image( BatC (I,J) )(2));
--         END LOOP;
--         new_line(F);
--      END LOOP;
--      FOR J IN EssaisP 'RANGE(2) LOOP
--         FOR I IN EssaisP 'RANGE LOOP
--            put(F,Integer'Image( T_Bateau'Pos(InfoBateauxC(I,J)) ));
--         END LOOP;
--         new_line(F);
--      END LOOP;


--      FOR I IN RestP'RANGE LOOP
--         put(F, integer'image(RestP(I)));
--      END LOOP;

--      new_line(F);

--      FOR I IN RestC'RANGE LOOP
--         put(F, integer'image(RestC(I)));
--      END LOOP;


--      close(F);

--   END Save;

----------------------------------------

--   FUNCTION LOAD(Nom: String) RETURN T_SAVE IS
--      F : File_Type;

--      EssaisP,EssaisC:T_Grille:= (1..10 => ('A'..'J' => ' ') );
--      BatP,BatC:T_Grille:= (1..10 => ('A'..'J' => ' ') );
--      InfoBateauxP,InfoBateauxC:T_InfoBateaux;

--      restP,RestC:T_longueur;


--      Txt:Unbounded_String;


--      Sav : T_SAVE;
--


--   BEGIN
--      Sav.Bool:=False;
--
--      BEGIN
--         Open(F, In_File, Name => Nom&".save");
--      EXCEPTION
--         WHEN OTHERS => Put_Line("Fichier Introuvable !");   sav.Bool:=True;   return sav;
--      END;




--     FOR J IN T_Ord'RANGE LOOP

--        Txt :=To_Unbounded_String(Get_Line(F));


--        FOR I IN T_Abs'RANGE LOOP

--   EssaisP(I,J):= T_Etat'Value( "'"&To_String(Txt)(I..I)&"'" );

--        END LOOP;

--     END LOOP;

--     FOR J IN T_Ord'RANGE LOOP

--        Txt :=To_Unbounded_String(Get_Line(F));


--        FOR I IN T_Abs'RANGE LOOP


--   BatP(I,J):= T_Etat'Value( "'"&To_String(Txt)(I..I)&"'" );


--        END LOOP;

--     END LOOP;

--     FOR J IN T_Ord'RANGE LOOP

--        Txt :=To_Unbounded_String(Get_Line(F));


--        FOR I IN T_Abs'RANGE LOOP

--   InfoBateauxP(I,J):= T_Bateau'Val( Integer'Value(To_String(Txt)(2*I..2*I)) );


--        END LOOP;

--END LOOP;



--     FOR J IN T_Ord'RANGE LOOP

--        Txt :=To_Unbounded_String(Get_Line(F));


--        FOR I IN T_Abs'RANGE LOOP

--   EssaisC(I,J):= T_Etat'Value( "'"&To_String(Txt)(I..I)&"'" );


--        END LOOP;

--     END LOOP;

--     FOR J IN T_Ord'RANGE LOOP

--        Txt :=To_Unbounded_String(Get_Line(F));


--        FOR I IN T_Abs'RANGE LOOP

--   BatC(I,J):= T_Etat'Value( "'"&To_String(Txt)(I..I)&"'" );


--        END LOOP;

--     END LOOP;

--     FOR J IN T_Ord'RANGE LOOP

--        Txt :=To_Unbounded_String(Get_Line(F));


--        FOR I IN T_Abs'RANGE LOOP

--   InfoBateauxC(I,J):= T_Bateau'Val( Integer'Value(To_String(Txt)(2*I..2*I)) );



--        END LOOP;

--END LOOP;





--Txt :=To_Unbounded_String(Get_Line(F));
--FOR I IN 1..5 LOOP
--   RestP(T_Bateau'Val(I-1)):=Integer'Value(To_String(Txt)(2*I..2*I));

--END LOOP;

--Txt :=To_Unbounded_String(Get_Line(F));
--FOR I IN 1..5 LOOP
--   RestC(T_bateau'val(I-1)):=Integer'Value(To_String(Txt)(2*I..2*I));
--END LOOP;


--Close(F);

--Sav.Essaisp:=Essaisp;
--sav.batp:=batp;
--Sav.Infobatp:=Infobateauxp;

--Sav.Essaisc:=Essaisc;
--sav.batc:=batc;
--Sav.Infobatc:=Infobateauxc;

--sav.restP:=Bateaux_RestantsP;
--sav.restC:=Bateaux_RestantsC;

--      RETURN(sav);

--   END LOAD;




END BN_Game;

