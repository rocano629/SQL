
CREATE FUNCTION SPLIT_STRING_WITH_INDEX(@STRING VARCHAR(4000),@Delimiter varchar(1))
/*
split input string by delimiter
usage:
SELECT *
FROM SPLIT_STRING_WITH_INDEX('A,B,C',',')

RETURNS TABLE:
[Index],[String]
1      ,A
2      ,B
3      ,C
*/
 RETURNS @Split_values TABLE (
        ind int,
        string varchar(500)
    )
AS
BEGIN


Declare @individual varchar(20) = null
Declare @counter int = 0

WHILE LEN(@STRING) > 0
BEGIN
    IF PATINDEX('%'+@Delimiter+'%', @STRING) > 0
    BEGIN
        SET @individual = SUBSTRING(@STRING,
                                    0,
                                    PATINDEX('%'+@Delimiter+'%', @STRING))
        INSERT @Split_values
		SELECT @counter,@individual

        SET @STRING = SUBSTRING(@STRING,
                                  LEN(@individual + @Delimiter) + 1,
                                  LEN(@STRING))
    END
    ELSE
    BEGIN
        SET @individual = @STRING
        SET @STRING = NULL
        INSERT @Split_values
		SELECT @counter,@individual
    END
	SET @counter = @counter + 1
END


RETURN


END