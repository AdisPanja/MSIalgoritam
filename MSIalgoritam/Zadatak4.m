%unos impedansi%
z12 = 0.05+j*0.09;
z23 = 0.0125+j*0.025;
z13 = 0.03+j*0.09;

%formiranje vektora admitansi%
y = [{1/z12,'1','2'}; {1/z23, '2','3'}; {1/z13,'1','3'}];

%unos parametara za SLACK, PQ i PV cvorove%
v1 = 1.05 + j*0;
epsilon = 1e-6;

%formiranje cvorova%
cvor1 = {"SLACK", v1};
cvor2 = {"PQ", [1,0.4,0.3,0.3;1,0.4,0.3,0.3], "Zavisan"};
cvor3 = {"PQ", [1,0.4,0.3,0.3;1,0.4,0.3,0.3], "Zavisan"};
cvorovi = {cvor1; cvor2; cvor3};

%pozivanje glavne funkcije%
V = MSIalgoritam(cvorovi, y, epsilon);

%ispis rjesenja u komandni prozor%
if (size(V,1) ~= 0)
    Vpom = polarPrint(V)
end