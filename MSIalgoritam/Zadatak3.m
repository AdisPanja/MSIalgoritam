%unos impedansi%
z12 = 0.02+j*0.06;
z13 = 0.0059+j*0.0235;
z23 = 0.0055+j*0.0183;

%formiranje vektora admitansi%
y = [{1/z12, '1', '2'}; {1/z13, '1','3'}; {1/z23, '2', '3'}];

%unos parametara za SLACK, PQ i PV cvorove%
v1 = 1.02+j*0;
s2 = 2+j*0.5;
v3 = 1.03;
p3 = 1.5;
epsilon = 1e-6;

%formiranje cvorova%
cvor1 = {"SLACK", v1};
cvor2 = {"PQ", s2, "Nezavisan"};
cvor3 = {"PV", [v3,p3]};
cvorovi = {cvor1; cvor2; cvor3};

%pozivanje glavne funkcije%
[V, k_rez] = MSIalgoritam(cvorovi, y, epsilon);

k_rez

%ispis rjesenja u komandni prozor%
if (size(V,1) ~= 0)
    Vpom = polarPrint(V)
    k_rez
end