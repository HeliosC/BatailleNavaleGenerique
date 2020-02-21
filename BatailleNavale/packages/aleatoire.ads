package Aleatoire is
    SUBTYPE Valeur_Reelle_Aleatoire IS FLOAT RANGE 0.0 .. 1.0 ;
    procedure Initialise (Minimum : INTEGER := 1 ; 
			  Maximum : INTEGER := 10);
    function Random RETURN Valeur_Reelle_Aleatoire ;
    FUNCTION Random RETURN INTEGER ;
    FUNCTION Random RETURN character;
    

    TYPE T_Char is array(1..10) of Character;


end Aleatoire;
