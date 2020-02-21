WITH Text_Io;   USE Text_Io;
WITH BN_Util;   USE BN_Util;
WITH BN_PreGame;   USE BN_PreGame;
WITH BN_Game;   USE BN_Game;

PROCEDURE Main IS

   PAUSE: String(1..0);                     -- Permet de faire un pause quiattend un "ENTREE" de l'utilisateur

   StrGet: String(1..30);
   Nget : Integer;                          -- Longueur de string "StrGet"

   EssaisP, EssaisC :T_Grille ;             --grilles des coups joués (P=Player, C=Computer)
   BatP, BatC       :T_Grille ;                                 --grilles des bateaux

   InfoBateauxP, InfoBateauxC : T_InfoBateaux;                  -- associe a chaque coordonnées la bateux (ou le vide) qui s'y trouve

   GrillesInitP, GrillesInitC : T_GrillesInit;                  -- GrillesInitP est un record de BatP et InfoBateauxP (utilise pour return les 2 d'un coup dans la fonction de Placement des bateaux)

   BoolSave: Boolean:= False;

   --sav:T_save;


BEGIN


   FichierExecutable;   --Permet de renommer l'exécutable "BatailleNavale.exe"

   InitRestantP;
   InitRestantC;

   <<DEBUT>>

      EssaisP := (1..10 => ('A'..'J' => ' ') );
      EssaisC := (1..10 => ('A'..'J' => ' ') );   --Initialisation des grilles vides

--   Put_Line("Pour charger une sauvegarde, ecrivez le nom du fichier (sans l'extension)"); Put_Line("Pour une nouvelle partie, faites ENTREE");   New_Line;
   Put_Line("Pour une nouvelle partie, faites ENTREE");   New_Line;
   Get_Line(StrGet,Nget);



   IF Nget = 0 THEN
      Put_Line("Placement des bateaux : ");      Put_Line("1 : MANUEL");      Put_Line("2 : ALEATOIRE");   New_Line;
      Get_Line(StrGet,Nget);  -- L'utilisateur choisit le mode de placement de ses bateaux qu'il préfère





      New_Line(50);

      IF ( Nget >= 1 and StrGet(1) = '1' ) or ( Nget >= 3 and StrGet(1..3) = "MAN" ) THEN --cas du placement manuel
         Affichage(EssaisP, EssaisP);
         GrillesInitP := Placement_Manuel;
      ELSE                                   --cas du placement aleatoire
         GrillesInitP := Placement_Auto;
         END IF;


      BatP := GetGrilleBat( GrillesInitP );         --GrillesInitP.GrilleBat;
      InfoBateauxP := GetInfoBat( GrillesInitP );   --GrillesInitP.InfoBat;

      GrillesInitC := Placement_Auto;   -- Placement aleatoire des bateaux de l'ordinateur
      BatC := GetGrilleBat( GrillesInitC );         --GrillesInitC.GrilleBat;
      InfoBateauxC := GetInfoBat( GrillesInitP );   --GrillesInitC.InfoBat;

      Put_Line("PLACEMENTS REUSSIS");

   ELSE   --chargement d'une sauvegarde
      --Sav:=LOAD(Strget(1..Nget));

--      IF sav.Bool THEN
--         New_Line(1);
--         GOTO DEBUT;
--      END IF;


--      BatP:=Sav.Batp;
--      EssaisP:=Sav.Essaisp;
--      InfoBateauxP:=Sav.infobatp;

--      BatC:=Sav.BatC;
--      EssaisC:=Sav.EssaisC;
--      InfoBateauxC:=Sav.InfobatC;

--      LoadRestantC(sav.restC);
--      LoadRestantC(Sav.RestP);


--      put_line("CHARGEMENT REUSSI");

goto DEBUT;

   END IF;

   Affichage(EssaisP, BatP);



   FOR I IN 1..100 LOOP   --Boucle de jeu (grille de 10x10, donc on joue 100 coups maximum)

      CoupP(EssaisP, BatC, InfoBateauxC,BoolSave);   --Le joueur joue un coup

      IF BoolSave THEN   --Si le joueur souhaite sauvegarder en ayany ecrit "SAVE"
         Put_line("Nom du fichier de sauvegarde (sans extension) :");
         Get_Line(StrGet,Nget);
         --SAVE(EssaisP, BatP, InfoBateauxP, EssaisC, BatC, InfoBateauxC, RestantC, RestantP, StrGet(1..Nget));
         New_Line;
         Put_Line("SAUVEGARDE REUSSIE");
         skip_line;   Get(PAUSE);
         exit;
      END IF;


      Affichage(EssaisP,BatP);              --Affichage des grilles du joueur

         IF CheckWinP THEN          --Le joueur a t-il gagné ?
            --VICTOIRE;               --Si oui, affiche l'écran de victoire et termine le programme
            EXIT;
         END IF;


      Put_Line("(APPUYER SUR ENTREE)");   Get(PAUSE);   Skip_Line;

      CoupC(EssaisC, BatP, InfoBateauxP);   --l'ORDINATEUR joue un coup
         Affichage(EssaisP,BatP);         --Affichage des grilles du JOUEUR

         IF CheckWinC THEN         --Le joueur a t-il gagné ?
            --DEFAITE;               --Si oui, affiche l'écran de défaite et termine le programme
            exit;
         END IF;

   END LOOP;

   IF NOT BoolSave THEN

      Put("Voulez-vous rejouer ?   ");   Put("1:OUI   ");   Put_Line("2:NON");   New_Line;
      Get_Line(StrGet,Nget);

      IF  Nget >= 1 AND (StrGet(1) = '1' OR StrGet(1) = 'O' ) THEN
         New_Line(100);
         GOTO DEBUT;
      END IF;

   END IF;


END Main;
