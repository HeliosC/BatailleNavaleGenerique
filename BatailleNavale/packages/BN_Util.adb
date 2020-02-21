WITH Ada.Text_IO ;            USE Ada.Text_IO ;
--WITH ada.Directories;         USE Ada.Directories;
--WITH ADA.EXCEPTIONS;          USE Ada.Exceptions;
WITH ADA.IO_EXCEPTIONS;       USE Ada.IO_Exceptions;
WITH Ada.Strings.Unbounded;   USE Ada.Strings.Unbounded;

PACKAGE BODY BN_Util IS

   Procedure Affichage(essais : T_grille; bat : T_Grille) is
   BEGIN
      New_Line(3);            --Affichage des informations qu'a le joueur que la grille de l'ordinateur
      FOR I IN bat'RANGE LOOP --Affiche (A B C D E F G H I J) sur la  1ere ligne
         Put("  "&Integer'Image(I));
      END LOOP;
      FOR J IN bat'RANGE(2) LOOP
         New_line(2);
         Put(Character'image(J)(2));
         FOR I IN bat'RANGE LOOP
            Put("  "& T_Etat'Image( essais(I,J) )(2) &" ");
         END LOOP ;
      END LOOP ;

      New_Line(5);            --Affichage des bateaux du joueur et des tirs ennemis
      FOR I IN bat'RANGE LOOP
         Put("  "&Integer'Image(I));
      END LOOP;
      FOR J IN bat'RANGE(2) LOOP
         New_line(2);
         Put(Character'image(J)(2));
         FOR I IN bat'RANGE LOOP
            Put("  "& T_Etat'Image( bat(I,J) )(2) &" ");
         END LOOP ;
      END LOOP ;
      New_Line(5);
   END Affichage ;





   PROCEDURE FichierExecutable IS
      MonFichier : File_Type;
   BEGIN

   BEGIN
      Open(MonFichier,Out_File,"BatailleNavale.exe");
      Delete(MonFichier);
   EXCEPTION   WHEN OTHERS =>  Put("");   END;

   --Rename("main.exe","BatailleNavale.exe");
   EXCEPTION  WHEN OTHERS =>   Put("");

   END FichierExecutable;





--   PROCEDURE VICTOIRE IS
--      F : File_Type;
--      Txt : Unbounded_String;
--      I:Integer;

--   BEGIN

--      New_line(100);

--      BEGIN
--         open(F,in_file,"victoire.txt");

--         I:=1;
--         while not end_of_line(F) and I<100 loop
--            Txt :=To_Unbounded_String(Get_Line(F));

--            IF to_String(Txt)'last > 80 THEN   Put_Line(To_String(Txt)(1..75));
--            ELSE Put_Line(To_String(Txt));
--            END IF;

--            I:=I+1;
--         end loop;

--         Close(F);

--      EXCEPTION
--         WHEN OTHERS => Put("");
--      END;

--      New_line;
--      Put_Line("VOUS AVEZ GAGNE! ");
--      New_line;

--   END VICTOIRE;





--   PROCEDURE DEFAITE IS
--      F : File_Type;
--      Txt: Unbounded_String;
--      I:Integer;

--   BEGIN

--      New_Line(100);

--      BEGIN
--         Open(F,In_File,"defaite.txt");

--         I:=1;
--         while not end_of_line(F) and I<100 loop
--            Txt :=To_Unbounded_String(Get_Line(F));

--            IF to_String(Txt)'last > 76 THEN   Put_Line(To_String(Txt)(1..75));
--            ELSE Put_Line(To_String(Txt));
--            END IF;

--            I:=I+1;
--         end loop;

--         Close(F);

--      EXCEPTION
--         WHEN OTHERS => Put("");
--      END;

--      New_line;
--      Put_Line("VOUS AVEZ PERDU ! ");
--      New_line;

--   END DEFAITE;




END BN_Util ;