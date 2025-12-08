%sql
CREATE OR REPLACE FUNCTION fetch_br(
    status_id INT
)
RETURNS TABLE
RETURN (
SELECT

ALTER FUNCTION moon_gold.fn_splitstrings
    (
       List as string,
       Delimiter as string
    )
    WITH SCHEMABINDiNG
    AS
       (  
          SELECT Item = y.i.value('(./text())[1]', 'nvarchar(4000)')
          FROM 
          ( 
            SELECT x = CONVERT(XML, '<i>' 
              + REPLACE(@List, @Delimiter, '</i><i>') 
              + '</i>').query('.')
          ) AS a CROSS APPLY x.nodes('i') AS y(i)
       );

			Select * from SCHEMABINDiNG
