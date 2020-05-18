P = LOAD '$P' USING PigStorage(',') AS (red , green , blue);
pixel = FOREACH P GENERATE TOTUPLE (1,red),(2,green),(3,blue);
intensity_keys = FOREACH pixel GENERATE FLATTEN( TOBAG ($0,$1,$2));
grouped_intensity = GROUP intensity_keys by ($0 , $1);
result = FOREACH grouped_intensity GENERATE FLATTEN(group), COUNT (intensity_keys);
STORE result into '$O' using PigStorage ('\t');
