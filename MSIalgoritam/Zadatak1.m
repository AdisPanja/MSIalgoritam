%unos impedansi%
z12 = 0.05+j*0.1;
z13 = 0.025+j*0.03;
z23 = 0.02+j*0.02;
z24 = 0.06 -j*0.1;
z45 = 0.1;
z35 = 0.54+ j*0.1;
z56 = 0.08;
z50 = 0.5;

%formiranje vektora admitansi%
y = [{1/z23,'2','3'}; {1/z12 , '1', '2'}; {1/z13 , '1','3'}; {1/z24 , '2','4'};
{1/z45 , '4','5'}; {1/z35 , '3','5'}; {1/z56, '5', '6'}; {1/ z50 , '5','0'}];

%unos parametara za SLACK, PQ i PV cvorove%
v1 = 1/sqrt(3)+j*sqrt(2/3);
p2 = -3;
v2 = 1.02;
p3 = -1.5;
v3 = 0.9;
s3 = (1.4+j*0.9);
s4 = 2;
s5 = 0;
s6 = -(1.3+j*0.3);
epsilon = 1e-6;

%formiranje cvorova%
cvor1 = {"SLACK", v1};
cvor2 = {"PV", [v2, p2]};
cvor3 = {"PQ", s3, "Nezavisan"};
cvor4 = {"PQ", s4, "Nezavisan"};
cvor5 = {"PQ", s5, "Nezavisan"};
cvor6 = {"PQ", s6, "Nezavisan"};
cvorovi = {cvor1; cvor2; cvor3; cvor4; cvor5; cvor6};

%pozivanje glavne funkcije%
[V, k_rez] = MSIalgoritam(cvorovi, y, epsilon);

%ispis rjesenja u komandni prozor%
if (size(V,1) ~= 0)
    Vpom = polarPrint(V)
    k_rez
end

