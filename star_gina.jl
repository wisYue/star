using PyCall,PyPlot,LsqFit,Images,LinearAlgebra,StatsBase,Statistics
using CSV,DataFrames
@pyimport numpy as np

function getstar(RA,Dec,r,pa,RA_min,RA_max,Dec_min,Dec_max)
    RA[RA.<RA_min].=NaN;
    RA[RA.>RA_max].=NaN;
    Dec[Dec.<Dec_min].=NaN;
    Dec[Dec.>Dec_max].=NaN;
    RA[isnan.(Dec)].=NaN;
    Dec[isnan.(RA)].=NaN;
    r[isnan.(RA)].=1e10;
    pa[isnan.(RA)].=1e10;
    return RA[.~isnan.(RA)], Dec[.~isnan.(Dec)], r[r.!=1e10], pa[pa.!=1e10]
end

# Replace "example.csv" with the path to your actual CSV file
df = CSV.read("d:/project/star/Unique_Source_Pol_Distance_Table.csv", DataFrame);

RA = df[:,3];
Dec = df[:,4];
r = df[:,14];
pa = df[:,12];

pa[pa.<0].+=180;

RA_min=67.5;
RA_max=68.2;
Dec_min=17.7;
Dec_max=18.5;

RAa, Deca, ra, paa=getstar(copy(RA),copy(Dec),copy(r),copy(pa),RA_min,RA_max,Dec_min,Dec_max);

figure(tight_layout="true")
scatter(ra[.~isnan.(paa)],paa[.~isnan.(paa)])
semilogx()
xlim(1e1,1e4)
ylim(0,180)

