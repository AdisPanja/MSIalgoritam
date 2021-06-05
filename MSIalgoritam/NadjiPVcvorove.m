function PozicijaPVcvorova = NadjiPVcvorove(cvorovi)

    br = 0;
    
    for i=1:length(cvorovi)
       if (cvorovi{i,1}{1,1} == 'PV')
           br = br+1;
           PozicijaPVcvorova(br,1) = i;
       end
    end
    
    if (br == 0) PozicijaPVcvorova = zeros(0,0); %ukoliko nema PV cvorova, vrati prazan vektor
end